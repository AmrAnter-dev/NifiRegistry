from __future__ import annotations

from dataclasses import asdict
from typing import Any


class ShoppingCartTool:
    """
    LLM-facing tool for adding products to the customer's shopping cart.

    Responsibilities:
    - Receive structured arguments from the LLM.
    - Delegate the operation to CartService.
    - Return a structured, LLM-friendly result.

    Business logic belongs to CartService.
    """

    name = "shopping_cart"

    description = """
    Add a product to the customer's shopping cart.

    Use this tool when the customer explicitly wants to add a product
    to their order.

    The item_code must be the exact product item_code returned by
    product search/resolution.

    requested_quantity must already be expressed in the product's
    sales_unit.

    Example:
    If the customer asks for 3 boxes and each box contains 2 strips,
    requested_quantity must be 6 when sales_unit is "strip".
    """

    def __init__(
        self,
        cart_service: CartService,
    ) -> None:
        self._cart_service = cart_service

    async def execute(
        self,
        *,
        customer_id: int,
        session_id: str,
        branch_name: str,
        item_code: int,
        requested_quantity: int,
    ) -> dict[str, Any]:

        cart = await self._cart_service.add_item(
            customer_id=customer_id,
            session_id=session_id,
            branch_name=branch_name,
            item_code=item_code,
            requested_quantity=requested_quantity,
        )

        return self._build_response(cart)

    @staticmethod
    def _build_response(cart: Cart) -> dict[str, Any]:
        return {
            "success": True,
            "customer_id": cart.customer_id,
            "session_id": cart.session_id,
            "branch_name": cart.branch_name,
            "items": [
                asdict(item)
                for item in cart.items
            ],
        }
