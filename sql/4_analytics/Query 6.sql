
CREATE OR REPLACE VIEW mart.vw_product_performance AS
SELECT
    p.product_card_id,
    p.product_name,
    p.category_name,
    p.department_name,

    COUNT(*) AS total_order_items,
    COUNT(DISTINCT f.order_id) AS distinct_orders,
    SUM(f.order_item_quantity) AS units_sold,

    ROUND(SUM(f.sales), 2) AS total_sales,
    ROUND(SUM(f.order_item_discount), 2) AS total_discounts,
    ROUND(SUM(f.order_item_total), 2) AS total_order_item_value,

    ROUND(SUM(f.order_profit_per_order), 2)
        AS dataset_reported_profit,

    ROUND(
        100.0 * SUM(f.order_profit_per_order)
        / NULLIF(SUM(f.sales), 0),
        2
    ) AS dataset_reported_profit_margin_pct

FROM dw.fact_order_items f
JOIN dw.dim_product p
    ON p.product_key = f.product_key

GROUP BY
    p.product_card_id,
    p.product_name,
    p.category_name,
    p.department_name;
