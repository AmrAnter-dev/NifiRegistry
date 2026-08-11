import asyncio


class TransferService:

    TRANSFER_TIMEOUT_SECONDS = 15 * 60

    def __init__(
        self,
        inventory_service,
        branch_service,
        transfer_repository,
        transfer_event_waiter,
    ):
        self.inventory_service = inventory_service
        self.branch_service = branch_service
        self.transfer_repository = transfer_repository
        self.transfer_event_waiter = transfer_event_waiter

    async def fulfill_item(
        self,
        item: CartItem,
    ) -> FulfillmentPlan:

        requested_quantity = item.requested_quantity

        # ==================================================
        # 1. LOCAL AVAILABLE
        # ==================================================

        if item.status == CartItemStatus.LOCAL_AVAILABLE:

            return FulfillmentPlan(
                item=item,
                local_quantity=requested_quantity,
                fulfilled=True,
            )

        # ==================================================
        # 2. PARTIALLY AVAILABLE
        #
        # Example:
        # requested = 10
        # local = 6
        # transfer = 4
        # ==================================================

        if item.status == CartItemStatus.PARTIALLY_AVAILABLE:

            local_quantity = min(
                item.local_available_quantity,
                requested_quantity,
            )

            transfer_quantity = (
                requested_quantity - local_quantity
            )

            if transfer_quantity <= 0:

                return FulfillmentPlan(
                    item=item,
                    local_quantity=local_quantity,
                    fulfilled=True,
                )

            transfer_allocations = (
                await self._fulfill_from_network(
                    item=item,
                    quantity=transfer_quantity,
                )
            )

            transferred_quantity = sum(
                allocation.quantity
                for allocation in transfer_allocations
            )

            fulfilled = (
                local_quantity + transferred_quantity
                >= requested_quantity
            )

            return FulfillmentPlan(
                item=item,
                local_quantity=local_quantity,
                transfer_allocations=transfer_allocations,
                fulfilled=fulfilled,
            )

        # ==================================================
        # 3. NETWORK AVAILABLE
        #
        # local = 0
        # transfer = requested
        # ==================================================

        if item.status == CartItemStatus.NETWORK_AVAILABLE:

            transfer_allocations = (
                await self._fulfill_from_network(
                    item=item,
                    quantity=requested_quantity,
                )
            )

            transferred_quantity = sum(
                allocation.quantity
                for allocation in transfer_allocations
            )

            return FulfillmentPlan(
                item=item,
                local_quantity=0,
                transfer_allocations=transfer_allocations,
                fulfilled=(
                    transferred_quantity
                    >= requested_quantity
                ),
            )

        # ==================================================
        # 4. OUT OF STOCK
        # ==================================================

        if item.status == CartItemStatus.OUT_OF_STOCK:

            return FulfillmentPlan(
                item=item,
                fulfilled=False,
            )

        raise ValueError(
            f"Unsupported item status: {item.status}"
        )

    # ======================================================
    # NETWORK FULFILLMENT
    # ======================================================

    async def _fulfill_from_network(
        self,
        item: CartItem,
        quantity: int,
    ) -> list[TransferAllocation]:

        remaining_quantity = quantity

        # --------------------------------------------------
        # 1. Get stock allocations
        # --------------------------------------------------

        allocations = await self._get_allocations(
            item_code=item.item_code,
            requested_quantity=quantity,
        )

        # --------------------------------------------------
        # 2. Only branches with stock > 0
        # --------------------------------------------------

        branch_ids = [
            allocation.branch_id
            for allocation in allocations
            if allocation.available_quantity > 0
        ]

        if not branch_ids:
            return []

        # --------------------------------------------------
        # 3. PostGIS:
        # Get nearest branches among eligible branches
        # --------------------------------------------------

        branches = await self.branch_service.get_nearest_branches(
            customer_branch_id=item.customer_branch_id,
            branch_ids=branch_ids,
        )

        allocation_by_branch = {
            allocation.branch_id: allocation
            for allocation in allocations
        }

        # --------------------------------------------------
        # 4. Build an allocation plan
        #
        # We can split the requested quantity across
        # multiple branches.
        # --------------------------------------------------

        planned_allocations = []

        for branch in branches:

            if remaining_quantity <= 0:
                break

            stock = allocation_by_branch[branch.id]

            quantity_from_branch = min(
                stock.available_quantity,
                remaining_quantity,
            )

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

        # --------------------------------------------------
        # 5. IMPORTANT:
        # Only now do we go to the warehouse.
        #
        # Branch network is exhausted first.
        # --------------------------------------------------

        if remaining_quantity > 0:

            planned_allocations.append(
                TransferAllocation(
                    source_id=await self._get_warehouse_id(),
                    quantity=remaining_quantity,
                    source=FulfillmentSource.MAIN_WAREHOUSE,
                )
            )

        # --------------------------------------------------
        # 6. Execute transfers
        # --------------------------------------------------
network_results = await asyncio.gather(
    *[
        self._execute_transfer(
            item=item,
            allocation=allocation,
        )
        for allocation in network_allocations
    ]
)

fulfilled_quantity = sum(
    allocation.quantity
    for allocation, result
    in zip(network_allocations, network_results)
    if result.status == TransferStatus.FULFILLED
)

remaining_quantity = quantity - fulfilled_quantity

if remaining_quantity > 0:
    # NOW warehouse
        

        # --------------------------------------------------
        # 7. Keep only successful transfers
        # --------------------------------------------------

        successful_allocations = []

        for allocation, result in zip(
            planned_allocations,
            results,
        ):
            if result.status == TransferStatus.FULFILLED:

                successful_allocations.append(
                    allocation
                )

        return successful_allocations

    # ======================================================
    # GET STOCK
    # ======================================================

    async def _get_allocations(
        self,
        item_code: str,
        requested_quantity: int,
    ):

        # Cache first
        cached = await self.transfer_repository.get_cached_allocations(
            item_code=item_code,
        )

        if cached is not None:
            return cached

        # Cache miss
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

        # --------------------------------------------------
        # Create transfer
        # --------------------------------------------------

        transfer = await self.transfer_repository.create_transfer(
            item_code=item.item_code,
            quantity=allocation.quantity,
            source_id=allocation.source_id,
            destination_branch_id=item.customer_branch_id,
            source_type=allocation.source,
        )

        # --------------------------------------------------
        # Wait for Debezium/CDC event
        # OR timeout after 15 minutes
        # --------------------------------------------------

        status = (
            await self.transfer_event_waiter.wait_for_status(
                transfer_id=transfer.id,
                timeout_seconds=self.TRANSFER_TIMEOUT_SECONDS,
            )
        )

        return TransferResult(
            transfer_id=transfer.id,
            status=status,
            source_id=allocation.source_id,
        )

    async def _get_warehouse_id(self) -> int:

        return await self.branch_service.get_main_warehouse_id()
