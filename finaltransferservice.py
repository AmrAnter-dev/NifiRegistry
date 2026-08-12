import asyncio
from typing import List

class TransferService:

    TRANSFER_TIMEOUT_SECONDS = 15 * 60  # 15 Minutes

    def __init__(
        self,
        inventory_service,
        branch_service,
        transfer_repository,
        transfer_event_waiter,
        lock_manager: RedisLockManager,
    ):
        
        self.inventory_service = inventory_service
        self.branch_service = branch_service
        self.transfer_repository = transfer_repository
        self.transfer_event_waiter = transfer_event_waiter
        self.lock_manager = lock_manager

    async def fulfill_item(self, item: CartItem) -> FulfillmentPlan:
        
        requested_quantity = item.requested_quantity

        # 1. LOCAL AVAILABLE
        if item.status == CartItemStatus.LOCAL_AVAILABLE:
            return FulfillmentPlan(
                item=item,
                local_quantity=requested_quantity,
                fulfilled=True,
            )

        # 2. PARTIALLY AVAILABLE
        if item.status == CartItemStatus.PARTIALLY_AVAILABLE:
            local_quantity = min(
                item.local_available_quantity,
                requested_quantity,
            )
            transfer_quantity = requested_quantity - local_quantity

            if transfer_quantity <= 0:
                return FulfillmentPlan(
                    item=item,
                    local_quantity=local_quantity,
                    fulfilled=True,
                )

            transfer_allocations = await self._fulfill_from_network(
                item=item,
                quantity=transfer_quantity,
            )

            transferred_quantity = sum(
                allocation.quantity for allocation in transfer_allocations
            )

            return FulfillmentPlan(
                item=item,
                local_quantity=local_quantity,
                transfer_allocations=transfer_allocations,
                fulfilled=(local_quantity + transferred_quantity >= requested_quantity),
            )

        # 3. NETWORK AVAILABLE
        if item.status == CartItemStatus.NETWORK_AVAILABLE:
            transfer_allocations = await self._fulfill_from_network(
                item=item,
                quantity=requested_quantity,
            )

            transferred_quantity = sum(
                allocation.quantity for allocation in transfer_allocations
            )

            return FulfillmentPlan(
                item=item,
                local_quantity=0,
                transfer_allocations=transfer_allocations,
                fulfilled=(transferred_quantity >= requested_quantity),
            )

        # 4. OUT OF STOCK
        if item.status == CartItemStatus.OUT_OF_STOCK:
            return FulfillmentPlan(
                item=item,
                fulfilled=False,
            )

        raise ValueError(f"Unsupported item status: {item.status}")

    # ======================================================
    # NETWORK FULFILLMENT
    # ======================================================

    async def _fulfill_from_network(
        self,
        item: CartItem,
        quantity: int,
    ) -> List[TransferAllocation]:

        lock_key = f"inventory_lock:{item.item_code}"

        # 1. Acquire Lock for Stock Planning
        async with self.lock_manager.acquire_lock(lock_key=lock_key, timeout_seconds=15):
            remaining_quantity = quantity

            # Fetch Available Stocks
            allocations = await self._get_allocations(
                item_code=item.item_code,
                requested_quantity=quantity,
            )

            branch_ids = [
                alloc.branch_id for alloc in allocations if alloc.qty_available > 0
            ]

            planned_allocations: List[TransferAllocation] = []

            if branch_ids:
                # Get nearest branches via PostGIS
                branches = await self.branch_service.get_nearest_branches(
                    customer_branch_id=item.customer_branch_id,
                    branch_ids=branch_ids,
                )

                allocation_by_branch = {
                    alloc.branch_id: alloc for alloc in allocations
                }

                # Build Branch Allocation Plan
                for branch in branches:
                    if remaining_quantity <= 0:
                        break

                    stock = allocation_by_branch.get(branch.id)
                    if not stock:
                        continue

                    quantity_from_branch = min(stock.qty_available, remaining_quantity)

                    if quantity_from_branch <= 0:
                        continue

                    planned_allocations.append(
                        TransferAllocation(
                            source_id=branch.id,
                            quantity=quantity_from_branch,
                            source=FulfillmentSource.NETWORK_BRANCH,
                        )
                    )
                    remaining_quantity -= quantity_from_branch

            # Fallback to Main Warehouse if Network is insufficient
            if remaining_quantity > 0:
                warehouse_id = await self._get_warehouse_id()
                planned_allocations.append(
                    TransferAllocation(
                        source_id=warehouse_id,
                        quantity=remaining_quantity,
                        source=FulfillmentSource.MAIN_WAREHOUSE,
                    )
                )

        # 2. Execute Transfers (Outside lock to minimize lock hold time)
        network_results = await asyncio.gather(
            *[
                self._execute_transfer(item=item, allocation=allocation)
                for allocation in planned_allocations
            ],
            return_exceptions=True,
        )

        # 3. Filter Successful Allocations
        successful_allocations = []
        for allocation, result in zip(planned_allocations, network_results):
            if (
                not isinstance(result, Exception)
                and result.status == TransferStatus.FULFILLED
            ):
                successful_allocations.append(allocation)

        return successful_allocations

    # ======================================================
    # GET STOCK
    # ======================================================

    async def _get_allocations(self, item_code: str, requested_quantity: int):
        cached = await self.transfer_repository.get_cached_allocations(
            item_code=item_code
        )
        if cached is not None:
            return cached

        return await self.inventory_service.check_for_all_branches_stock(
            item_code=item_code,
            requested_quantity=requested_quantity,
        )

    # ======================================================
    # EXECUTE ONE TRANSFER
    # ======================================================

    async def _execute_transfer(
    self,
    item: CartItem,
    allocation: TransferAllocation,
) -> TransferResult:

    # يتم إنشاء السجل في DB الفرع المصدر (allocation.source_id)
    transfer = await self.transfer_repository.create_transfer(
        item_code=item.item_code,
        quantity=allocation.quantity,
        source_id=allocation.source_id,
        destination_branch_id=item.customer_branch_id,
        source_type=allocation.source,
    )

    try:
        async with asyncio.timeout(self.TRANSFER_TIMEOUT_SECONDS):
            status = await self.transfer_event_waiter.wait_for_status(
                transfer_id=transfer.id,
                timeout_seconds=self.TRANSFER_TIMEOUT_SECONDS,
            )
    except TimeoutError:
        status = TransferStatus.FAILED

        # تحديث الحالة إلى FAILED في قاعدة بيانات الفرع المصدر
        await self.transfer_repository.update_status(
            transfer_id=transfer.id,
            source_id=allocation.source_id,
            status=TransferStatus.FAILED,
        )

    return TransferResult(
        transfer_id=transfer.id,
        status=status,
        source_id=allocation.source_id,
    )

    async def _get_warehouse_id(self) -> int:
        return await self.branch_service.get_main_warehouse_id()
