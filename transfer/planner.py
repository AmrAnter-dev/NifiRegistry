#1. fulfillment_models.py
from enum import StrEnum

from pydantic import BaseModel, ConfigDict, Field, model_validator


class FulfillmentDecision(StrEnum):
    LOCAL_STOCK = "local_stock"
    BRANCH_TRANSFER = "branch_transfer"
    CENTRAL_WAREHOUSE = "central_warehouse"
    MIXED_SOURCES = "mixed_sources"
    PARTIAL_AVAILABILITY = "partial_availability"
    UNAVAILABLE = "unavailable"
    NEEDS_REVIEW = "needs_review"


class OrderLine(BaseModel):
    model_config = ConfigDict(frozen=True, extra="forbid")

    item_code: int = Field(gt=0)
    requested_quantity: int = Field(gt=0)


class FulfillmentRequest(BaseModel):
    model_config = ConfigDict(frozen=True, extra="forbid")

    order_id: str = Field(min_length=1)
    destination_branch_id: str = Field(min_length=1)
    lines: tuple[OrderLine, ...] = Field(min_length=1)

    @model_validator(mode="after")
    def validate_unique_item_codes(self):
        codes = [line.item_code for line in self.lines]
        if len(codes) != len(set(codes)):
            raise ValueError(
                "Duplicate item_code values are not allowed. "
                "Combine quantities before planning."
            )
        return self


class NearbyBranch(BaseModel):
    model_config = ConfigDict(frozen=True, extra="forbid")

    branch_id: str = Field(min_length=1)
    distance_from_destination_km: float = Field(ge=0)


class Allocation(BaseModel):
    model_config = ConfigDict(frozen=True, extra="forbid")

    source_branch_id: str = Field(min_length=1)
    quantity: int = Field(gt=0)


class LineFulfillmentPlan(BaseModel):
    model_config = ConfigDict(frozen=True, extra="forbid")

    item_code: int = Field(gt=0)
    requested_quantity: int = Field(gt=0)
    allocated_quantity: int = Field(ge=0)
    shortage_quantity: int = Field(ge=0)
    decision: FulfillmentDecision
    allocations: tuple[Allocation, ...] = ()
    reason: str

    @model_validator(mode="after")
    def validate_quantities(self):
        allocated_sum = sum(a.quantity for a in self.allocations)

        if allocated_sum != self.allocated_quantity:
            raise ValueError(
                "allocated_quantity must equal the sum of allocations."
            )

        if (
            self.allocated_quantity + self.shortage_quantity
            != self.requested_quantity
        ):
            raise ValueError(
                "allocated_quantity + shortage_quantity "
                "must equal requested_quantity."
            )

        if len({
            a.source_branch_id for a in self.allocations
        }) != len(self.allocations):
            raise ValueError(
                "Each source_branch_id must appear only once."
            )

        return self


class FulfillmentPlan(BaseModel):
    model_config = ConfigDict(frozen=True, extra="forbid")

    order_id: str
    destination_branch_id: str
    lines: tuple[LineFulfillmentPlan, ...]
#2. fulfillment_ports.py
from typing import Protocol, Sequence

from fulfillment_models import NearbyBranch


class BranchLocator(Protocol):
    async def get_nearest_branches(
        self,
        destination_branch_id: str,
        *,
        limit: int,
    ) -> Sequence[NearbyBranch]:
        """
        Return nearest eligible branches, excluding the destination.
        Sorted by straight-line distance ascending.
        """
        ...

    async def get_direct_distance_km(
        self,
        branch_a_id: str,
        branch_b_id: str,
    ) -> float:
        """
        Return the direct geographic distance between two branches.
        """
        ...


class WarehouseInventoryReader(Protocol):
    async def get_snapshots(
        self,
        *,
        branch_ids: Sequence[str],
        item_codes: Sequence[int],
    ) -> dict[tuple[str, int], int]:
        """
        Return known quantity_available values keyed by
        (branch_id, item_code).

        Missing keys mean UNKNOWN snapshot, not zero stock.
        """
        ...
#3. warehouse_inventory_repository.py
import asyncpg

from collections.abc import Sequence


class WarehouseInventoryRepository:
    def __init__(self, pool: asyncpg.Pool) -> None:
        self._pool = pool

    async def get_snapshots(
        self,
        *,
        branch_ids: Sequence[str],
        item_codes: Sequence[int],
    ) -> dict[tuple[str, int], int]:
        if not branch_ids or not item_codes:
            return {}

        query = """
            SELECT
                branchid AS branch_id,
                item_code,
                quantity_available
            FROM inventory.product_inventory
            WHERE branchid = ANY($1::text[])
              AND item_code = ANY($2::integer[])
        """

        async with self._pool.acquire() as connection:
            rows = await connection.fetch(
                query,
                list(branch_ids),
                list(item_codes),
            )

        snapshots: dict[tuple[str, int], int] = {}

        for row in rows:
            branch_id = str(row["branch_id"])
            item_code = int(row["item_code"])
            quantity = row["quantity_available"]

            if quantity is None or quantity < 0:
                raise ValueError(
                    "Invalid quantity_available in warehouse snapshot: "
                    f"branch_id={branch_id}, item_code={item_code}"
                )

            snapshots[(branch_id, item_code)] = int(quantity)

        return snapshots
#4. fulfillment_planner.py
import logging
from itertools import combinations
from collections.abc import Sequence

from fulfillment_models import (
    Allocation,
    FulfillmentDecision,
    FulfillmentPlan,
    FulfillmentRequest,
    LineFulfillmentPlan,
    NearbyBranch,
)
from fulfillment_ports import (
    BranchLocator,
    WarehouseInventoryReader,
)

logger = logging.getLogger(__name__)


class FulfillmentPlanningError(RuntimeError):
    """Raised when a reliable fulfillment plan cannot be computed."""


class FulfillmentPlanner:
    def __init__(
        self,
        *,
        branch_locator: BranchLocator,
        inventory_reader: WarehouseInventoryReader,
        central_warehouse_id: str,
        nearest_branches_limit: int = 3,
        max_source_distance_km: float = 20.0,
    ) -> None:
        if not central_warehouse_id.strip():
            raise ValueError("central_warehouse_id cannot be empty.")

        if nearest_branches_limit < 1:
            raise ValueError("nearest_branches_limit must be >= 1.")

        if max_source_distance_km < 0:
            raise ValueError("max_source_distance_km cannot be negative.")

        self._branch_locator = branch_locator
        self._inventory_reader = inventory_reader
        self._central_warehouse_id = central_warehouse_id
        self._nearest_branches_limit = nearest_branches_limit
        self._max_source_distance_km = max_source_distance_km

    async def plan(
        self,
        request: FulfillmentRequest,
    ) -> FulfillmentPlan:
        try:
            nearby_branches = await self._get_nearby_branches(
                request.destination_branch_id
            )

            source_branch_ids = self._unique_preserving_order(
                [
                    request.destination_branch_id,
                    *(branch.branch_id for branch in nearby_branches),
                    self._central_warehouse_id,
                ]
            )

            item_codes = [line.item_code for line in request.lines]

            snapshots = await self._inventory_reader.get_snapshots(
                branch_ids=source_branch_ids,
                item_codes=item_codes,
            )

            plans: list[LineFulfillmentPlan] = []

            for line in request.lines:
                line_plan = await self._plan_line(
                    item_code=line.item_code,
                    requested_quantity=line.requested_quantity,
                    destination_branch_id=request.destination_branch_id,
                    nearby_branches=nearby_branches,
                    source_branch_ids=source_branch_ids,
                    snapshots=snapshots,
                )
                plans.append(line_plan)

            return FulfillmentPlan(
                order_id=request.order_id,
                destination_branch_id=request.destination_branch_id,
                lines=tuple(plans),
            )

        except FulfillmentPlanningError:
            raise
        except Exception as exc:
            logger.exception(
                "Fulfillment planning failed for order_id=%s",
                request.order_id,
            )
            raise FulfillmentPlanningError(
                f"Could not compute a reliable fulfillment plan "
                f"for order {request.order_id}."
            ) from exc

    async def _get_nearby_branches(
        self,
        destination_branch_id: str,
    ) -> tuple[NearbyBranch, ...]:
        branches = await self._branch_locator.get_nearest_branches(
            destination_branch_id,
            limit=self._nearest_branches_limit,
        )

        branch_ids = [branch.branch_id for branch in branches]

        if destination_branch_id in branch_ids:
            raise FulfillmentPlanningError(
                "BranchLocator must exclude the destination branch."
            )

        if len(branch_ids) != len(set(branch_ids)):
            raise FulfillmentPlanningError(
                "BranchLocator returned duplicate branch IDs."
            )

        if any(
            not branch.branch_id.strip()
            for branch in branches
        ):
            raise FulfillmentPlanningError(
                "BranchLocator returned an empty branch ID."
            )

        return tuple(branches)

    async def _plan_line(
        self,
        *,
        item_code: int,
        requested_quantity: int,
        destination_branch_id: str,
        nearby_branches: Sequence[NearbyBranch],
        source_branch_ids: Sequence[str],
        snapshots: dict[tuple[str, int], int],
    ) -> LineFulfillmentPlan:
        central_id = self._central_warehouse_id

        def quantity_for(branch_id: str) -> int | None:
            # None means the snapshot is missing/unknown.
            return snapshots.get((branch_id, item_code))

        unknown_sources = [
            branch_id
            for branch_id in source_branch_ids
            if quantity_for(branch_id) is None
        ]

        allocations: list[Allocation] = []

        # Step 1: Use known stock at the destination branch first.
        destination_quantity = quantity_for(destination_branch_id)

        if destination_quantity is not None and destination_quantity > 0:
            local_quantity = min(
                destination_quantity,
                requested_quantity,
            )
            allocations.append(
                Allocation(
                    source_branch_id=destination_branch_id,
                    quantity=local_quantity,
                )
            )

        local_allocated = sum(
            allocation.quantity
            for allocation in allocations
        )
        remaining_quantity = requested_quantity - local_allocated

        if remaining_quantity == 0:
            return self._build_line_plan(
                item_code=item_code,
                requested_quantity=requested_quantity,
                allocations=allocations,
                unknown_sources=unknown_sources,
                reason="The destination branch snapshot covers the request.",
            )

        # Step 2: Allocate the remaining quantity from nearby branches,
        # ordered by distance from the destination.
        branch_allocations: list[Allocation] = []
        branch_remaining = remaining_quantity

        for branch in nearby_branches:
            available = quantity_for(branch.branch_id)

            # Unknown is not equivalent to zero.
            if available is None or available == 0:
                continue

            allocated = min(available, branch_remaining)

            if allocated > 0:
                branch_allocations.append(
                    Allocation(
                        source_branch_id=branch.branch_id,
                        quantity=allocated,
                    )
                )
                branch_remaining -= allocated

            if branch_remaining == 0:
                break

        # Step 3: If multiple external branches are required and any
        # pair is farther apart than the configured threshold, prefer
        # the central warehouse when it can cover the entire remainder
        # that was not covered by local stock.
        central_quantity = quantity_for(central_id)

        use_central_instead = False

        if (
            len(branch_allocations) > 1
            and central_quantity is not None
            and central_quantity >= remaining_quantity
        ):
            use_central_instead = (
                await self._has_distant_source_pair(
                    [
                        allocation.source_branch_id
                        for allocation in branch_allocations
                    ]
                )
            )

        if use_central_instead:
            allocations.append(
                Allocation(
                    source_branch_id=central_id,
                    quantity=remaining_quantity,
                )
            )

            return self._build_line_plan(
                item_code=item_code,
                requested_quantity=requested_quantity,
                allocations=allocations,
                unknown_sources=unknown_sources,
                reason=(
                    "The central warehouse can cover the remaining "
                    "quantity and avoids using distant branch sources."
                ),
            )

        # Step 4: Keep the nearest-first branch allocations.
        allocations.extend(branch_allocations)

        allocated_from_branches = sum(
            allocation.quantity
            for allocation in branch_allocations
        )
        remaining_quantity -= allocated_from_branches

        # Step 5: If a shortage remains, use known central stock as a
        # fallback. This may still result in a partial plan.
        if (
            remaining_quantity > 0
            and central_quantity is not None
            and central_quantity > 0
        ):
            central_allocated = min(
                central_quantity,
                remaining_quantity,
            )

            allocations.append(
                Allocation(
                    source_branch_id=central_id,
                    quantity=central_allocated,
                )
            )

        return self._build_line_plan(
            item_code=item_code,
            requested_quantity=requested_quantity,
            allocations=allocations,
            unknown_sources=unknown_sources,
            reason=self._make_reason(
                requested_quantity=requested_quantity,
                allocations=allocations,
                unknown_sources=unknown_sources,
            ),
        )

    async def _has_distant_source_pair(
        self,
        branch_ids: Sequence[str],
    ) -> bool:
        for branch_a, branch_b in combinations(branch_ids, 2):
            distance_km = (
                await self._branch_locator.get_direct_distance_km(
                    branch_a,
                    branch_b,
                )
            )

            if distance_km < 0:
                raise FulfillmentPlanningError(
                    "BranchLocator returned a negative distance."
                )

            if distance_km > self._max_source_distance_km:
                return True

        return False

    def _build_line_plan(
        self,
        *,
        item_code: int,
        requested_quantity: int,
        allocations: Sequence[Allocation],
        unknown_sources: Sequence[str],
        reason: str,
    ) -> LineFulfillmentPlan:
        allocated_quantity = sum(
            allocation.quantity for allocation in allocations
        )
        shortage_quantity = requested_quantity - allocated_quantity

        if shortage_quantity < 0:
            raise FulfillmentPlanningError(
                "Planner allocated more than the requested quantity."
            )

        if shortage_quantity > 0 and unknown_sources:
            decision = FulfillmentDecision.NEEDS_REVIEW
            reason = (
                f"{reason} Some inventory snapshots are missing, so "
                "the shortage is provisional and must not be treated "
                "as confirmed unavailability."
            )

        elif allocated_quantity == 0:
            decision = FulfillmentDecision.UNAVAILABLE
            reason = (
                f"{reason} All candidate source snapshots are known, "
                "and no stock can be allocated."
            )

        elif shortage_quantity > 0:
            decision = FulfillmentDecision.PARTIAL_AVAILABILITY
            reason = (
                f"{reason} Only part of the requested quantity can "
                "currently be planned."
            )

        else:
            source_ids = {
                allocation.source_branch_id
                for allocation in allocations
            }

            if len(source_ids) > 1:
                decision = FulfillmentDecision.MIXED_SOURCES

            elif self._central_warehouse_id in source_ids:
                decision = FulfillmentDecision.CENTRAL_WAREHOUSE

            elif allocations[0].source_branch_id == (
                # Destination/local source is identified by the
                # source itself in _plan_line; see the note below.
                ""
            ):
                # This branch is intentionally unreachable; the
                # destination ID is handled in _decision_for_complete_plan.
                decision = FulfillmentDecision.NEEDS_REVIEW

            else:
                decision = FulfillmentDecision.BRANCH_TRANSFER

        return LineFulfillmentPlan(
            item_code=item_code,
            requested_quantity=requested_quantity,
            allocated_quantity=allocated_quantity,
            shortage_quantity=shortage_quantity,
            decision=decision,
            allocations=tuple(allocations),
            reason=reason,
        )

    @staticmethod
    def _make_reason(
        *,
        requested_quantity: int,
        allocations: Sequence[Allocation],
        unknown_sources: Sequence[str],
    ) -> str:
        allocated_quantity = sum(a.quantity for a in allocations)

        if allocated_quantity == requested_quantity:
            return "The requested quantity can be planned from known snapshots."

        if allocated_quantity > 0:
            return "The available snapshots support a partial allocation."

        if unknown_sources:
            return "No stock was allocated; one or more snapshots are unknown."

        return "No candidate source has stock available."

    @staticmethod
    def _unique_preserving_order(
        values: Sequence[str],
    ) -> list[str]:
        return list(dict.fromkeys(values))
#تصحيح
def _build_line_plan(
    self,
    *,
    item_code: int,
    requested_quantity: int,
    destination_branch_id: str,
    allocations: Sequence[Allocation],
    unknown_sources: Sequence[str],
    reason: str,
) -> LineFulfillmentPlan:
    allocated_quantity = sum(
        allocation.quantity for allocation in allocations
    )
    shortage_quantity = requested_quantity - allocated_quantity

    if shortage_quantity < 0:
        raise FulfillmentPlanningError(
            "Planner allocated more than the requested quantity."
        )

    if shortage_quantity > 0 and unknown_sources:
        decision = FulfillmentDecision.NEEDS_REVIEW
        reason = (
            f"{reason} Some inventory snapshots are missing; "
            "the shortage is provisional."
        )

    elif allocated_quantity == 0:
        decision = FulfillmentDecision.UNAVAILABLE

    elif shortage_quantity > 0:
        decision = FulfillmentDecision.PARTIAL_AVAILABILITY

    else:
        source_ids = {
            allocation.source_branch_id
            for allocation in allocations
        }

        if len(source_ids) > 1:
            decision = FulfillmentDecision.MIXED_SOURCES

        elif self._central_warehouse_id in source_ids:
            decision = FulfillmentDecision.CENTRAL_WAREHOUSE

        elif destination_branch_id in source_ids:
            decision = FulfillmentDecision.LOCAL_STOCK

        else:
            decision = FulfillmentDecision.BRANCH_TRANSFER

    return LineFulfillmentPlan(
        item_code=item_code,
        requested_quantity=requested_quantity,
        allocated_quantity=allocated_quantity,
        shortage_quantity=shortage_quantity,
        decision=decision,
        allocations=tuple(allocations),
        reason=reason,
    )
  destination_branch_id=destination_branch_id,
if self._central_warehouse_id in branch_ids:
    raise FulfillmentPlanningError(
        "The central warehouse must not be returned "
        "as a nearby branch."
    )
