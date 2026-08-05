from __future__ import annotations

from dataclasses import dataclass
from enum import StrEnum
from typing import Protocol


# ============================================================
# Product Domain
# ============================================================

class ProductCategory(StrEnum):
    A = "A"
    B = "B"
    C = "C"


@dataclass(frozen=True, slots=True)
class ProductPolicy:
    category: ProductCategory
    online_orderable: bool


@dataclass(frozen=True, slots=True)
class Product:
    item_code: str
    name: str
    sales_unit: str
    package_quantity: int
    unit_price: int  # Minor currency units
    policy: ProductPolicy


# ============================================================
# Service Contracts
# ============================================================

class ProductService(Protocol):

    async def get_product(
        self,
        item_code: str,
    ) -> Product | None:
        ...


class InventoryService(Protocol):

    async def get_local_available(
        self,
        branch_id: int,
        item_code: str,
    ) -> int:
        ...


# ============================================================
# Cart Models
# ============================================================

@dataclass(frozen=True, slots=True)
class CartItem:
    item_code: str
    sales_unit: str
    quantity: int
    local_available: int
    unit_price: int
    name: str


@dataclass(frozen=True, slots=True)
class Cart:
    customer_id: int
    session_id: str
    branch_id: int
    items: list[CartItem]

    def __post_init__(self) -> None:

        if self.customer_id <= 0:
            raise ValueError(
                "customer_id must be greater than zero."
            )

        if not self.session_id:
            raise ValueError(
                "session_id cannot be empty."
            )

        if self.branch_id <= 0:
            raise ValueError(
                "branch_id must be greater than zero."
            )

        if not self.items:
            raise ValueError(
                "Cart cannot be empty."
            )

        seen_codes: set[str] = set()

        for item in self.items:

            if not item.item_code:
                raise ValueError(
                    "item_code cannot be empty."
                )

            if item.quantity <= 0:
                raise ValueError(
                    f"Cart item quantity for "
                    f"'{item.item_code}' must be "
                    "greater than zero."
                )

            if item.item_code in seen_codes:
                raise ValueError(
                    "Cart cannot contain duplicate "
                    f"item_code: '{item.item_code}'."
                )

            seen_codes.add(item.item_code)


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
# Business Exceptions
# ============================================================

class CartServiceError(Exception):
    """Base exception for CartService."""


class ProductNotFoundError(CartServiceError):
    pass


class ProductNotOrderableOnlineError(CartServiceError):
    pass


class InvalidQuantityError(CartServiceError):
    pass


class CategoryQuantityLimitError(CartServiceError):
    pass


class CartNotFoundError(CartServiceError):
    pass


class BranchMismatchError(CartServiceError):
    pass


class CartConcurrencyError(CartServiceError):
    pass


# ============================================================
# Cart Service
# ============================================================

class CartService:

    def __init__(
        self,
        cart_repository: CartRepository,
        product_service: ProductService,
        inventory_service: InventoryService,
    ) -> None:

        self._cart_repository = cart_repository
        self._product_service = product_service
        self._inventory_service = inventory_service

    # ========================================================
    # Public API
    # ========================================================

    async def get_cart(
        self,
        customer_id: int,
        session_id: str,
    ) -> Cart | None:

        self._validate_identity(
            customer_id,
            session_id,
        )

        return await self._cart_repository.get(
            customer_id,
            session_id,
        )

    async def add_item(
        self,
        customer_id: int,
        session_id: str,
        branch_id: int,
        item_code: str,
        quantity: int,
    ) -> Cart:

        self._validate_identity(
            customer_id,
            session_id,
        )

        self._validate_branch(branch_id)
        self._validate_item_code(item_code)

        # ----------------------------------------------------
        # 1. Resolve Product
        # ----------------------------------------------------

        product = await self._product_service.get_product(
            item_code
        )

        if product is None:
            raise ProductNotFoundError(
                f"Product '{item_code}' was not found."
            )

        # ----------------------------------------------------
        # 2. Validate Online Ordering
        # ----------------------------------------------------

        if not product.policy.online_orderable:
            raise ProductNotOrderableOnlineError(
                f"Product '{item_code}' cannot be "
                "ordered remotely."
            )

        # ----------------------------------------------------
        # 3. Get Existing Cart
        # ----------------------------------------------------

        cart = await self._cart_repository.get(
            customer_id,
            session_id,
        )

        # ----------------------------------------------------
        # 4. Cart doesn't exist
        # ----------------------------------------------------

        if cart is None:

            self._validate_requested_quantity(
                product,
                quantity,
            )

            local_available = (
                await self._inventory_service.get_local_available(
                    branch_id=branch_id,
                    item_code=item_code,
                )
            )

            item = self._build_cart_item(
                product=product,
                quantity=quantity,
                local_available=local_available,
            )

            new_cart = Cart(
                customer_id=customer_id,
                session_id=session_id,
                branch_id=branch_id,
                items=[item],
            )

            created = await self._cart_repository.create(
                new_cart
            )

            if created:
                return new_cart

            # Another concurrent request created it.
            # Re-read and continue through the existing-cart
            # path.
            cart = await self._cart_repository.get(
                customer_id,
                session_id,
            )

            if cart is None:
                raise CartConcurrencyError(
                    "Cart creation raced with another request "
                    "and could not be resolved."
                )

        # ----------------------------------------------------
        # 5. Existing Cart
        # ----------------------------------------------------

        self._validate_branch_consistency(
            cart,
            branch_id,
        )

        existing_item = self._find_item(
            cart,
            item_code,
        )

        # ----------------------------------------------------
        # 6. Existing item
        # ----------------------------------------------------

        if existing_item is not None:

            new_quantity = (
                existing_item.quantity + quantity
            )

            self._validate_requested_quantity(
                product,
                new_quantity,
            )

            try:
                await self._cart_repository.increment_item(
                    customer_id=customer_id,
                    session_id=session_id,
                    item_code=item_code,
                    quantity=quantity,
                )

            except KeyError as exc:
                # The item disappeared between our read and
                # atomic update.
                raise CartConcurrencyError(
                    f"Item '{item_code}' changed concurrently."
                ) from exc

        # ----------------------------------------------------
        # 7. New item in existing Cart
        # ----------------------------------------------------

        else:

            self._validate_requested_quantity(
                product,
                quantity,
            )

            local_available = (
                await self._inventory_service.get_local_available(
                    branch_id=branch_id,
                    item_code=item_code,
                )
            )

            item = self._build_cart_item(
                product=product,
                quantity=quantity,
                local_available=local_available,
            )

            try:
                added = (
                    await self._cart_repository.add_if_absent(
                        customer_id=customer_id,
                        session_id=session_id,
                        item=item,
                    )
                )

            except KeyError as exc:
                raise CartConcurrencyError(
                    "Cart disappeared during item insertion."
                ) from exc

            if not added:
                # Another request inserted the same item.
                # We deliberately don't perform a blind increment
                # because we must re-read and re-validate the
                # resulting quantity against ProductPolicy.
                latest = await self._cart_repository.get(
                    customer_id,
                    session_id,
                )

                if latest is None:
                    raise CartConcurrencyError(
                        "Cart disappeared during concurrent update."
                    )

                latest_item = self._find_item(
                    latest,
                    item_code,
                )

                if latest_item is None:
                    raise CartConcurrencyError(
                        "Concurrent item insertion could not "
                        "be resolved."
                    )

                new_quantity = (
                    latest_item.quantity + quantity
                )

                self._validate_requested_quantity(
                    product,
                    new_quantity,
                )

                await self._cart_repository.increment_item(
                    customer_id=customer_id,
                    session_id=session_id,
                    item_code=item_code,
                    quantity=quantity,
                )

        # ----------------------------------------------------
        # 8. Return authoritative Redis state
        # ----------------------------------------------------

        result = await self._cart_repository.get(
            customer_id,
            session_id,
        )

        if result is None:
            raise CartConcurrencyError(
                "Cart disappeared after successful mutation."
            )

        return result

    async def increment_item(
        self,
        customer_id: int,
        session_id: str,
        item_code: str,
        quantity: int,
    ) -> Cart:

        self._validate_identity(
            customer_id,
            session_id,
        )

        self._validate_item_code(item_code)

        if quantity <= 0:
            raise InvalidQuantityError(
                "Increment quantity must be greater than zero."
            )

        cart = await self._cart_repository.get(
            customer_id,
            session_id,
        )

        if cart is None:
            raise CartNotFoundError(
                "Cart does not exist."
            )

        item = self._find_item(
            cart,
            item_code,
        )

        if item is None:
            raise ProductNotFoundError(
                f"Item '{item_code}' is not in the cart."
            )

        product = await self._product_service.get_product(
            item_code
        )

        if product is None:
            raise ProductNotFoundError(
                f"Product '{item_code}' was not found."
            )

        new_quantity = item.quantity + quantity

        self._validate_requested_quantity(
            product,
            new_quantity,
        )

        try:
            await self._cart_repository.increment_item(
                customer_id=customer_id,
                session_id=session_id,
                item_code=item_code,
                quantity=quantity,
            )

        except KeyError as exc:
            raise CartConcurrencyError(
                f"Item '{item_code}' changed concurrently."
            ) from exc

        result = await self._cart_repository.get(
            customer_id,
            session_id,
        )

        if result is None:
            raise CartConcurrencyError(
                "Cart disappeared after increment."
            )

        return result

    async def remove_item(
        self,
        customer_id: int,
        session_id: str,
        item_code: str,
    ) -> Cart | None:

        self._validate_identity(
            customer_id,
            session_id,
        )

        self._validate_item_code(item_code)

        try:
            await self._cart_repository.remove_item(
                customer_id=customer_id,
                session_id=session_id,
                item_code=item_code,
            )

        except KeyError as exc:
            raise CartNotFoundError(
                "Cart does not exist."
            ) from exc

        return await self._cart_repository.get(
            customer_id,
            session_id,
        )

    async def clear_cart(
        self,
        customer_id: int,
        session_id: str,
    ) -> None:

        self._validate_identity(
            customer_id,
            session_id,
        )

        await self._cart_repository.clear(
            customer_id,
            session_id,
        )

    # ========================================================
    # Business Rules
    # ========================================================

    @staticmethod
    def _validate_requested_quantity(
        product: Product,
        quantity: int,
    ) -> None:

        if quantity <= 0:
            raise InvalidQuantityError(
                "Quantity must be greater than zero."
            )

        category = product.policy.category

        if category == ProductCategory.A:
            return

        if category == ProductCategory.B:

            if quantity > 1:
                raise CategoryQuantityLimitError(
                    f"Category B product '{product.item_code}' "
                    "is limited to one sales unit."
                )

            return

        if category == ProductCategory.C:

            if quantity > product.package_quantity:
                raise CategoryQuantityLimitError(
                    f"Category C product '{product.item_code}' "
                    f"is limited to one package "
                    f"({product.package_quantity} "
                    f"{product.sales_unit})."
                )

            return

        raise ValueError(
            f"Unsupported product category: {category!r}"
        )

    # ========================================================
    # Helpers
    # ========================================================

    @staticmethod
    def _build_cart_item(
        product: Product,
        quantity: int,
        local_available: int,
    ) -> CartItem:

        return CartItem(
            item_code=product.item_code,
            sales_unit=product.sales_unit,
            quantity=quantity,
            local_available=max(0, local_available),
            unit_price=product.unit_price,
            name=product.name,
        )

    @staticmethod
    def _find_item(
        cart: Cart,
        item_code: str,
    ) -> CartItem | None:

        for item in cart.items:
            if item.item_code == item_code:
                return item

        return None

    @staticmethod
    def _validate_identity(
        customer_id: int,
        session_id: str,
    ) -> None:

        if customer_id <= 0:
            raise ValueError(
                "customer_id must be greater than zero."
            )

        if not session_id:
            raise ValueError(
                "session_id cannot be empty."
            )

    @staticmethod
    def _validate_branch(
        branch_id: int,
    ) -> None:

        if branch_id <= 0:
            raise ValueError(
                "branch_id must be greater than zero."
            )

    @staticmethod
    def _validate_item_code(
        item_code: str,
    ) -> None:

        if not item_code.strip():
            raise ValueError(
                "item_code cannot be empty."
            )

    @staticmethod
    def _validate_branch_consistency(
        cart: Cart,
        branch_id: int,
    ) -> None:

        if cart.branch_id != branch_id:
            raise BranchMismatchError(
                f"Cart belongs to branch {cart.branch_id}, "
                f"not branch {branch_id}."
            )
