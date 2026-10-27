
-- A. Check relationships between financial fields
SELECT
    COUNT(*) AS total_items,

    COUNT(*) FILTER (
        WHERE ABS(
            sales - order_item_total - order_item_discount
        ) <= 0.02
    ) AS rows_matching_sales_minus_total_equals_discount,

    COUNT(*) FILTER (
        WHERE ABS(
            sales - (
                order_item_product_price * order_item_quantity
            )
        ) <= 0.02
    ) AS rows_matching_price_times_quantity,

    COUNT(*) FILTER (
        WHERE ABS(
            benefit_per_order - order_profit_per_order
        ) <= 0.01
    ) AS rows_with_matching_profit_fields,

    ROUND(
        SUM(sales - order_item_total - order_item_discount),
        2
    ) AS total_financial_difference

FROM dw.fact_order_items;


-- B. Inspect actual delivery statuses
SELECT
    delivery_status,
    late_delivery_risk,
    COUNT(*) AS item_count
FROM dw.fact_order_items f
JOIN dw.dim_order_status os
    ON os.order_status_key = f.order_status_key
GROUP BY delivery_status, late_delivery_risk
ORDER BY item_count DESC;


-- C. Check order-item quantity and financial values
SELECT
    COUNT(*) FILTER (
        WHERE order_item_quantity <= 0
    ) AS nonpositive_quantities,

    COUNT(*) FILTER (
        WHERE sales < 0
    ) AS negative_sales_rows,

    COUNT(*) FILTER (
        WHERE order_item_discount < 0
    ) AS negative_discount_rows,

    COUNT(*) FILTER (
        WHERE order_item_total < 0
    ) AS negative_item_total_rows,

    COUNT(*) FILTER (
        WHERE benefit_per_order < 0
    ) AS negative_benefit_rows,

    COUNT(*) FILTER (
        WHERE order_profit_per_order < 0
    ) AS negative_profit_rows

FROM dw.fact_order_items;
