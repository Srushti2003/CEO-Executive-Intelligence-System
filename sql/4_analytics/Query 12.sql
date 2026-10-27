
SELECT
    os.shipping_mode,

    COUNT(*) FILTER (
        WHERE os.delivery_status = 'Late delivery'
    ) AS late_items,

    COUNT(*) FILTER (
        WHERE os.delivery_status = 'Shipping on time'
    ) AS on_time_items,

    COUNT(*) FILTER (
        WHERE os.delivery_status = 'Advance shipping'
    ) AS advance_items,

    COUNT(*) FILTER (
        WHERE os.delivery_status = 'Shipping canceled'
    ) AS canceled_items,

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
    ) AS late_delivery_rate_pct,

    ROUND(SUM(f.sales), 2) AS total_sales

FROM dw.fact_order_items f
JOIN dw.dim_order_status os
    ON os.order_status_key = f.order_status_key

GROUP BY os.shipping_mode
ORDER BY late_delivery_rate_pct DESC;
