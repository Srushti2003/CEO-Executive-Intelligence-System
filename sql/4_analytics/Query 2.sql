
SELECT
    COUNT(*) AS orders_checked,

    COUNT(*) FILTER (
        WHERE item_count > 1
    ) AS multi_item_orders,

    COUNT(*) FILTER (
        WHERE item_count > 1
          AND distinct_profit_values = 1
    ) AS multi_item_orders_with_repeated_profit,

    COUNT(*) FILTER (
        WHERE item_count > 1
          AND distinct_benefit_values = 1
    ) AS multi_item_orders_with_repeated_benefit

FROM (
    SELECT
        order_id,
        COUNT(*) AS item_count,
        COUNT(DISTINCT order_profit_per_order)
            AS distinct_profit_values,
        COUNT(DISTINCT benefit_per_order)
            AS distinct_benefit_values
    FROM dw.fact_order_items
    GROUP BY order_id
) order_checks;
