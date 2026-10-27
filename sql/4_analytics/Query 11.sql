
-- Customer segment performance
SELECT *
FROM mart.vw_customer_segment_performance
ORDER BY total_sales DESC;

-- Top 15 countries by sales
SELECT
    order_country,
    SUM(total_orders) AS summed_city_order_counts,
    SUM(total_sales) AS total_sales,
    SUM(dataset_reported_profit) AS dataset_reported_profit
FROM mart.vw_geography_performance
GROUP BY order_country
ORDER BY total_sales DESC
LIMIT 15;

-- Shipping performance
SELECT *
FROM mart.vw_shipping_performance
ORDER BY shipping_mode, total_order_items DESC;
