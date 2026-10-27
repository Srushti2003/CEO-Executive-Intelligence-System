
SELECT
    COUNT(*) AS order_item_rows,
    COUNT(DISTINCT order_id) AS distinct_orders,

    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(order_item_total), 2) AS total_order_item_value,
    ROUND(SUM(order_item_discount), 2) AS total_item_discount,

    ROUND(SUM(benefit_per_order), 2) AS sum_benefit_per_order,
    ROUND(SUM(order_profit_per_order), 2) AS sum_order_profit_per_order,

    ROUND(AVG(order_item_profit_ratio)::NUMERIC, 4)
        AS average_item_profit_ratio,

    COUNT(*) FILTER (
        WHERE late_delivery_risk = 1
    ) AS items_flagged_for_late_delivery,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE late_delivery_risk = 1
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS late_delivery_risk_pct

FROM dw.fact_order_items;
