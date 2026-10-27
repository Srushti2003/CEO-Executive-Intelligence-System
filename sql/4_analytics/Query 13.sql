
SELECT
    g.order_country,
    COUNT(DISTINCT f.order_id) AS distinct_orders,
    COUNT(*) AS total_order_items,
    COUNT(DISTINCT f.customer_key) AS distinct_customers,
    ROUND(SUM(f.sales), 2) AS total_sales,
    ROUND(SUM(f.order_item_discount), 2) AS total_discounts,
    ROUND(SUM(f.order_profit_per_order), 2)
        AS dataset_reported_profit

FROM dw.fact_order_items f
JOIN dw.dim_geography g
    ON g.geography_key = f.geography_key

GROUP BY g.order_country
ORDER BY total_sales DESC
LIMIT 15;
