import asyncio
from typing import Any, Dict, List, Optional


class CheckoutService:

    def __init__(
        self,
        shopping_cart_service,
        transfer_service,
        recommendation_engine,
        order_service,
        checkout_repository,
        lock_manager: RedisLockManager,
    ):
        self.shopping_cart_service = shopping_cart_service
        self.transfer_service = transfer_service
        self.recommendation_engine = recommendation_engine
        self.order_service = order_service
        self.checkout_repository = checkout_repository
        self.lock_manager = lock_manager

    async def checkout(
        self,
        customer_id: int,
        session_id: str,
        checkout_id: str,
        idempotency_key: str,
    ) -> Dict[str, Any]:

        lock_key = f"checkout:{idempotency_key}"
        try:
            async with self.lock_manager.acquire_lock(
                lock_key, timeout_seconds=15, wait_timeout=3.0
            ):

            # 1. Idempotency Check
            existing = await self.checkout_repository.get_by_idempotency_key(
                idempotency_key
            )
            if existing:
                return existing.response_payload  # إرجاع الاستجابة المحفوظة بدلاً من الكائن المباشر
    
            # 2. Get Cart
            cart = await self.shopping_cart_service.get_cart(
                customer_id=customer_id,
                session_id=session_id,
            )
    
            if not cart or not cart.items:
                raise ValueError("Cart is empty")
    
            # 3. Fulfill ALL cart items in parallel (with exception handling)
            results = await asyncio.gather(
                *[self.transfer_service.fulfill_item(item) for item in cart.items],
                return_exceptions=True,
            )
    
            plans = []
            for res in results:
                if isinstance(res, Exception):
                    # التعامل مع الأخطاء غير المتوقعة في الفحص
                    raise res
                plans.append(res)
    
            # 4. Items that could not be fully fulfilled
            failed_plans = [plan for plan in plans if not plan.fulfilled]
    
            # 5. Recommendation Engine Handling
            if failed_plans:
                recommendations = (
                    await self.recommendation_engine.recommend_for_items(
                        [plan.item for plan in failed_plans]
                    )
                )
    
                response_data = {
                    "checkout_id": checkout_id,
                    "status": CheckoutStatus.ACTION_REQUIRED,
                    "failed_items": [
                        self._item_response(plan) for plan in failed_plans
                    ],
                    "recommendations": recommendations,
                }
    
                await self.checkout_repository.save(
                    checkout_id=checkout_id,
                    idempotency_key=idempotency_key,
                    status=CheckoutStatus.ACTION_REQUIRED,
                    fulfillment_plans=plans,
                    response_payload=response_data,
                )
    
                return response_data
    
            # 6. Check for Transfers
            transfer_plans = [plan for plan in plans if plan.transfer_allocations]
    
            # 7. Everything local
            if not transfer_plans:
                order = await self.order_service.create_order(
                    customer_id=customer_id,
                    checkout_id=checkout_id,
                    fulfillment_plans=plans,
                )
    
                await self.checkout_repository.save(
                    checkout_id=checkout_id,
                    idempotency_key=idempotency_key,
                    status=CheckoutStatus.COMPLETED,
                    fulfillment_plans=plans,
                    response_payload=order,
                )
    
                # تفريغ السلة بعد نجاح الطلب
                await self.shopping_cart_service.clear_cart(
                    customer_id=customer_id, session_id=session_id
                )
    
                return order
    
            # 8. Transfer exists
            response_data = {
                "checkout_id": checkout_id,
                "status": CheckoutStatus.ACTION_REQUIRED,
                "reason": "TRANSFER_REQUIRED",
                "transfer_items": [
                    self._transfer_item_response(plan) for plan in transfer_plans
                ],
                "options": [
                    {
                        "id": ShipmentOption.SEPARATE_SHIPMENT,
                        "description": (
                            "Send available items now and transferred items"
                            " separately."
                        ),
                        "additional_transfer_fee": 0,
                        "additional_delivery_fee": 0,
                    },
                    {
                        "id": ShipmentOption.WAIT_FOR_ALL,
                        "description": (
                            "Wait until transferred items arrive and send"
                            " everything together."
                        ),
                        "additional_transfer_fee": 0,
                        "additional_delivery_fee": 0,
                    },
                ],
            }
    
            await self.checkout_repository.save(
                checkout_id=checkout_id,
                idempotency_key=idempotency_key,
                status=CheckoutStatus.ACTION_REQUIRED,
                fulfillment_plans=plans,
                response_payload=response_data,
            )
    
            return response_data
        except LockAcquisitionError:
            # في حال وصول طلب مكرر في نفس اللحظة ولم يستطع أخذ القفل
            raise ValueError(
                "Another transaction is currently processing for this request. Please try again."
            )

    async def confirm_checkout(
        self,
        checkout_id: str,
        shipment_option: ShipmentOption,
    ) -> Dict[str, Any]:

        checkout = await self.checkout_repository.get(checkout_id)

        if not checkout:
            raise ValueError("Checkout not found")

        if checkout.status != CheckoutStatus.ACTION_REQUIRED:
            raise ValueError("Checkout is not waiting for customer action")

        plans = checkout.fulfillment_plans

        if shipment_option == ShipmentOption.SEPARATE_SHIPMENT:
            local_plans = [
                plan for plan in plans if not plan.transfer_allocations
            ]
            transfer_plans = [
                plan for plan in plans if plan.transfer_allocations
            ]

            executable_order = None
            if local_plans:
                executable_order = await self.order_service.create_order(
                    checkout_id=checkout_id,
                    fulfillment_plans=local_plans,
                    status=OrderStatus.READY_FOR_EXECUTION,
                )

            pending_order = None
            if transfer_plans:
                pending_order = await self.order_service.create_order(
                    checkout_id=checkout_id,
                    fulfillment_plans=transfer_plans,
                    status=OrderStatus.PENDING_FOR_TRANSFER,
                )

            await self.checkout_repository.update_status(
                checkout_id=checkout_id,
                status=CheckoutStatus.COMPLETED,
            )

            return {
                "status": CheckoutStatus.COMPLETED,
                "shipment_option": shipment_option,
                "executable_order": executable_order,
                "pending_order": pending_order,
            }

        if shipment_option == ShipmentOption.WAIT_FOR_ALL:
            order = await self.order_service.create_order(
                checkout_id=checkout_id,
                fulfillment_plans=plans,
                status=OrderStatus.PENDING_FOR_TRANSFER,
            )

            await self.checkout_repository.update_status(
                checkout_id=checkout_id,
                status=CheckoutStatus.PENDING_FOR_TRANSFER,
            )

            return order

        raise ValueError(f"Unsupported shipment option: {shipment_option}")

    def _item_response(
        self,
        plan: FulfillmentPlan,
    ) -> Dict[str, Any]:
        fulfilled_quantity = plan.local_quantity + sum(
            allocation.quantity for allocation in plan.transfer_allocations
        )

        return {
            "item_code": plan.item.item_code,
            "requested_quantity": plan.item.requested_quantity,
            "fulfilled_quantity": fulfilled_quantity,
            "available_quantity": fulfilled_quantity,
        }

    def _transfer_item_response(
        self,
        plan: FulfillmentPlan,
    ) -> Dict[str, Any]:
        return {
            "item_code": plan.item.item_code,
            "requested_quantity": plan.item.requested_quantity,
            "local_quantity": plan.local_quantity,
            "transfer_allocations": [
                {
                    "source_id": allocation.source_id,
                    "quantity": allocation.quantity,
                    "source": allocation.source,
                }
                for allocation in plan.transfer_allocations
            ],
        }
