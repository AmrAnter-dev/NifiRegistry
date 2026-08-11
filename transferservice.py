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
        item: CartItem
    ) -> FulfillmentPlan:

        requested_quantity = item.requested_quantity

        # ==================================================
        # CASE 1
        # LOCAL_AVAILABLE
        # ==================================================

        if item.status == CartItemStatus.LOCAL_AVAILABLE:

            return FulfillmentPlan(
                item=item,
                local_quantity=requested_quantity,
                transfer_quantity=0,
                fulfilled=True,
                requires_transfer=False,
                source=FulfillmentSource.LOCAL_BRANCH,
                source_branch_id=item.customer_branch_id,
            )

        # ==================================================
        # CASE 2
        # PARTIALLY_AVAILABLE
        #
        # Example:
        # requested = 10
        # local = 6
        # transfer = 4
        # ==================================================

        if item.status == CartItemStatus.PARTIALLY_AVAILABLE:

            local_quantity = item.local_available_quantity

            transfer_quantity = (
                requested_quantity - local_quantity
            )

            if transfer_quantity <= 0:
                return FulfillmentPlan(
                    item=item,
                    local_quantity=requested_quantity,
                    transfer_quantity=0,
                    fulfilled=True,
                    requires_transfer=False,
                    source=FulfillmentSource.LOCAL_BRANCH,
                    source_branch_id=item.customer_branch_id,
                )

            transfer_result = await self._transfer_quantity(
                item=item,
                quantity=transfer_quantity,
            )

            if transfer_result.fulfilled:

                return FulfillmentPlan(
                    item=item,
                    local_quantity=local_quantity,
                    transfer_quantity=transfer_quantity,
                    fulfilled=True,
                    requires_transfer=True,
                    source=transfer_result.source,
                    source_branch_id=transfer_result.source_branch_id,
                )

            return FulfillmentPlan(
                item=item,
                local_quantity=local_quantity,
                transfer_quantity=0,
                fulfilled=False,
                requires_transfer=True,
            )

        # ==================================================
        # CASE 3
        # NETWORK_AVAILABLE
        #
        # local = 0
        # transfer = requested
        # ==================================================

        if item.status == CartItemStatus.NETWORK_AVAILABLE:

            transfer_result = await self._transfer_quantity(
                item=item,
                quantity=requested_quantity,
            )

            if transfer_result.fulfilled:

                return FulfillmentPlan(
                    item=item,
                    local_quantity=0,
                    transfer_quantity=requested_quantity,
                    fulfilled=True,
                    requires_transfer=True,
                    source=transfer_result.source,
                    source_branch_id=transfer_result.source_branch_id,
                )

            return FulfillmentPlan(
                item=item,
                local_quantity=0,
                transfer_quantity=0,
                fulfilled=False,
                requires_transfer=True,
            )

        # ==================================================
        # CASE 4
        # OUT_OF_STOCK
        # ==================================================

        if item.status == CartItemStatus.OUT_OF_STOCK:

            return FulfillmentPlan(
                item=item,
                fulfilled=False,
                requires_transfer=False,
            )

        raise ValueError(
            f"Unsupported item status: {item.status}"
        )

    async def _transfer_quantity(
        self,
        item: CartItem,
        quantity: int,
    ) -> TransferResult:

        # ==================================================
        # 1. Get stock allocations
        # ==================================================

        allocations = await self._get_allocations(
            item_code=item.item_code,
            requested_quantity=quantity,
        )

        # ==================================================
        # 2. IMPORTANT:
        # Keep ONLY branches that can fulfill the
        # COMPLETE quantity we need to transfer.
        # ==================================================

        eligible_branch_ids = [
            allocation.branch_id
            for allocation in allocations
            if allocation.available_quantity >= quantity
        ]

        # ==================================================
        # 3. Ask PostGIS for nearest eligible branches
        # ==================================================

        branches = await self.branch_service.get_nearest_branches(
            customer_branch_id=item.customer_branch_id,
            branch_ids=eligible_branch_ids,
        )

        # ==================================================
        # 4. Try nearest branch first
        # Each branch gets 15 minutes.
        # ==================================================

        for branch in branches:

            result = await self._try_branch(
                item=item,
                branch=branch,
                quantity=quantity,
            )

            if result.fulfilled:
                return result

        # ==================================================
        # 5. All branches failed / timed out
        # Last fallback = Main Warehouse
        # ==================================================

        return await self._try_warehouse(
            item=item,
            quantity=quantity,
        )

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

        # Cache miss → Inventory Service
        return await self.inventory_service.check_for_all_branches_stock(
            item_code=item_code,
            requested_quantity=requested_quantity,
        )

    async def _try_branch(
        self,
        item: CartItem,
        branch: Branch,
        quantity: int,
    ) -> TransferResult:

        # ==================================================
        # Create transfer request
        # ==================================================

        transfer = await self.transfer_repository.create_transfer(
            item_code=item.item_code,
            quantity=quantity,
            source_branch_id=branch.id,
            destination_branch_id=item.customer_branch_id,
        )

        # ==================================================
        # Wait for CDC event OR 15-minute timeout
        #
        # Debezium detects DB changes and publishes events.
        # ==================================================

        status = await self.transfer_event_waiter.wait_for_status(
            transfer_id=transfer.id,
            timeout_seconds=self.TRANSFER_TIMEOUT_SECONDS,
        )

        if status == TransferStatus.FULFILLED:

            return TransferResult(
                fulfilled=True,
                source_branch_id=branch.id,
                source=FulfillmentSource.NETWORK_BRANCH,
            )

        # Rejected or timeout
        return TransferResult(
            fulfilled=False,
            source_branch_id=branch.id,
            source=FulfillmentSource.NETWORK_BRANCH,
        )

    async def _try_warehouse(
        self,
        item: CartItem,
        quantity: int,
    ) -> TransferResult:

        transfer = (
            await self.transfer_repository.create_warehouse_transfer(
                item_code=item.item_code,
                quantity=quantity,
                destination_branch_id=item.customer_branch_id,
            )
        )

        status = await self.transfer_event_waiter.wait_for_status(
            transfer_id=transfer.id,
            timeout_seconds=self.TRANSFER_TIMEOUT_SECONDS,
        )

        if status == TransferStatus.FULFILLED:

            return TransferResult(
                fulfilled=True,
                source_branch_id=transfer.source_id,
                source=FulfillmentSource.MAIN_WAREHOUSE,
            )

        return TransferResult(
            fulfilled=False,
            source=FulfillmentSource.MAIN_WAREHOUSE,
        )
