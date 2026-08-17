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

CREATE TABLE sales.transfer (
    transfer_id         UUID PRIMARY KEY,

    order_item_id       BIGINT NOT NULL,

    source_id            BIGINT NOT NULL,

    source_type          VARCHAR(30) NOT NULL,

    quantity             INT NOT NULL,

    status               VARCHAR(30) NOT NULL,

    created_at           TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at           TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_transfer_orderitem
        FOREIGN KEY (order_item_id)
        REFERENCES sales.orderitem(order_item_id),

    CONSTRAINT ck_transfer_quantity
        CHECK (quantity > 0)
);
