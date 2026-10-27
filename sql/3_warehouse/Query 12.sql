
SELECT
    COUNT(*) AS fact_rows,
    COUNT(DISTINCT order_item_id) AS unique_order_items,
    COUNT(*) FILTER (
        WHERE customer_key IS NULL
           OR product_key IS NULL
           OR geography_key IS NULL
           OR order_status_key IS NULL
           OR order_date_key IS NULL
           OR shipping_date_key IS NULL
    ) AS rows_with_missing_keys,
    SUM(sales) AS total_sales,
    SUM(order_item_total) AS total_order_item_value
FROM dw.fact_order_items;
