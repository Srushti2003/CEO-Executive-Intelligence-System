
CREATE OR REPLACE VIEW mart.vw_executive_kpis AS
SELECT
    COUNT(*) AS total_order_items,
    COUNT(DISTINCT f.order_id) AS total_orders,
    COUNT(DISTINCT f.customer_key) AS total_customers,

    ROUND(SUM(f.sales), 2) AS total_sales,
    ROUND(SUM(f.order_item_total), 2) AS total_order_item_value,
    ROUND(SUM(f.order_item_discount), 2) AS total_discounts,

    ROUND(SUM(f.order_profit_per_order), 2)
        AS dataset_reported_profit,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE os.delivery_status = 'Late delivery'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS late_delivery_share_all_items_pct,

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
    ) AS late_delivery_rate_excluding_canceled_pct,

    ROUND(
        AVG(f.days_for_shipping_real)::NUMERIC,
        2
    ) AS avg_actual_shipping_days,

    ROUND(
        AVG(f.days_for_shipment_scheduled)::NUMERIC,
        2
    ) AS avg_scheduled_shipping_days

FROM dw.fact_order_items f
JOIN dw.dim_order_status os
    ON os.order_status_key = f.order_status_key;
