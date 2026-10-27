
CREATE TABLE IF NOT EXISTS dw.fact_order_items (
    order_item_id BIGINT PRIMARY KEY,
    order_id BIGINT NOT NULL,

    customer_key BIGINT NOT NULL
        REFERENCES dw.dim_customer(customer_key),

    product_key BIGINT NOT NULL
        REFERENCES dw.dim_product(product_key),

    geography_key BIGINT NOT NULL
        REFERENCES dw.dim_geography(geography_key),

    order_status_key BIGINT NOT NULL
        REFERENCES dw.dim_order_status(order_status_key),

    order_date_key INTEGER NOT NULL
        REFERENCES dw.dim_date(date_key),

    shipping_date_key INTEGER NOT NULL
        REFERENCES dw.dim_date(date_key),

    days_for_shipping_real INTEGER,
    days_for_shipment_scheduled INTEGER,
    late_delivery_risk INTEGER,

    order_item_quantity INTEGER,
    order_item_product_price NUMERIC(18, 2),
    order_item_discount NUMERIC(18, 2),
    order_item_discount_rate NUMERIC(12, 6),
    order_item_total NUMERIC(18, 2),

    sales NUMERIC(18, 2),
    sales_per_customer NUMERIC(18, 2),
    benefit_per_order NUMERIC(18, 2),
    order_profit_per_order NUMERIC(18, 2),
    order_item_profit_ratio NUMERIC(12, 6)
);
