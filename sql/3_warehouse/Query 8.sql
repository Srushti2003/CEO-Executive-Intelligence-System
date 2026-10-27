
-- 1. Verify row count and order-item uniqueness
SELECT
    COUNT(*) AS staging_rows,
    COUNT("Order Item Id") AS non_null_item_ids,
    COUNT(DISTINCT "Order Item Id") AS unique_item_ids
FROM stg.dataco_cleaned_raw;


-- 2. Check whether every customer maps to the customer dimension
SELECT COUNT(*) AS unmatched_customers
FROM stg.dataco_cleaned_raw s
LEFT JOIN dw.dim_customer c
    ON c.customer_id = s."Customer Id"::BIGINT
WHERE c.customer_key IS NULL;


-- 3. Check whether every product maps to the product dimension
SELECT COUNT(*) AS unmatched_products
FROM stg.dataco_cleaned_raw s
LEFT JOIN dw.dim_product p
    ON p.product_card_id = s."Product Card Id"::BIGINT
WHERE p.product_key IS NULL;


-- 4. Check order and shipping dates against the date dimension
SELECT
    COUNT(*) FILTER (
        WHERE od.date_key IS NULL
    ) AS unmatched_order_dates,
    COUNT(*) FILTER (
        WHERE sd.date_key IS NULL
    ) AS unmatched_shipping_dates
FROM stg.dataco_cleaned_raw s
LEFT JOIN dw.dim_date od
    ON od.full_date =
       NULLIF(TRIM(s."order date (DateOrders)"), '')::TIMESTAMP::DATE
LEFT JOIN dw.dim_date sd
    ON sd.full_date =
       NULLIF(TRIM(s."shipping date (DateOrders)"), '')::TIMESTAMP::DATE;
