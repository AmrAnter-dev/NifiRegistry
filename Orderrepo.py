from __future__ import annotations

from dataclasses import dataclass
from decimal import Decimal
from typing import Any, Optional, Sequence

import asyncpg


# ============================================================
# DTOs
# ============================================================

@dataclass(frozen=True)
class OrderItemCreate:
    product_id: int
    product_name: str
    product_sku: Optional[str]
    product_category: Optional[str]

    unit_of_measure: str
    quantity: Decimal
    unit_price: Decimal

    discount_percent: Decimal = Decimal("0")
    tax_rate: Decimal = Decimal("0")


@dataclass(frozen=True)
class OrderCreate:
    customer_id: int
    customer_name: str
    customer_email: Optional[str]
    customer_phone: Optional[str]

    billing_address: Optional[str]
    billing_city: Optional[str]
    billing_country: Optional[str]

    shipping_address: Optional[str]
    shipping_city: Optional[str]
    shipping_country: Optional[str]

    salesperson_name: Optional[str]
    currency_code: str

    status: str
    required_date: Optional[Any]

    created_by: Optional[str]

    items: Sequence[OrderItemCreate]


@dataclass(frozen=True)
class CreatedOrderItem:
    order_item_id: int
    line_number: int
    product_id: int
    product_name: str
    quantity: Decimal
    unit_price: Decimal


@dataclass(frozen=True)
class CreatedOrder:
    order_id: int
    order_number: str
    customer_id: int
    status: str
    order_date: Any
    created_at: Any
    items: Sequence[CreatedOrderItem]


# ============================================================
# Exceptions
# ============================================================

class OrderRepositoryError(Exception):
    pass


class OrderCreationError(OrderRepositoryError):
    pass


class OrderDataConflictError(OrderRepositoryError):
    pass


# ============================================================
# Repository
# ============================================================

class OrderRepository:

    def __init__(self, pool_manager):
        self.pool_manager = pool_manager

    async def create_order(
        self,
        order: OrderCreate,
        branch_name: str,
    ) -> CreatedOrder:

        if not order.items:
            raise ValueError(
                "Cannot create an order without items."
            )

        pool = await self.pool_manager.get_pool(
            branch_name
        )

        async with pool.acquire() as conn:

            try:

                async with conn.transaction():

                    # =================================================
                    # 1. Generate Order Number
                    # =================================================
                    #
                    # PostgreSQL SEQUENCE is concurrency-safe.
                    #
                    # Example:
                    # SO-2026-000451
                    #
                    # We do NOT use MAX(order_number) + 1.
                    # =================================================

                    sequence_value = await conn.fetchval(
                        """
                        SELECT nextval(
                            'sales.order_number_seq'
                        )
                        """
                    )

                    current_year = await conn.fetchval(
                        """
                        SELECT EXTRACT(
                            YEAR FROM CURRENT_TIMESTAMP
                        )::INT
                        """
                    )

                    order_number = (
                        f"SO-{current_year}-{sequence_value:06d}"
                    )

                    # VARCHAR(20) safety check
                    if len(order_number) > 20:
                        raise OrderCreationError(
                            "Generated order number exceeds "
                            "database column length."
                        )

                    # =================================================
                    # 2. Create Order Header
                    # =================================================

                    header = await conn.fetchrow(
                        """
                        INSERT INTO sales.orderheader
                        (
                            order_number,

                            customer_id,
                            customer_name,
                            customer_email,
                            customer_phone,

                            billing_address,
                            billing_city,
                            billing_country,

                            shipping_address,
                            shipping_city,
                            shipping_country,

                            salesperson_name,
                            currency_code,
                            status,
                            required_date,

                            created_by
                        )
                        VALUES
                        (
                            $1,

                            $2,
                            $3,
                            $4,
                            $5,

                            $6,
                            $7,
                            $8,

                            $9,
                            $10,
                            $11,

                            $12,
                            $13,
                            $14,
                            $15,

                            $16
                        )
                        RETURNING
                            order_id,
                            order_number,
                            customer_id,
                            status,
                            order_date,
                            created_at
                        """,

                        order_number,

                        order.customer_id,
                        order.customer_name,
                        order.customer_email,
                        order.customer_phone,

                        order.billing_address,
                        order.billing_city,
                        order.billing_country,

                        order.shipping_address,
                        order.shipping_city,
                        order.shipping_country,

                        order.salesperson_name,
                        order.currency_code,
                        order.status,
                        order.required_date,

                        order.created_by,
                    )

                    if header is None:
                        raise OrderCreationError(
                            "Order header was not created."
                        )

                    order_id = header["order_id"]

                    # =================================================
                    # 3. Create Order Items
                    # =================================================

                    created_items: list[
                        CreatedOrderItem
                    ] = []

                    for line_number, item in enumerate(
                        order.items,
                        start=1,
                    ):

                        row = await conn.fetchrow(
                            """
                            INSERT INTO sales.orderitems
                            (
                                order_id,
                                line_number,

                                product_id,
                                product_name,
                                product_sku,
                                product_category,

                                unit_of_measure,

                                quantity,
                                unit_price,
                                discount_percent,
                                tax_rate,

                                created_by
                            )
                            VALUES
                            (
                                $1,
                                $2,

                                $3,
                                $4,
                                $5,
                                $6,

                                $7,

                                $8,
                                $9,
                                $10,
                                $11,

                                $12
                            )
                            RETURNING
                                order_item_id,
                                line_number,
                                product_id,
                                product_name,
                                quantity,
                                unit_price
                            """,

                            order_id,
                            line_number,

                            item.product_id,
                            item.product_name,
                            item.product_sku,
                            item.product_category,

                            item.unit_of_measure,

                            item.quantity,
                            item.unit_price,
                            item.discount_percent,
                            item.tax_rate,

                            order.created_by,
                        )

                        if row is None:
                            raise OrderCreationError(
                                f"Failed to create order item "
                                f"for line {line_number}."
                            )

                        created_items.append(
                            CreatedOrderItem(
                                order_item_id=row[
                                    "order_item_id"
                                ],
                                line_number=row[
                                    "line_number"
                                ],
                                product_id=row[
                                    "product_id"
                                ],
                                product_name=row[
                                    "product_name"
                                ],
                                quantity=row[
                                    "quantity"
                                ],
                                unit_price=row[
                                    "unit_price"
                                ],
                            )
                        )

                    # =================================================
                    # 4. Return Created Order
                    # =================================================

                    return CreatedOrder(
                        order_id=header["order_id"],
                        order_number=header[
                            "order_number"
                        ],
                        customer_id=header[
                            "customer_id"
                        ],
                        status=header["status"],
                        order_date=header[
                            "order_date"
                        ],
                        created_at=header[
                            "created_at"
                        ],
                        items=created_items,
                    )

            # =====================================================
            # Constraint / DB errors
            # =====================================================

            except asyncpg.UniqueViolationError as exc:

                raise OrderDataConflictError(
                    "Order creation violated a unique "
                    "constraint."
                ) from exc

            except asyncpg.ForeignKeyViolationError as exc:

                raise OrderDataConflictError(
                    "Order references invalid data."
                ) from exc

            except asyncpg.CheckViolationError as exc:

                raise OrderDataConflictError(
                    "Order data violates a database constraint."
                ) from exc

            except (
                asyncpg.PostgresError,
                OSError,
            ) as exc:

                raise OrderCreationError(
                    "Database error while creating order."
                ) from exc
