from typing import Protocol


class ProductService:

    def __init__(
        self,
        product_resolver: ProductResolver,
        product_repository: ProductRepository,
        inventory_service: InventoryService,
    ) -> None:
        self._product_resolver = product_resolver
        self._product_repository = product_repository
        self._inventory_service = inventory_service

    async def resolve_product(
        self,
        query: str,
    ) -> ProductSearchResult:

        return await self._product_resolver.resolve(query)

    async def get_product(
        self,
        item_code: str,
    ) -> Product | None:

        return await self._product_repository.get_by_item_code(
            item_code
        )

    async def check_availability(
        self,
        *,
        item_code: str,
        branch_id: int,
        requested_quantity: int,
    ) -> AvailabilityResult:

        if requested_quantity <= 0:
            raise ValueError(
                "requested_quantity must be greater than zero."
            )

        result = await self._inventory_service.get_availability(
            item_code=item_code,
            branch_id=branch_id,
            requested_quantity=requested_quantity,
        )

        return self._build_availability_result(
            item_code=item_code,
            requested_quantity=requested_quantity,
            result=result,
            branch_id=branch_id,
        )

    @staticmethod
    def _build_availability_result(
        *,
        item_code: str,
        requested_quantity: int,
        result: InventoryAvailabilityResult,
        branch_id: int,
    ) -> AvailabilityResult:

        allocations = [
            Allocation(
                branch_id=allocation.branch_id,
                quantity=allocation.quantity,
            )
            for allocation in result.allocations
            if allocation.quantity > 0
        ]

        total_available = sum(
            allocation.quantity
            for allocation in allocations
        )

        local_quantity = sum(
            allocation.quantity
            for allocation in allocations
            if allocation.branch_id == branch_id
        )

        if local_quantity >= requested_quantity:
            status = AvailabilityStatus.LOCAL_AVAILABLE

        elif total_available >= requested_quantity:
            status = AvailabilityStatus.NETWORK_AVAILABLE

        elif total_available > 0:
            status = AvailabilityStatus.PARTIALLY_AVAILABLE

        else:
            status = AvailabilityStatus.UNAVAILABLE

        return AvailabilityResult(
            item_code=item_code,
            requested_quantity=requested_quantity,
            allocations=allocations,
            status=status,
        )
