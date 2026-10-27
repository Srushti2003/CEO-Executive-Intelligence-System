
CREATE OR REPLACE VIEW mart.vw_monthly_performance AS
SELECT
    DATE_TRUNC('month', d.full_date)::DATE AS order_month,

    COUNT(*) AS total_order_items,
    COUNT(DISTINCT f.order_id) AS total_orders,

    ROUND(SUM(f.sales), 2) AS total_sales,
    ROUND(SUM(f.order_item_total), 2) AS total_order_item_value,
    ROUND(SUM(f.order_item_discount), 2) AS total_discounts,

    ROUND(SUM(f.order_profit_per_order), 2)
        AS dataset_reported_profit,

    ROUND(
        100.0 * SUM(f.order_profit_per_order)
        / NULLIF(SUM(f.sales), 0),
        2
    ) AS dataset_reported_profit_margin_pct,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE os.delivery_status = 'Late delivery'
        ) / NULLIF(
            COUNT(*) FILTER (
                WHERE os.delivery_status <> 'Shipping canceled'
            ),
            0
        ),
        2
    ) AS late_delivery_rate_excluding_canceled_pct

FROM dw.fact_order_items f
JOIN dw.dim_date d
    ON d.date_key = f.order_date_key
JOIN dw.dim_order_status os
    ON os.order_status_key = f.order_status_key

GROUP BY DATE_TRUNC('month', d.full_date)::DATE;
