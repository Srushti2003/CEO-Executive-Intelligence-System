
-- Check the number of imported rows
SELECT COUNT(*) AS total_rows
FROM stg.dataco_cleaned_raw;

-- Check the number of columns
SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_schema = 'stg'
  AND table_name = 'dataco_cleaned_raw';

-- Inspect sample records
SELECT *
FROM stg.dataco_cleaned_raw
LIMIT 10;

-- Validate the unique order-item identifier
SELECT
    COUNT(*) AS total_rows,
    COUNT("Order Item Id") AS non_null_item_ids,
    COUNT(DISTINCT "Order Item Id") AS unique_item_ids
FROM stg.dataco_cleaned_raw;
