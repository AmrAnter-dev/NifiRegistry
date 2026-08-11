from dataclasses import dataclass, field
from enum import Enum
from typing import Optional


class CartItemStatus(str, Enum):
    LOCAL_AVAILABLE = "LOCAL_AVAILABLE"
    PARTIALLY_AVAILABLE = "PARTIALLY_AVAILABLE"
    NETWORK_AVAILABLE = "NETWORK_AVAILABLE"
    OUT_OF_STOCK = "OUT_OF_STOCK"


class FulfillmentSource(str, Enum):
    LOCAL_BRANCH = "LOCAL_BRANCH"
    NETWORK_BRANCH = "NETWORK_BRANCH"
    MAIN_WAREHOUSE = "MAIN_WAREHOUSE"


class TransferStatus(str, Enum):
    PENDING = "PENDING"
    FULFILLED = "FULFILLED"
    REJECTED = "REJECTED"
    TIMEOUT = "TIMEOUT"


class ShipmentOption(str, Enum):
    SEPARATE_SHIPMENT = "SEPARATE_SHIPMENT"
    WAIT_FOR_ALL = "WAIT_FOR_ALL"


class CheckoutStatus(str, Enum):
    READY = "READY"
    ACTION_REQUIRED = "ACTION_REQUIRED"
    PENDING_FOR_TRANSFER = "PENDING_FOR_TRANSFER"
    COMPLETED = "COMPLETED"


@dataclass
class CartItem:
    item_code: str
    requested_quantity: int
    status: CartItemStatus
    customer_branch_id: int

    # Meaningful for PARTIALLY_AVAILABLE
    local_available_quantity: int = 0


@dataclass
class StockAllocation:
    branch_id: int
    available_quantity: int


@dataclass
class Branch:
    id: int
    distance_km: float


@dataclass
class TransferAllocation:
    source_id: int
    quantity: int
    source: FulfillmentSource


@dataclass
class FulfillmentPlan:
    item: CartItem

    local_quantity: int = 0

    transfer_allocations: list[TransferAllocation] = field(
        default_factory=list
    )

    fulfilled: bool = False


@dataclass
class TransferResult:
    transfer_id: str
    status: TransferStatus
    source_id: int
