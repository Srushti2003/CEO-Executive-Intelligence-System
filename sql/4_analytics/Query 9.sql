
CREATE OR REPLACE VIEW mart.vw_geography_performance AS
SELECT
    g.market,
    g.order_region,
    g.order_country,
    g.order_state,
    g.order_city,

    COUNT(DISTINCT f.order_id) AS total_orders,
    COUNT(*) AS total_order_items,

    ROUND(SUM(f.sales), 2) AS total_sales,
    ROUND(SUM(f.order_profit_per_order), 2)
        AS dataset_reported_profit,

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
JOIN dw.dim_geography g
    ON g.geography_key = f.geography_key
JOIN dw.dim_order_status os
    ON os.order_status_key = f.order_status_key

GROUP BY
    g.market,
    g.order_region,
    g.order_country,
    g.order_state,
    g.order_city;
