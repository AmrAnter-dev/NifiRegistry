```python
from __future__ import annotations

import json
from dataclasses import asdict
from typing import Any, Protocol

from infrastructure.redis_manager import RedisManager


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
        item_code: int,
        quantity: int,
    ) -> int:
        ...

    async def remove_item(
        self,
        customer_id: int,
        session_id: str,
        item_code: int,
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

    _CART_KEY_PREFIX = "cart:"
    _BRANCH_FIELD = "__branch_id__"
    _ITEM_PREFIX = "item:"

    # ========================================================
    # Lua Scripts
    # ========================================================

    # --------------------------------------------------------
    # Create cart
    #
    # ARGV:
    #   1 = branch field
    #   2 = branch id
    #   3..N-1 = item field/value pairs
    #   N = TTL
    # --------------------------------------------------------

    _CREATE_SCRIPT = """
        if redis.call('EXISTS', KEYS[1]) == 1 then
            return 0
        end

        redis.call('HSET', KEYS[1], ARGV[1], ARGV[2])

        local i = 3

        while i < #ARGV do
            redis.call(
                'HSET',
                KEYS[1],
                ARGV[i],
                ARGV[i + 1]
            )

            i = i + 2
        end

        redis.call(
            'EXPIRE',
            KEYS[1],
            tonumber(ARGV[#ARGV])
        )

        return 1
    """

    # --------------------------------------------------------
    # Add item only if it does not already exist.
    #
    # Return:
    #   -1 = cart does not exist
    #    0 = item already exists
    #    1 = item added
    # --------------------------------------------------------

    _ADD_IF_ABSENT_SCRIPT = """
        if redis.call('EXISTS', KEYS[1]) == 0 then
            return -1
        end

        if redis.call('HEXISTS', KEYS[1], ARGV[1]) == 1 then

            -- Sliding expiration:
            -- any cart interaction keeps the cart alive.
            redis.call(
                'EXPIRE',
                KEYS[1],
                tonumber(ARGV[3])
            )

            return 0
        end

        redis.call(
            'HSET',
            KEYS[1],
            ARGV[1],
            ARGV[2]
        )

        redis.call(
            'EXPIRE',
            KEYS[1],
            tonumber(ARGV[3])
        )

        return 1
    """

    # --------------------------------------------------------
    # Increment/decrement item quantity.
    #
    # Return:
    #   -1 = cart does not exist
    #   -2 = item does not exist
    #   -3 = quantity would become negative
    #   >=0 = new quantity
    # --------------------------------------------------------

    _INCREMENT_SCRIPT = """
        if redis.call('EXISTS', KEYS[1]) == 0 then
            return -1
        end

        local raw = redis.call(
            'HGET',
            KEYS[1],
            ARGV[1]
        )

        if not raw then
            return -2
        end

        local item = cjson.decode(raw)

        local current_quantity = tonumber(item.quantity)
        local delta = tonumber(ARGV[2])

        if not current_quantity or not delta then
            return -4
        end

        local new_quantity = current_quantity + delta

        if new_quantity < 0 then
            return -3
        end

        if new_quantity == 0 then

            redis.call(
                'HDEL',
                KEYS[1],
                ARGV[1]
            )

        else

            item.quantity = new_quantity

            redis.call(
                'HSET',
                KEYS[1],
                ARGV[1],
                cjson.encode(item)
            )

        end

        -- Cart contains only branch metadata.
        if redis.call('HLEN', KEYS[1]) == 1 then

            redis.call(
                'DEL',
                KEYS[1]
            )

        else

            redis.call(
                'EXPIRE',
                KEYS[1],
                tonumber(ARGV[3])
            )

        end

        return new_quantity
    """

    # --------------------------------------------------------
    # Remove item.
    #
    # Return:
    #   -1 = cart does not exist
    #    0 = item did not exist
    #    1 = item removed
    # --------------------------------------------------------

    _REMOVE_SCRIPT = """
        if redis.call('EXISTS', KEYS[1]) == 0 then
            return -1
        end

        local deleted = redis.call(
            'HDEL',
            KEYS[1],
            ARGV[1]
        )

        -- IMPORTANT:
        -- Only delete the cart if an item was actually removed
        -- and branch metadata is the only remaining field.

        if deleted == 1 then

            if redis.call('HLEN', KEYS[1]) == 1 then

                redis.call(
                    'DEL',
                    KEYS[1]
                )

            else

                redis.call(
                    'EXPIRE',
                    KEYS[1],
                    tonumber(ARGV[2])
                )

            end

        else

            -- Item wasn't present.
            -- Keep cart alive because this is still a cart interaction.
            redis.call(
                'EXPIRE',
                KEYS[1],
                tonumber(ARGV[2])
            )

        end

        return deleted
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

        self._create_script = self._redis.register_script(
            self._CREATE_SCRIPT
        )

        self._add_if_absent_script = self._redis.register_script(
            self._ADD_IF_ABSENT_SCRIPT
        )

        self._increment_script = self._redis.register_script(
            self._INCREMENT_SCRIPT
        )

        self._remove_script = self._redis.register_script(
            self._REMOVE_SCRIPT
        )

    # ========================================================
    # Key Helpers
    # ========================================================

    @classmethod
    def _build_key(
        cls,
        customer_id: int,
        session_id: str,
    ) -> str:

        return (
            f"{cls._CART_KEY_PREFIX}"
            f"{customer_id}:"
            f"{session_id}"
        )

    @classmethod
    def _item_field(
        cls,
        item_code: int,
    ) -> str:

        return f"{cls._ITEM_PREFIX}{item_code}"

    # ========================================================
    # Validation
    # ========================================================

    @staticmethod
    def _validate_customer_id(
        customer_id: int,
    ) -> None:

        if not isinstance(customer_id, int):
            raise TypeError(
                "customer_id must be an integer."
            )

        if customer_id <= 0:
            raise ValueError(
                "customer_id must be greater than zero."
            )

    @staticmethod
    def _validate_session_id(
        session_id: str,
    ) -> None:

        if not isinstance(session_id, str):
            raise TypeError(
                "session_id must be a string."
            )

        if not session_id.strip():
            raise ValueError(
                "session_id cannot be empty."
            )

    @staticmethod
    def _validate_branch_id(
        branch_id: int,
    ) -> None:

        if not isinstance(branch_id, int):
            raise TypeError(
                "branch_id must be an integer."
            )

        if branch_id <= 0:
            raise ValueError(
                "branch_id must be greater than zero."
            )

    @staticmethod
    def _validate_item(
        item: CartItem,
    ) -> None:

        if not isinstance(item.item_code, int):
            raise TypeError(
                "item_code must be an integer."
            )

        if item.item_code <= 0:
            raise ValueError(
                "item_code must be greater than zero."
            )

        if not isinstance(item.quantity, int):
            raise TypeError(
                "quantity must be an integer."
            )

        if item.quantity <= 0:
            raise ValueError(
                "quantity must be greater than zero."
            )

        if not isinstance(item.local_available, int):
            raise TypeError(
                "local_available must be an integer."
            )

        if item.local_available < 0:
            raise ValueError(
                "local_available cannot be negative."
            )

        if not isinstance(item.unit_price, int):
            raise TypeError(
                "unit_price must be an integer."
            )

        if item.unit_price < 0:
            raise ValueError(
                "unit_price cannot be negative."
            )

        if not isinstance(item.sales_unit, str):
            raise TypeError(
                "sales_unit must be a string."
            )

        if not item.sales_unit.strip():
            raise ValueError(
                "sales_unit cannot be empty."
            )

        if not isinstance(item.name, str):
            raise TypeError(
                "name must be a string."
            )

        if not item.name.strip():
            raise ValueError(
                "name cannot be empty."
            )

    # ========================================================
    # Serialization
    # ========================================================

    @staticmethod
    def _serialize_item(
        item: CartItem,
    ) -> str:

        RedisCartRepository._validate_item(item)

        return json.dumps(
            asdict(item),
            ensure_ascii=False,
            separators=(",", ":"),
        )

    @staticmethod
    def _deserialize_item(
        raw: bytes | str,
    ) -> CartItem:

        if isinstance(raw, bytes):
            raw = raw.decode("utf-8")

        data: dict[str, Any] = json.loads(raw)

        item_code = data["item_code"]

        if isinstance(item_code, bool):
            raise ValueError(
                "item_code cannot be boolean."
            )

        item_code = int(item_code)

        item = CartItem(
            item_code=item_code,
            sales_unit=str(data["sales_unit"]),
            quantity=int(data["quantity"]),
            local_available=int(data["local_available"]),
            unit_price=int(data["unit_price"]),
            name=str(data["name"]),
        )

        RedisCartRepository._validate_item(item)

        return item

    # ========================================================
    # Get Cart
    # ========================================================

    async def get(
        self,
        customer_id: int,
        session_id: str,
    ) -> Cart | None:

        self._validate_customer_id(customer_id)
        self._validate_session_id(session_id)

        key = self._build_key(
            customer_id,
            session_id,
        )

        raw_data = await self._redis.hgetall(key)

        if not raw_data:
            return None

        normalized_data: dict[
            str,
            bytes | str,
        ] = {
            (
                k.decode("utf-8")
                if isinstance(k, bytes)
                else k
            ): v
            for k, v in raw_data.items()
        }

        # ----------------------------------------------------
        # Branch metadata
        # ----------------------------------------------------

        branch_raw = normalized_data.get(
            self._BRANCH_FIELD
        )

        if branch_raw is None:
            raise CartDataCorruptionError(
                f"Cart {key!r} is missing "
                f"branch metadata."
            )

        try:

            branch_str = (
                branch_raw.decode("utf-8")
                if isinstance(branch_raw, bytes)
                else branch_raw
            )

            branch_id = int(branch_str)

        except (
            TypeError,
            ValueError,
            UnicodeDecodeError,
        ) as exc:

            raise CartDataCorruptionError(
                f"Invalid branch_id "
                f"in cart {key!r}."
            ) from exc

        if branch_id <= 0:
            raise CartDataCorruptionError(
                f"Invalid branch_id "
                f"in cart {key!r}."
            )

        # ----------------------------------------------------
        # Items
        # ----------------------------------------------------

        items: list[CartItem] = []

        for field, raw_item in normalized_data.items():

            if not field.startswith(
                self._ITEM_PREFIX
            ):
                continue

            try:

                item = self._deserialize_item(
                    raw_item
                )

            except (
                json.JSONDecodeError,
                KeyError,
                TypeError,
                ValueError,
                UnicodeDecodeError,
            ) as exc:

                raise CartDataCorruptionError(
                    "Corrupted cart item detected: "
                    f"key={key!r}, "
                    f"field={field!r}"
                ) from exc

            # ------------------------------------------------
            # Ensure Redis field matches item_code.
            #
            # item:123
            # must contain item_code=123
            # ------------------------------------------------

            expected_field = self._item_field(
                item.item_code
            )

            if field != expected_field:
                raise CartDataCorruptionError(
                    "Cart item field does not match "
                    f"item_code: "
                    f"field={field!r}, "
                    f"item_code={item.item_code!r}"
                )

            items.append(item)

        return Cart(
            customer_id=customer_id,
            session_id=session_id,
            branch_id=branch_id,
            items=items,
        )

    # ========================================================
    # Create
    # ========================================================

    async def create(
        self,
        cart: Cart,
    ) -> bool:

        self._validate_customer_id(
            cart.customer_id
        )

        self._validate_session_id(
            cart.session_id
        )

        self._validate_branch_id(
            cart.branch_id
        )

        if not cart.items:
            raise ValueError(
                "Cannot create an empty cart."
            )

        # ----------------------------------------------------
        # Prevent duplicate item_code values.
        # ----------------------------------------------------

        item_codes: set[int] = set()

        for item in cart.items:

            self._validate_item(item)

            if item.item_code in item_codes:
                raise ValueError(
                    "Duplicate item_code in cart: "
                    f"{item.item_code}"
                )

            item_codes.add(item.item_code)

        key = self._build_key(
            cart.customer_id,
            cart.session_id,
        )

        args: list[Any] = [
            self._BRANCH_FIELD,
            str(cart.branch_id),
        ]

        for item in cart.items:

            args.extend(
                [
                    self._item_field(
                        item.item_code
                    ),
                    self._serialize_item(item),
                ]
            )

        args.append(str(self._ttl))

        result = await self._create_script(
            keys=[key],
            args=args,
        )

        return bool(int(result))

    # ========================================================
    # Add Item
    # ========================================================

    async def add_if_absent(
        self,
        customer_id: int,
        session_id: str,
        item: CartItem,
    ) -> bool:

        self._validate_customer_id(customer_id)
        self._validate_session_id(session_id)
        self._validate_item(item)

        key = self._build_key(
            customer_id,
            session_id,
        )

        field = self._item_field(
            item.item_code
        )

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
            raise KeyError(
                "Cart does not exist."
            )

        return res_code == 1

    # ========================================================
    # Increment / Decrement Quantity
    # ========================================================

    async def increment_item(
        self,
        customer_id: int,
        session_id: str,
        item_code: int,
        quantity: int,
    ) -> int:

        self._validate_customer_id(customer_id)
        self._validate_session_id(session_id)

        if not isinstance(item_code, int):
            raise TypeError(
                "item_code must be an integer."
            )

        if item_code <= 0:
            raise ValueError(
                "item_code must be greater than zero."
            )

        if not isinstance(quantity, int):
            raise TypeError(
                "quantity must be an integer."
            )

        if quantity == 0:
            raise ValueError(
                "quantity cannot be zero."
            )

        key = self._build_key(
            customer_id,
            session_id,
        )

        field = self._item_field(
            item_code
        )

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
            raise KeyError(
                "Cart does not exist."
            )

        if res_code == -2:
            raise KeyError(
                f"Item {item_code!r} "
                "does not exist in cart."
            )

        if res_code == -3:
            raise ValueError(
                "Cart item quantity "
                "cannot become negative."
            )

        if res_code == -4:
            raise CartDataCorruptionError(
                f"Invalid quantity data "
                f"for item {item_code!r}."
            )

        return res_code

    # ========================================================
    # Remove Item
    # ========================================================

    async def remove_item(
        self,
        customer_id: int,
        session_id: str,
        item_code: int,
    ) -> bool:

        self._validate_customer_id(customer_id)
        self._validate_session_id(session_id)

        if not isinstance(item_code, int):
            raise TypeError(
                "item_code must be an integer."
            )

        if item_code <= 0:
            raise ValueError(
                "item_code must be greater than zero."
            )

        key = self._build_key(
            customer_id,
            session_id,
        )

        field = self._item_field(
            item_code
        )

        result = await self._remove_script(
            keys=[key],
            args=[
                field,
                str(self._ttl),
            ],
        )

        res_code = int(result)

        if res_code == -1:
            raise KeyError(
                "Cart does not exist."
            )

        return res_code == 1

    # ========================================================
    # Clear Cart
    # ========================================================

    async def clear(
        self,
        customer_id: int,
        session_id: str,
    ) -> None:

        self._validate_customer_id(customer_id)
        self._validate_session_id(session_id)

        key = self._build_key(
            customer_id,
            session_id,
        )

        await self._redis.delete(key)
```
