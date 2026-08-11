from dataclasses import dataclass
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
    ACCEPTED = "ACCEPTED"
    FULFILLED = "FULFILLED"
    REJECTED = "REJECTED"
    TIMEOUT = "TIMEOUT"


class ShipmentOption(str, Enum):
    SEPARATE_SHIPMENT = "SEPARATE_SHIPMENT"
    WAIT_FOR_ALL = "WAIT_FOR_ALL"


@dataclass
class CartItem:
    item_code: str
    requested_quantity: int
    status: CartItemStatus

    customer_branch_id: int

    # موجودة عندما يكون status = PARTIALLY_AVAILABLE
    local_available_quantity: int = 0


@dataclass
class Cart:
    customer_id: int
    session_id: str
    items: list[CartItem]


@dataclass
class StockAllocation:
    branch_id: int
    available_quantity: int


@dataclass
class Branch:
    id: int
    distance_km: float


@dataclass
class TransferResult:
    fulfilled: bool
    source_branch_id: Optional[int] = None
    source: Optional[FulfillmentSource] = None


@dataclass
class FulfillmentPlan:
    item: CartItem

    local_quantity: int = 0
    transfer_quantity: int = 0

    source_branch_id: Optional[int] = None
    source: Optional[FulfillmentSource] = None

    fulfilled: bool = False
    requires_transfer: bool = False
