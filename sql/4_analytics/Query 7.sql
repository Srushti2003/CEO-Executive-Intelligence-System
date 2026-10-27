
-- Monthly performance, newest month first
SELECT *
FROM mart.vw_monthly_performance
ORDER BY order_month DESC;

-- Top 10 products by sales
SELECT *
FROM mart.vw_product_performance
ORDER BY total_sales DESC
LIMIT 10;

-- Category-level summary
SELECT
    category_name,
    SUM(total_order_items) AS total_order_items,
    SUM(units_sold) AS units_sold,
    ROUND(SUM(total_sales), 2) AS total_sales,
    ROUND(SUM(total_discounts), 2) AS total_discounts,
    ROUND(SUM(dataset_reported_profit), 2)
        AS dataset_reported_profit
FROM mart.vw_product_performance
GROUP BY category_name
ORDER BY total_sales DESC;
