
CREATE OR REPLACE VIEW mart.vw_shipping_performance AS
SELECT
    os.shipping_mode,
    os.delivery_status,
    f.late_delivery_risk,

    COUNT(*) AS total_order_items,
    COUNT(DISTINCT f.order_id) AS total_orders,

    ROUND(AVG(f.days_for_shipping_real)::NUMERIC, 2)
        AS avg_actual_shipping_days,

    ROUND(AVG(f.days_for_shipment_scheduled)::NUMERIC, 2)
        AS avg_scheduled_shipping_days,

    ROUND(SUM(f.sales), 2) AS total_sales,

    ROUND(
        100.0 * COUNT(*) / NULLIF(
            SUM(COUNT(*)) OVER (
                PARTITION BY os.shipping_mode
            ),
            0
        ),
        2
    ) AS pct_of_items_within_shipping_mode

FROM dw.fact_order_items f
JOIN dw.dim_order_status os
    ON os.order_status_key = f.order_status_key

GROUP BY
    os.shipping_mode,
    os.delivery_status,
    f.late_delivery_risk;
