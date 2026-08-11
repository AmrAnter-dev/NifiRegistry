class CheckoutService:

    def __init__(
        self,
        shopping_cart_service,
        transfer_service,
        recommendation_engine,
        order_service,
    ):
        self.shopping_cart_service = shopping_cart_service
        self.transfer_service = transfer_service
        self.recommendation_engine = recommendation_engine
        self.order_service = order_service

    async def checkout(
        self,
        customer_id: int,
        session_id: str,
    ):

        # ==================================================
        # 1. Get Cart
        # ==================================================

        cart = await self.shopping_cart_service.get_cart(
            customer_id=customer_id,
            session_id=session_id,
        )

        if not cart or not cart.items:
            raise ValueError("Cart is empty")

        # ==================================================
        # 2. Fulfill ALL items in parallel
        # ==================================================

        plans = await asyncio.gather(
            *[
                self.transfer_service.fulfill_item(item)
                for item in cart.items
            ]
        )

        # ==================================================
        # 3. Find failed items
        # ==================================================

        failed_plans = [
            plan
            for plan in plans
            if not plan.fulfilled
        ]

        # ==================================================
        # 4. Recommendation Engine
        # Only for items that couldn't be fulfilled
        # ==================================================

        if failed_plans:

            recommendations = (
                await self.recommendation_engine
                .recommend_for_items(
                    [
                        plan.item
                        for plan in failed_plans
                    ]
                )
            )

            return {
                "status": "ACTION_REQUIRED",
                "reason": "ITEMS_UNAVAILABLE",
                "recommendations": recommendations,
            }

        # ==================================================
        # 5. Check if any item requires transfer
        # ==================================================

        transfer_plans = [
            plan
            for plan in plans
            if plan.requires_transfer
        ]

        # ==================================================
        # 6. Everything is local
        # No customer decision required
        # ==================================================

        if not transfer_plans:

            return await self.order_service.create_order(
                customer_id=customer_id,
                fulfillment_plans=plans,
            )

        # ==================================================
        # 7. Transfer exists
        # Customer must choose shipping behavior
        # ==================================================

        return {
            "status": "ACTION_REQUIRED",
            "reason": "TRANSFER_REQUIRED",
            "transfer_items": [
                self._build_transfer_item_response(plan)
                for plan in transfer_plans
            ],
            "options": [
                {
                    "id": "SEPARATE_SHIPMENT",
                    "description": (
                        "Send available items now and "
                        "transferred items separately."
                    ),
                },
                {
                    "id": "WAIT_FOR_ALL",
                    "description": (
                        "Wait until all transferred items "
                        "arrive and send everything together."
                    ),
                },
            ],
        }

    def _build_transfer_item_response(
        self,
        plan: FulfillmentPlan,
    ):
        return {
            "item_code": plan.item.item_code,
            "requested_quantity": plan.item.requested_quantity,
            "local_quantity": plan.local_quantity,
            "transfer_quantity": plan.transfer_quantity,
            "source": (
                plan.source.value
                if plan.source
                else None
            ),
        }
