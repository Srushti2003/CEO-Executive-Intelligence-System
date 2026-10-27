
-- Compare the fact table with the executive KPI view
SELECT
    (SELECT COUNT(*) FROM dw.fact_order_items)
        AS fact_rows,

    (SELECT SUM(sales) FROM dw.fact_order_items)
        AS fact_sales,

    (SELECT SUM(total_sales) FROM mart.vw_monthly_performance)
        AS monthly_view_sales,

    (SELECT SUM(total_sales) FROM mart.vw_product_performance)
        AS product_view_sales,

    (SELECT SUM(total_sales) FROM mart.vw_customer_segment_performance)
        AS segment_view_sales,

    (SELECT SUM(total_sales) FROM mart.vw_geography_performance)
        AS geography_view_sales,

    (SELECT SUM(total_sales) FROM mart.vw_shipping_performance)
        AS shipping_view_sales;
