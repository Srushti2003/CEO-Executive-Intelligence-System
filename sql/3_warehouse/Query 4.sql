
-- Load customer dimension
INSERT INTO dw.dim_customer (
    customer_id,
    customer_segment,
    customer_city,
    customer_state,
    customer_country,
    customer_zipcode
)
SELECT DISTINCT ON (s."Customer Id")
    s."Customer Id"::BIGINT,
    s."Customer Segment",
    s."Customer City",
    s."Customer State",
    s."Customer Country",
    NULLIF(TRIM(s."Customer Zipcode"), '')::NUMERIC
FROM stg.dataco_cleaned_raw s
WHERE NULLIF(TRIM(s."Customer Id"), '') IS NOT NULL
ORDER BY s."Customer Id"
ON CONFLICT (customer_id) DO NOTHING;


-- Load product dimension
INSERT INTO dw.dim_product (
    product_card_id,
    product_name,
    product_price,
    category_id,
    category_name,
    department_id,
    department_name,
    product_image
)
SELECT DISTINCT ON (s."Product Card Id")
    s."Product Card Id"::BIGINT,
    s."Product Name",
    NULLIF(TRIM(s."Product Price"), '')::NUMERIC(18, 2),
    s."Product Category Id"::BIGINT,
    s."Category Name",
    s."Department Id"::BIGINT,
    s."Department Name",
    s."Product Image"
FROM stg.dataco_cleaned_raw s
WHERE NULLIF(TRIM(s."Product Card Id"), '') IS NOT NULL
ORDER BY s."Product Card Id"
ON CONFLICT (product_card_id) DO NOTHING;
