from __future__ import annotations

import logging
from dataclasses import dataclass
from enum import StrEnum


logger = logging.getLogger(__name__)


class AvailabilityStatus(StrEnum):
    LOCAL_AVAILABLE = "LOCAL_AVAILABLE"
    NETWORK_AVAILABLE = "NETWORK_AVAILABLE"
    PARTIALLY_AVAILABLE = "PARTIALLY_AVAILABLE"
    UNAVAILABLE = "UNAVAILABLE"


@dataclass(frozen=True, slots=True)
class Allocation:
    branch_id: int
    quantity: int


@dataclass(frozen=True, slots=True)
class AvailabilityResult:
    item_code: int
    requested_quantity: int

    local_quantity: int
    network_quantity: int

    allocations: list[Allocation]

    status: AvailabilityStatus

    @property
    def shortfall(self) -> int:
        return max(
            0,
            self.requested_quantity - self.network_quantity,
        )


class InventoryService:

    def __init__(
        self,
        branch_repo,
        central_repo,
    ) -> None:
        self._branch_repo = branch_repo
        self._central_repo = central_repo

    async def get_availability(
        self,
        *,
        branch_id: int,
        item_code: int,
        requested_quantity: int,
    ) -> AvailabilityResult:

        if requested_quantity <= 0:
            raise ValueError(
                "requested_quantity must be greater than zero."
            )

        # --------------------------------------------------
        # 1. Local branch
        # --------------------------------------------------

        local_allocation = await self._branch_repo.get_stock(
            item_code=item_code,
        )

        local_quantity = (
            local_allocation.qty_available
            if local_allocation is not None
            else 0
        )

        # --------------------------------------------------
        # 2. Local stock is enough
        # --------------------------------------------------

        if local_quantity >= requested_quantity:

            return AvailabilityResult(
                item_code=item_code,
                requested_quantity=requested_quantity,
                local_quantity=local_quantity,
                network_quantity=local_quantity,
                allocations=[
                    Allocation(
                        branch_id=branch_id,
                        quantity=requested_quantity,
                    )
                ],
                status=AvailabilityStatus.LOCAL_AVAILABLE,
            )

        # --------------------------------------------------
        # 3. Local stock is not enough
        #
        #    Central = other branches
        # --------------------------------------------------

        central_allocations = (
            await self._central_repo.get_stock(
                item_code=item_code,
            )
        )

        allocations = self._build_allocations(
            local_branch_id=branch_id,
            local_quantity=local_quantity,
            central_allocations=central_allocations,
            requested_quantity=requested_quantity,
        )

        network_quantity = sum(
            allocation.quantity
            for allocation in allocations
        )

        # --------------------------------------------------
        # 4. Determine availability status
        # --------------------------------------------------

        status = self._determine_status(
            requested_quantity=requested_quantity,
            local_quantity=local_quantity,
            network_quantity=network_quantity,
        )

        return AvailabilityResult(
            item_code=item_code,
            requested_quantity=requested_quantity,
            local_quantity=local_quantity,
            network_quantity=network_quantity,
            allocations=allocations,
            status=status,
        )

    @staticmethod
    def _determine_status(
        *,
        requested_quantity: int,
        local_quantity: int,
        network_quantity: int,
    ) -> AvailabilityStatus:

        if local_quantity >= requested_quantity:
            return AvailabilityStatus.LOCAL_AVAILABLE

        if network_quantity >= requested_quantity:
            return AvailabilityStatus.NETWORK_AVAILABLE

        if network_quantity > 0:
            return AvailabilityStatus.PARTIALLY_AVAILABLE

        return AvailabilityStatus.UNAVAILABLE

    @staticmethod
    def _build_allocations(
        *,
        local_branch_id: int,
        local_quantity: int,
        central_allocations,
        requested_quantity: int,
    ) -> list[Allocation]:

        remaining = requested_quantity
        allocations: list[Allocation] = []

        # --------------------------------------------------
        # Local branch first
        # --------------------------------------------------

        if local_quantity > 0:

            local_used = min(
                local_quantity,
                remaining,
            )

            allocations.append(
                Allocation(
                    branch_id=local_branch_id,
                    quantity=local_used,
                )
            )

            remaining -= local_used

        # --------------------------------------------------
        # Other branches
        # --------------------------------------------------

        if remaining <= 0:
            return allocations

        for allocation in central_allocations:

            if remaining <= 0:
                break

            available = max(
                0,
                allocation.qty_available,
            )

            if available <= 0:
                continue

            allocated = min(
                available,
                remaining,
            )

            allocations.append(
                Allocation(
                    branch_id=allocation.branch_id,
                    quantity=allocated,
                )
            )

            remaining -= allocated

        return allocations
