
SELECT
    COUNT(*) AS staging_rows,

    COUNT(*) FILTER (
        WHERE p.product_key IS NULL
    ) AS unmatched_item_products,

    COUNT(*) FILTER (
        WHERE g.geography_key IS NULL
    ) AS unmatched_geographies,

    COUNT(*) FILTER (
        WHERE os.order_status_key IS NULL
    ) AS unmatched_statuses

FROM stg.dataco_cleaned_raw s

LEFT JOIN dw.dim_product p
    ON p.product_card_id = s."Order Item Cardprod Id"::BIGINT

LEFT JOIN dw.dim_geography g
    ON g.order_city = s."Order City"
   AND g.order_state = s."Order State"
   AND g.order_country = s."Order Country"
   AND g.order_region = s."Order Region"
   AND g.market = s."Market"

LEFT JOIN dw.dim_order_status os
    ON os.shipping_mode = s."Shipping Mode"
   AND os.delivery_status = s."Delivery Status"
   AND os.order_status = s."Order Status";
