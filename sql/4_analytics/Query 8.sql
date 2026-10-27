
CREATE OR REPLACE VIEW mart.vw_customer_segment_performance AS
SELECT
    c.customer_segment,
    COUNT(DISTINCT f.customer_key) AS total_customers,
    COUNT(DISTINCT f.order_id) AS total_orders,
    COUNT(*) AS total_order_items,
    SUM(f.order_item_quantity) AS units_sold,

    ROUND(SUM(f.sales), 2) AS total_sales,
    ROUND(SUM(f.order_item_discount), 2) AS total_discounts,
    ROUND(SUM(f.order_profit_per_order), 2)
        AS dataset_reported_profit,

    ROUND(
        100.0 * SUM(f.order_profit_per_order)
        / NULLIF(SUM(f.sales), 0),
        2
    ) AS dataset_reported_profit_margin_pct

FROM dw.fact_order_items f
JOIN dw.dim_customer c
    ON c.customer_key = f.customer_key

GROUP BY c.customer_segment;
