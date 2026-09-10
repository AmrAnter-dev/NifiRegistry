CREATE SCHEMA IF NOT EXISTS inventory;
CREATE SCHEMA IF NOT EXISTS extensions;

CREATE EXTENSION IF NOT EXISTS pgcrypto
SCHEMA extensions;

CREATE TABLE sales.orderitem (
    order_item_id       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    order_id            BIGINT NOT NULL,

    item_code           INT NOT NULL,

    product_name        VARCHAR(255) NOT NULL,

    sales_unit          VARCHAR(30) NOT NULL,

    quantity            INT NOT NULL,

    unit_price          BIGINT NOT NULL,

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
