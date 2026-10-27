
INSERT INTO dw.fact_order_items (
    order_item_id,
    order_id,
    customer_key,
    product_key,
    geography_key,
    order_status_key,
    order_date_key,
    shipping_date_key,
    days_for_shipping_real,
    days_for_shipment_scheduled,
    late_delivery_risk,
    order_item_quantity,
    order_item_product_price,
    order_item_discount,
    order_item_discount_rate,
    order_item_total,
    sales,
    sales_per_customer,
    benefit_per_order,
    order_profit_per_order,
    order_item_profit_ratio
)
SELECT
    s."Order Item Id"::BIGINT,
    s."Order Id"::BIGINT,
    c.customer_key,
    p.product_key,
    g.geography_key,
    os.order_status_key,

    TO_CHAR(
        NULLIF(TRIM(s."order date (DateOrders)"), '')::TIMESTAMP::DATE,
        'YYYYMMDD'
    )::INTEGER,

    TO_CHAR(
        NULLIF(TRIM(s."shipping date (DateOrders)"), '')::TIMESTAMP::DATE,
        'YYYYMMDD'
    )::INTEGER,

    s."Days for shipping (real)"::INTEGER,
    s."Days for shipment (scheduled)"::INTEGER,
    s."Late_delivery_risk"::INTEGER,

    s."Order Item Quantity"::INTEGER,
    s."Order Item Product Price"::NUMERIC(18, 2),
    s."Order Item Discount"::NUMERIC(18, 2),
    s."Order Item Discount Rate"::NUMERIC(12, 6),
    s."Order Item Total"::NUMERIC(18, 2),

    s."Sales"::NUMERIC(18, 2),
    s."Sales per customer"::NUMERIC(18, 2),
    s."Benefit per order"::NUMERIC(18, 2),
    s."Order Profit Per Order"::NUMERIC(18, 2),
    s."Order Item Profit Ratio"::NUMERIC(12, 6)

FROM stg.dataco_cleaned_raw s

JOIN dw.dim_customer c
    ON c.customer_id = s."Customer Id"::BIGINT

JOIN dw.dim_product p
    ON p.product_card_id = s."Order Item Cardprod Id"::BIGINT

JOIN dw.dim_geography g
    ON g.order_city = s."Order City"
   AND g.order_state = s."Order State"
   AND g.order_country = s."Order Country"
   AND g.order_region = s."Order Region"
   AND g.market = s."Market"

JOIN dw.dim_order_status os
    ON os.shipping_mode = s."Shipping Mode"
   AND os.delivery_status = s."Delivery Status"
   AND os.order_status = s."Order Status"

ON CONFLICT (order_item_id) DO NOTHING;
