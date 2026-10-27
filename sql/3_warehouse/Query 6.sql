
WITH all_dates AS (
    SELECT DISTINCT
        NULLIF(TRIM("order date (DateOrders)"), '')::TIMESTAMP::DATE AS d
    FROM stg.dataco_cleaned_raw

    UNION

    SELECT DISTINCT
        NULLIF(TRIM("shipping date (DateOrders)"), '')::TIMESTAMP::DATE AS d
    FROM stg.dataco_cleaned_raw
),
valid_dates AS (
    SELECT d
    FROM all_dates
    WHERE d IS NOT NULL
)
INSERT INTO dw.dim_date (
    date_key,
    full_date,
    year,
    quarter,
    month,
    month_name,
    day_of_month,
    day_of_week,
    day_name
)
SELECT
    TO_CHAR(d, 'YYYYMMDD')::INTEGER,
    d,
    EXTRACT(YEAR FROM d)::INTEGER,
    EXTRACT(QUARTER FROM d)::INTEGER,
    EXTRACT(MONTH FROM d)::INTEGER,
    TO_CHAR(d, 'FMMonth'),
    EXTRACT(DAY FROM d)::INTEGER,
    EXTRACT(DOW FROM d)::INTEGER,
    TO_CHAR(d, 'FMDay')
FROM valid_dates
ON CONFLICT (date_key) DO NOTHING;
