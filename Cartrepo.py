from __future__ import annotations

import json
from dataclasses import asdict
from typing import Any

from infrastructure.redis_manager import RedisManager


# ============================================================
# Repository Exceptions (Clean Protocol)
# ============================================================

class RepositoryError(Exception):
    """Base exception for repository errors."""


class CartNotFoundError(RepositoryError):
    pass


class CartItemNotFoundError(RepositoryError):
    pass


class BranchMismatchError(RepositoryError):
    pass


class QuantityLimitExceededError(RepositoryError):
    pass


class CartDataCorruptionError(RepositoryError):
    pass


# ============================================================
# RedisCartRepository (Atomic & Enterprise Grade)
# ============================================================

class RedisCartRepository:

    _CART_KEY_PREFIX = "cart:"
    _BRANCH_FIELD = "__branch_id__"
    _ITEM_PREFIX = "item:"

    # ========================================================
    # Lua Scripts (Fully Atomic with Branch & Max Validation)
    # ========================================================

    # --------------------------------------------------------
    # Add Item Atomic Script
    # 
    # KEYS[1] = cart key
    # ARGV[1] = branch field
    # ARGV[2] = requested branch_id
    # ARGV[3] = item field (e.g., item:123)
    # ARGV[4] = serialized item json string
    # ARGV[5] = requested quantity to add
    # ARGV[6] = max allowed quantity (-1 or nil if unlimited)
    # ARGV[7] = TTL in seconds
    #
    # Return codes:
    #   -1 = Branch mismatch error
    #   -2 = Quantity limit exceeded
    #    1 = Created cart / Added new item / Incremented successfully
    # --------------------------------------------------------
    _ADD_ITEM_ATOMIC_SCRIPT = """
        local cart_exists = redis.call('EXISTS', KEYS[1])
        local req_branch = ARGV[2]
        local branch_field = ARGV[1]
        local item_field = ARGV[3]
        local item_json = ARGV[4]
        local add_qty = tonumber(ARGV[5])
        local max_limit = tonumber(ARGV[6])
        local ttl = tonumber(ARGV[7])

        if cart_exists == 1 then
            local existing_branch = redis.call('HGET', KEYS[1], branch_field)
            if existing_branch and existing_branch ~= req_branch then
                return -1
            end
        else
            redis.call('HSET', KEYS[1], branch_field, req_branch)
        end

        local current_qty = 0
        local raw_item = redis.call('HGET', KEYS[1], item_field)
        
        if raw_item then
            local item = cjson.decode(raw_item)
            current_qty = tonumber(item.quantity) or 0
        end

        local new_qty = current_qty + add_qty

        if max_limit and max_limit > 0 and new_qty > max_limit then
            return -2
        end

        if raw_item then
            local item = cjson.decode(raw_item)
            item.quantity = new_qty
            redis.call('HSET', KEYS[1], item_field, cjson.encode(item))
        else
            redis.call('HSET', KEYS[1], item_field, item_json)
        end

        redis.call('EXPIRE', KEYS[1], ttl)
        return 1
    """

    # --------------------------------------------------------
    # Adjust Item Quantity Atomic Script
    #
    # KEYS[1] = cart key
    # ARGV[1] = branch field
    # ARGV[2] = requested branch_id
    # ARGV[3] = item field
    # ARGV[4] = delta (can be positive or negative)
    # ARGV[5] = max allowed quantity (for positive delta check)
    # ARGV[6] = TTL
    #
    # Return codes:
    #   -1 = Cart does not exist
    #   -2 = Branch mismatch
    #   -3 = Item does not exist in cart
    #   -4 = Quantity limit exceeded
    #   -5 = Quantity would become negative or zero (handled by removal/deletion)
    #    >= 0 = New quantity
    # --------------------------------------------------------
    _ADJUST_QUANTITY_ATOMIC_SCRIPT = """
        if redis.call('EXISTS', KEYS[1]) == 0 then
            return -1
        end

        local branch_field = ARGV[1]
        local req_branch = ARGV[2]
        local item_field = ARGV[3]
        local delta = tonumber(ARGV[4])
        local max_limit = tonumber(ARGV[5])
        local ttl = tonumber(ARGV[6])

        local existing_branch = redis.call('HGET', KEYS[1], branch_field)
        if existing_branch and existing_branch ~= req_branch then
            return -2
        end

        local raw_item = redis.call('HGET', KEYS[1], item_field)
        if not raw_item then
            return -3
        end

        local item = cjson.decode(raw_item)
        local current_qty = tonumber(item.quantity) or 0
        local new_qty = current_qty + delta

        if delta > 0 and max_limit and max_limit > 0 and new_qty > max_limit then
            return -4
        end

        if new_qty <= 0 then
            redis.call('HDEL', KEYS[1], item_field)
        else
            item.quantity = new_qty
            redis.call('HSET', KEYS[1], item_field, cjson.encode(item))
        end

        -- If only branch metadata remains, delete the cart
        if redis.call('HLEN', KEYS[1]) == 1 then
            redis.call('DEL', KEYS[1])
            return 0
        else
            redis.call('EXPIRE', KEYS[1], ttl)
        end

        return new_qty
    """

    # --------------------------------------------------------
    # Remove Item Atomic Script
    # --------------------------------------------------------
    _REMOVE_ITEM_ATOMIC_SCRIPT = """
        if redis.call('EXISTS', KEYS[1]) == 0 then
            return -1
        end

        local branch_field = ARGV[1]
        local req_branch = ARGV[2]
        local item_field = ARGV[3]
        local ttl = tonumber(ARGV[4])

        local existing_branch = redis.call('HGET', KEYS[1], branch_field)
        if existing_branch and existing_branch ~= req_branch then
            return -2
        end

        local deleted = redis.call('HDEL', KEYS[1], item_field)
        if deleted == 0 then
            return -3
        end

        if redis.call('HLEN', KEYS[1]) == 1 then
            redis.call('DEL', KEYS[1])
        else
            redis.call('EXPIRE', KEYS[1], ttl)
        end

        return 1
    """

    # ========================================================
    # Constructor
    # ========================================================

    def __init__(
        self,
        redis_client: RedisManager,
        ttl_seconds: int = 60 * 60 * 24 * 30,
    ) -> None:

        if ttl_seconds <= 0:
            raise ValueError(
                "ttl_seconds must be greater than zero."
            )

        self._redis = redis_client
        self._ttl = ttl_seconds

        self._add_item_script = self._redis.register_script(
            self._ADD_ITEM_ATOMIC_SCRIPT
        )
        self._adjust_quantity_script = self._redis.register_script(
            self._ADJUST_QUANTITY_ATOMIC_SCRIPT
        )
        self._remove_item_script = self._redis.register_script(
            self._REMOVE_ITEM_ATOMIC_SCRIPT
        )

    # ========================================================
    # Key & Validation Helpers
    # ========================================================

    @classmethod
    def _build_key(
        cls,
        customer_id: int,
        session_id: str,
    ) -> str:
        return f"{cls._CART_KEY_PREFIX}{customer_id}:{session_id}"

    @classmethod
    def _item_field(
        cls,
        item_code: int,
    ) -> str:
        return f"{cls._ITEM_PREFIX}{item_code}"

    @staticmethod
    def _validate_customer_id(customer_id: int) -> None:
        if not isinstance(customer_id, int) or isinstance(customer_id, bool) or customer_id <= 0:
            raise ValueError("customer_id must be a positive integer.")

    @staticmethod
    def _validate_session_id(session_id: str) -> None:
        if not isinstance(session_id, str) or not session_id.strip():
            raise ValueError("session_id cannot be empty.")

    @staticmethod
    def _validate_branch_id(branch_id: int) -> None:
        if not isinstance(branch_id, int) or isinstance(branch_id, bool) or branch_id <= 0:
            raise ValueError("branch_id must be a positive integer.")

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
            item_code=int(data["item_code"]),
            sales_unit=str(data["sales_unit"]),
            quantity=int(data["quantity"]),
            unit_price=int(data["unit_price"]),
            name=str(data["name"]),
        )

    # ========================================================
    # Repository Methods Implementation
    # ========================================================

    async def get(
        self,
        customer_id: int,
        session_id: str,
    ) -> Cart | None:

        self._validate_customer_id(customer_id)
        self._validate_session_id(session_id)

        key = self._build_key(customer_id, session_id)
        raw_data = await self._redis.hgetall(key)

        if not raw_data:
            return None

        normalized_data = {
            (k.decode("utf-8") if isinstance(k, bytes) else k): v
            for k, v in raw_data.items()
        }

        branch_raw = normalized_data.get(self._BRANCH_FIELD)
        if branch_raw is None:
            raise CartDataCorruptionError(f"Cart {key!r} is missing branch metadata.")

        try:
            branch_str = branch_raw.decode("utf-8") if isinstance(branch_raw, bytes) else branch_raw
            branch_id = int(branch_str)
        except (TypeError, ValueError, UnicodeDecodeError) as exc:
            raise CartDataCorruptionError(f"Invalid branch_id in cart {key!r}.") from exc

        items: list[CartItem] = []
        for field, raw_item in normalized_data.items():
            if not field.startswith(self._ITEM_PREFIX):
                continue
            try:
                item = self._deserialize_item(raw_item)
            except (json.JSONDecodeError, KeyError, TypeError, ValueError) as exc:
                raise CartDataCorruptionError(f"Corrupted cart item in {key!r}") from exc
            items.append(item)

        return Cart(
            customer_id=customer_id,
            session_id=session_id,
            branch_id=branch_id,
            items=tuple(items),
        )

    async def add_item_atomic(
        self,
        customer_id: int,
        session_id: str,
        branch_id: int,
        item: CartItem,
        max_allowed_quantity: int | None,
    ) -> Cart:

        self._validate_customer_id(customer_id)
        self._validate_session_id(session_id)
        self._validate_branch_id(branch_id)

        key = self._build_key(customer_id, session_id)
        field = self._item_field(item.item_code)
        max_limit_val = max_allowed_quantity if max_allowed_quantity is not None else -1

        result = await self._add_item_script(
            keys=[key],
            args=[
                self._BRANCH_FIELD,
                str(branch_id),
                field,
                self._serialize_item(item),
                str(item.quantity),
                str(max_limit_val),
                str(self._ttl),
            ],
        )

        res_code = int(result)

        if res_code == -1:
            raise BranchMismatchError(
                f"Cart belongs to another branch. Cannot mix branches."
            )
        if res_code == -2:
            raise QuantityLimitExceededError(
                f"Quantity exceeds the maximum allowed limit ({max_allowed_quantity})."
            )

        # Return updated authoritative cart state
        cart = await self.get(customer_id, session_id)
        if cart is None:
            raise CartDataCorruptionError("Failed to retrieve cart after atomic add.")
        return cart

    async def adjust_item_quantity_atomic(
        self,
        customer_id: int,
        session_id: str,
        branch_id: int,
        item_code: int,
        delta: int,
        max_allowed_quantity: int | None = None,
    ) -> Cart | None:

        self._validate_customer_id(customer_id)
        self._validate_session_id(session_id)
        self._validate_branch_id(branch_id)

        key = self._build_key(customer_id, session_id)
        field = self._item_field(item_code)
        max_limit_val = max_allowed_quantity if max_allowed_quantity is not None else -1

        result = await self._adjust_quantity_script(
            keys=[key],
            args=[
                self._BRANCH_FIELD,
                str(branch_id),
                field,
                str(delta),
                str(max_limit_val),
                str(self._ttl),
            ],
        )

        res_code = int(result)

        if res_code == -1:
            raise CartNotFoundError("Cart does not exist.")
        if res_code == -2:
            raise BranchMismatchError("Branch mismatch for this cart.")
        if res_code == -3:
            raise CartItemNotFoundError(f"Item {item_code} is not in the cart.")
        if res_code == -4:
            raise QuantityLimitExceededError(
                f"Quantity increment exceeds maximum allowed limit ({max_allowed_quantity})."
            )

        if res_code == 0:
            return None  # Cart became empty and was deleted

        return await self.get(customer_id, session_id)

    async def remove_item_atomic(
        self,
        customer_id: int,
        session_id: str,
        branch_id: int,
        item_code: int,
    ) -> Cart | None:

        self._validate_customer_id(customer_id)
        self._validate_session_id(session_id)
        self._validate_branch_id(branch_id)

        key = self._build_key(customer_id, session_id)
        field = self._item_field(item_code)

        result = await self._remove_item_script(
            keys=[key],
            args=[
                self._BRANCH_FIELD,
                str(branch_id),
                field,
                str(self._ttl),
            ],
        )

        res_code = int(result)

        if res_code == -1:
            raise CartNotFoundError("Cart does not exist.")
        if res_code == -2:
            raise BranchMismatchError("Branch mismatch for this cart.")
        if res_code == -3:
            raise CartItemNotFoundError(f"Item {item_code} is not in the cart.")

        return await self.get(customer_id, session_id)

    async def clear(
        self,
        customer_id: int,
        session_id: str,
    ) -> None:
        self._validate_customer_id(customer_id)
        self._validate_session_id(session_id)

        key = self._build_key(customer_id, session_id)
        await self._redis.delete(key)
