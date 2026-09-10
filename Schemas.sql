CREATE SCHEMA IF NOT EXISTS extensions;
CREATE SCHEMA IF NOT EXISTS product;
CREATE SCHEMA IF NOT EXISTS inventory;
CREATE SCHEMA IF NOT EXISTS promotion;
CREATE SCHEMA IF NOT EXISTS sales;

CREATE EXTENSION IF NOT EXISTS pgcrypto
SCHEMA extensions;

CREATE TABLE sales.orderitem (
    order_item_id       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    order_id            BIGINT NOT NULL,

    item_code           INT NOT NULL,

    product_name        VARCHAR(255) NOT NULL,

    sales_unit          VARCHAR(30) NOT NULL,

    quantity            INT NOT NULL,

    unit_sale_price          BIGINT NOT NULL,
	gross_amount 		NUMERIC(14,2) GENERATED ALWAYS AS
    (
        quantity * unit_list_price
    ) STORED,


    line_total          BIGINT NOT NULL,

    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_orderitem_order
        FOREIGN KEY (order_id)
        REFERENCES sales.orderheader(order_id),

    CONSTRAINT ck_orderitem_quantity
        CHECK (quantity > 0),

    CONSTRAINT ck_orderitem_unit_price
        CHECK (unit_price >= 0)
);
--شكل تانى للجدول


CREATE TABLE sales.order_item
(
    -- =========================================================
    -- Identity
    -- =========================================================

    order_item_id BIGINT GENERATED ALWAYS AS IDENTITY,

    order_id BIGINT NOT NULL,

    -- Product sold
    product_id BIGINT NOT NULL,

    -- Optional reference to the cart item / source line
    cart_item_id BIGINT NULL,

    -- =========================================================
    -- Product Snapshot
    -- =========================================================

    -- Product code at the time of sale
    item_code VARCHAR(50) NOT NULL,

    -- Product name at the time of sale
    product_name VARCHAR(255) NOT NULL,

    -- =========================================================
    -- Quantity
    -- =========================================================

    quantity NUMERIC(12,3) NOT NULL,

    -- Unit of measure: BOX, PACK, PIECE, etc.
    unit_type VARCHAR(30) NOT NULL DEFAULT 'UNIT',

    -- =========================================================
    -- Pricing Snapshot
    -- =========================================================

    -- Price before any discount
    unit_list_price NUMERIC(14,2) NOT NULL,

    -- Actual selling price before line-level discount
    unit_sale_price NUMERIC(14,2) NOT NULL,

    -- Total before discounts and taxes
    gross_amount NUMERIC(14,2) GENERATED ALWAYS AS
    (
        quantity * unit_list_price
    ) STORED,

    -- =========================================================
    -- Discounts
    -- =========================================================

    discount_type VARCHAR(20) NULL,

    -- Percentage used if discount_type = PERCENTAGE
    discount_percentage NUMERIC(7,4) NULL,

    -- Total discount amount for this line
    discount_amount NUMERIC(14,2) NOT NULL DEFAULT 0,

    -- =========================================================
    -- Tax
    -- =========================================================

    tax_code VARCHAR(30) NULL,

    tax_rate NUMERIC(7,4) NOT NULL DEFAULT 0,

    -- Tax amount calculated at the time of sale
    tax_amount NUMERIC(14,2) NOT NULL DEFAULT 0,

    -- =========================================================
    -- Totals
    -- =========================================================

    -- Amount after discount, before tax
    net_amount NUMERIC(14,2) GENERATED ALWAYS AS
    (
        (quantity * unit_sale_price) - discount_amount
    ) STORED,

    -- Final amount including tax
    total_amount NUMERIC(14,2) GENERATED ALWAYS AS
    (
        ((quantity * unit_sale_price) - discount_amount)
        + tax_amount
    ) STORED,

    -- =========================================================
    -- Promotion
    -- =========================================================

    promotion_id BIGINT NULL,

    promotion_code VARCHAR(50) NULL,

    promotion_name VARCHAR(255) NULL,

    -- =========================================================
    -- Inventory / Fulfillment
    -- =========================================================

    fulfillment_status VARCHAR(30) NOT NULL DEFAULT 'PENDING',

    fulfilled_quantity NUMERIC(12,3) NOT NULL DEFAULT 0,

    cancelled_quantity NUMERIC(12,3) NOT NULL DEFAULT 0,

    -- =========================================================
    -- Return Information
    -- =========================================================

    returned_quantity NUMERIC(12,3) NOT NULL DEFAULT 0,

    -- =========================================================
    -- Batch / Expiry
    -- =========================================================

    batch_number VARCHAR(100) NULL,

    expiry_date DATE NULL,

    -- =========================================================
    -- Notes
    -- =========================================================

    notes TEXT NULL,

    -- =========================================================
    -- Audit
    -- =========================================================

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    -- =========================================================
    -- Primary Key
    -- =========================================================

    CONSTRAINT pk_order_item
        PRIMARY KEY (order_item_id),

    -- =========================================================
    -- Foreign Keys
    -- =========================================================

    CONSTRAINT fk_order_item_order
        FOREIGN KEY (order_id)
        REFERENCES sales.order_header (order_id),

    CONSTRAINT fk_order_item_product
        FOREIGN KEY (product_id)
        REFERENCES product.product (product_id),

    -- =========================================================
    -- Quantity Constraints
    -- =========================================================

    CONSTRAINT ck_order_item_quantity
        CHECK (quantity > 0),

    CONSTRAINT ck_order_item_fulfilled_quantity
        CHECK (fulfilled_quantity >= 0),

    CONSTRAINT ck_order_item_cancelled_quantity
        CHECK (cancelled_quantity >= 0),

    CONSTRAINT ck_order_item_returned_quantity
        CHECK (returned_quantity >= 0),

    CONSTRAINT ck_order_item_quantity_flow
        CHECK
        (
            fulfilled_quantity
            + cancelled_quantity
            <= quantity
        ),

    CONSTRAINT ck_order_item_return_quantity
        CHECK
        (
            returned_quantity <= fulfilled_quantity
        ),

    -- =========================================================
    -- Price Constraints
    -- =========================================================

    CONSTRAINT ck_order_item_list_price
        CHECK (unit_list_price >= 0),

    CONSTRAINT ck_order_item_sale_price
        CHECK (unit_sale_price >= 0),

    CONSTRAINT ck_order_item_discount_amount
        CHECK (discount_amount >= 0),

    -- Discount cannot exceed gross amount
    CONSTRAINT ck_order_item_discount_limit
        CHECK
        (
            discount_amount
            <= quantity * unit_sale_price
        ),

    -- =========================================================
    -- Discount Constraints
    -- =========================================================

    CONSTRAINT ck_order_item_discount_type
        CHECK
        (
            discount_type IS NULL
            OR discount_type IN
            (
                'PERCENTAGE',
                'FIXED',
                'PROMOTION'
            )
        ),

    CONSTRAINT ck_order_item_discount_percentage
        CHECK
        (
            discount_percentage IS NULL
            OR
            (
                discount_percentage >= 0
                AND discount_percentage <= 100
            )
        ),

    -- =========================================================
    -- Tax Constraints
    -- =========================================================

    CONSTRAINT ck_order_item_tax_rate
        CHECK
        (
            tax_rate >= 0
            AND tax_rate <= 100
        ),

    CONSTRAINT ck_order_item_tax_amount
        CHECK (tax_amount >= 0),

    -- =========================================================
    -- Fulfillment Status
    -- =========================================================

    CONSTRAINT ck_order_item_fulfillment_status
        CHECK
        (
            fulfillment_status IN
            (
                'PENDING',
                'ALLOCATED',
                'PARTIALLY_FULFILLED',
                'FULFILLED',
                'CANCELLED',
                'RETURNED'
            )
        )
);
CREATE INDEX ix_order_item_order_id
    ON sales.order_item (order_id);

CREATE INDEX ix_order_item_product_id
    ON sales.order_item (product_id);

CREATE INDEX ix_order_item_promotion_id
    ON sales.order_item (promotion_id);

CREATE INDEX ix_order_item_fulfillment_status
    ON sales.order_item (fulfillment_status);

CREATE INDEX ix_order_item_expiry_date
    ON sales.order_item (expiry_date)
    WHERE expiry_date IS NOT NULL;


CREATE TABLE sales.orderheader (
    order_id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    order_number        VARCHAR(20) NOT NULL,

    customer_id         BIGINT NOT NULL,
    session_id          UUID NOT NULL,

    status              VARCHAR(30) NOT NULL,

    shipment_option     VARCHAR(30),

    payment_method      VARCHAR(30),

    subtotal_amount     BIGINT NOT NULL DEFAULT 0,
    delivery_fee        BIGINT NOT NULL DEFAULT 0,
    total_amount        BIGINT NOT NULL DEFAULT 0,

    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT uq_order_number
        UNIQUE (order_number)
);


CREATE TABLE inventory.product_inventory
(
    inventory_id BIGINT GENERATED ALWAYS AS IDENTITY,

    product_id BIGINT NOT NULL,
	
	item_code VARCHAR(50) NOT NULL UNIQUE,
	
    quantity_on_hand INTEGER NOT NULL DEFAULT 0,

    reserved_quantity INTEGER NOT NULL DEFAULT 0,

    available_quantity INTEGER GENERATED ALWAYS AS
    (
        quantity_on_hand - reserved_quantity
    ) STORED,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_product_inventory
        PRIMARY KEY (inventory_id),

    CONSTRAINT uq_product_inventory_product
        UNIQUE (product_id),

    CONSTRAINT ck_quantity_on_hand
        CHECK (quantity_on_hand >= 0),

    CONSTRAINT ck_reserved_quantity
        CHECK (reserved_quantity >= 0),

    CONSTRAINT ck_reserved_not_exceed_on_hand
        CHECK (reserved_quantity <= quantity_on_hand)
		
	CONSTRAINT FK_product_inventory_product
        FOREIGN KEY (product_id)
        REFERENCES product.product(product_id),

);

CREATE TABLE inventory.reservation
(
    reservation_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    product_id BIGINT NOT NULL,

    quantity INTEGER NOT NULL,

    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',

    expires_at TIMESTAMPTZ NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    released_at TIMESTAMPTZ NULL,

    CONSTRAINT ck_reservation_quantity
        CHECK (quantity > 0),

    CONSTRAINT ck_reservation_status
        CHECK
        (
            status IN
            (
                'ACTIVE',
                'COMPLETED',
                'RELEASED',
                'EXPIRED'
            )
        )
	CONSTRAINT FK_reservation_product
        FOREIGN KEY (product_id)
        REFERENCES product.product(product_id),
);
CREATE TABLE inventory.transfer
(
    transfer_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    product_id BIGINT NOT NULL,

    destination_branch_id UUID NOT NULL,

    quantity INTEGER NOT NULL,

    status VARCHAR(30) NOT NULL DEFAULT 'PENDING',

    requested_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    approved_at TIMESTAMPTZ,

    shipped_at TIMESTAMPTZ,

    received_at TIMESTAMPTZ,

    cancelled_at TIMESTAMPTZ,

    CONSTRAINT ck_transfer_quantity
        CHECK (quantity > 0),


    CONSTRAINT ck_transfer_status
        CHECK
        (
            status IN
            (
               'PENDING',
                'APPROVED',
                'REJECTED',
                'FAILED'
            )
        )
	CONSTRAINT FK_transfer_product
        FOREIGN KEY (product_id)
        REFERENCES product.product(product_id)
		

		
	
);
