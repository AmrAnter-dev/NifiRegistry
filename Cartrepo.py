from __future__ import annotations

import json
from dataclasses import asdict, dataclass
from typing import Any, Protocol

import redis.asyncio as aioredis


# ============================================================
# Domain Models
# ============================================================

@dataclass(frozen=True, slots=True)
class CartItem:
    item_code: str
    sales_unit: str
    quantity: int
    local_available: int
    unit_price: int  # Minor units
    name: str


@dataclass(frozen=True, slots=True)
class Cart:
    customer_id: int
    session_id: str
    branch_id: int
    items: list[CartItem]


# ============================================================
# Exceptions
# ============================================================

class CartDataCorruptionError(RuntimeError):
    """Raised when persisted cart data cannot be safely deserialized."""
    pass


# ============================================================
# Repository Contract
# ============================================================

class CartRepository(Protocol):

    async def get(
        self,
        customer_id: int,
        session_id: str,
    ) -> Cart | None:
        ...

    async def create(
        self,
        cart: Cart,
    ) -> bool:
        ...

    async def add_if_absent(
        self,
        customer_id: int,
        session_id: str,
        item: CartItem,
    ) -> bool:
        ...

    async def increment_item(
        self,
        customer_id: int,
        session_id: str,
        item_code: str,
        quantity: int,
    ) -> int:
        ...

    async def remove_item(
        self,
        customer_id: int,
        session_id: str,
        item_code: str,
    ) -> bool:
        ...

    async def clear(
        self,
        customer_id: int,
        session_id: str,
    ) -> None:
        ...


# ============================================================
# RedisCartRepository
# ============================================================

class RedisCartRepository:
    """Production-grade Redis implementation of CartRepository using Lua Scripts."""

    _BRANCH_FIELD = "__branch_id__"
    _ITEM_PREFIX = "item:"

    _CREATE_SCRIPT = """
        if redis.call('EXISTS', KEYS[1]) == 1 then
            return 0
        end

        redis.call('HSET', KEYS[1], ARGV[1], ARGV[2])

        local i = 3
        while i < #ARGV do
            redis.call('HSET', KEYS[1], ARGV[i], ARGV[i + 1])
            i = i + 2
        end

        redis.call('EXPIRE', KEYS[1], ARGV[#ARGV])
        return 1
    """

    _ADD_IF_ABSENT_SCRIPT = """
        if redis.call('EXISTS', KEYS[1]) == 0 then
            return -1
        end

        if redis.call('HEXISTS', KEYS[1], ARGV[1]) == 1 then
            return 0
        end

        redis.call('HSET', KEYS[1], ARGV[1], ARGV[2])
        redis.call('EXPIRE', KEYS[1], ARGV[3])
        return 1
    """

    _INCREMENT_SCRIPT = """
        if redis.call('EXISTS', KEYS[1]) == 0 then
            return -1
        end

        local raw = redis.call('HGET', KEYS[1], ARGV[1])
        if not raw then
            return -2
        end

        local item = cjson.decode(raw)
        local new_quantity = tonumber(item.quantity) + tonumber(ARGV[2])

        if new_quantity < 0 then
            return -3
        end

        if new_quantity == 0 then
            redis.call('HDEL', KEYS[1], ARGV[1])
        else
            item.quantity = new_quantity
            redis.call('HSET', KEYS[1], ARGV[1], cjson.encode(item))
        end

        if redis.call('HLEN', KEYS[1]) == 1 then
            redis.call('DEL', KEYS[1])
        else
            redis.call('EXPIRE', KEYS[1], ARGV[3])
        end

        return new_quantity
    """

    _REMOVE_SCRIPT = """
        if redis.call('EXISTS', KEYS[1]) == 0 then
            return -1
        end

        local deleted = redis.call('HDEL', KEYS[1], ARGV[1])

        if redis.call('HLEN', KEYS[1]) == 1 then
            redis.call('DEL', KEYS[1])
        else
            redis.call('EXPIRE', KEYS[1], ARGV[2])
        end

        return deleted
    """

    def __init__(
        self,
        redis_client: aioredis.Redis,
        ttl_seconds: int = 60 * 60 * 24 * 30,
    ) -> None:
        if ttl_seconds <= 0:
            raise ValueError("ttl_seconds must be greater than zero.")

        self._redis = redis_client
        self._ttl = ttl_seconds

        # Register scripts correctly
        self._create_script = self._redis.register_script(self._CREATE_SCRIPT)
        self._add_if_absent_script = self._redis.register_script(self._ADD_IF_ABSENT_SCRIPT)
        self._increment_script = self._redis.register_script(self._INCREMENT_SCRIPT)
        self._remove_script = self._redis.register_script(self._REMOVE_SCRIPT)

    @classmethod
    def _build_key(cls, customer_id: int, session_id: str) -> str:
        return f"cart:{customer_id}:{session_id}"

    @classmethod
    def _item_field(cls, item_code: str) -> str:
        return f"{cls._ITEM_PREFIX}{item_code}"

    @staticmethod
    def _serialize_item(item: CartItem) -> str:
        return json.dumps(
            asdict(item),
            ensure_ascii=False,
            separators=(",", ":"),
        )

    @staticmethod
    def _deserialize_item(raw: bytes | str) -> CartItem:
        if isinstance(raw, bytes):
            raw = raw.decode("utf-8")

        data: dict[str, Any] = json.loads(raw)

        return CartItem(
            item_code=str(data["item_code"]),
            sales_unit=str(data["sales_unit"]),
            quantity=int(data["quantity"]),
            local_available=int(data["local_available"]),
            unit_price=int(data["unit_price"]),
            name=str(data["name"]),
        )

    async def get(
        self,
        customer_id: int,
        session_id: str,
    ) -> Cart | None:
        key = self._build_key(customer_id, session_id)
        raw_data = await self._redis.hgetall(key)

        if not raw_data:
            return None

        # Convert keys to string representation for safety
        normalized_data: dict[str, bytes | str] = {
            (k.decode("utf-8") if isinstance(k, bytes) else k): v
            for k, v in raw_data.items()
        }

        branch_raw = normalized_data.get(self._BRANCH_FIELD)

        if branch_raw is None:
            raise CartDataCorruptionError(
                f"Cart {key!r} is missing branch metadata."
            )

        try:
            branch_str = (
                branch_raw.decode("utf-8")
                if isinstance(branch_raw, bytes)
                else branch_raw
            )
            branch_id = int(branch_str)
        except (TypeError, ValueError) as exc:
            raise CartDataCorruptionError(
                f"Invalid branch_id in cart {key!r}."
            ) from exc

        items: list[CartItem] = []

        for field, raw_item in normalized_data.items():
            if not field.startswith(self._ITEM_PREFIX):
                continue

            try:
                item = self._deserialize_item(raw_item)
            except (
                json.JSONDecodeError,
                KeyError,
                TypeError,
                ValueError,
                UnicodeDecodeError,
            ) as exc:
                raise CartDataCorruptionError(
                    f"Corrupted cart item detected: key={key!r}, field={field!r}"
                ) from exc

            items.append(item)

        return Cart(
            customer_id=customer_id,
            session_id=session_id,
            branch_id=branch_id,
            items=items,
        )

    async def create(
        self,
        cart: Cart,
    ) -> bool:
        if not cart.items:
            raise ValueError("Cannot create an empty cart.")

        key = self._build_key(cart.customer_id, cart.session_id)

        args: list[Any] = [
            self._BRANCH_FIELD,
            str(cart.branch_id),
        ]

        for item in cart.items:
            args.extend([
                self._item_field(item.item_code),
                self._serialize_item(item),
            ])

        args.append(str(self._ttl))

        result = await self._create_script(keys=[key], args=args)
        return bool(int(result))

    async def add_if_absent(
        self,
        customer_id: int,
        session_id: str,
        item: CartItem,
    ) -> bool:
        key = self._build_key(customer_id, session_id)
        field = self._item_field(item.item_code)

        result = await self._add_if_absent_script(
            keys=[key],
            args=[
                field,
                self._serialize_item(item),
                str(self._ttl),
            ],
        )

        res_code = int(result)
        if res_code == -1:
            raise KeyError("Cart does not exist.")

        return res_code == 1

    async def increment_item(
        self,
        customer_id: int,
        session_id: str,
        item_code: str,
        quantity: int,
    ) -> int:
        if quantity == 0:
            raise ValueError("quantity cannot be zero.")

        key = self._build_key(customer_id, session_id)
        field = self._item_field(item_code)

        result = await self._increment_script(
            keys=[key],
            args=[
                field,
                str(quantity),
                str(self._ttl),
            ],
        )

        res_code = int(result)
        if res_code == -1:
            raise KeyError("Cart does not exist.")

        if res_code == -2:
            raise KeyError(f"Item {item_code!r} does not exist in cart.")

        if res_code == -3:
            raise ValueError("Cart item quantity cannot become negative.")

        return res_code

    async def remove_item(
        self,
        customer_id: int,
        session_id: str,
        item_code: str,
    ) -> bool:
        key = self._build_key(customer_id, session_id)
        field = self._item_field(item_code)

        result = await self._remove_script(
            keys=[key],
            args=[
                field,
                str(self._ttl),
            ],
        )

        res_code = int(result)
        if res_code == -1:
            raise KeyError("Cart does not exist.")

        return res_code == 1

    async def clear(
        self,
        customer_id: int,
        session_id: str,
    ) -> None:
        key = self._build_key(customer_id, session_id)
        await self._redis.delete(key)
