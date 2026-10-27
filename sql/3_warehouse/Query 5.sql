
-- Load geography dimension
INSERT INTO dw.dim_geography (
    order_city,
    order_state,
    order_country,
    order_region,
    market
)
SELECT DISTINCT
    s."Order City",
    s."Order State",
    s."Order Country",
    s."Order Region",
    s."Market"
FROM stg.dataco_cleaned_raw s
ON CONFLICT DO NOTHING;


-- Load order and shipping status dimension
INSERT INTO dw.dim_order_status (
    shipping_mode,
    delivery_status,
    order_status
)
SELECT DISTINCT
    s."Shipping Mode",
    s."Delivery Status",
    s."Order Status"
FROM stg.dataco_cleaned_raw s
ON CONFLICT DO NOTHING;
