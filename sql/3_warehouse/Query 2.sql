
-- 1. Customer dimension
CREATE TABLE IF NOT EXISTS dw.dim_customer (
    customer_key BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id BIGINT NOT NULL UNIQUE,
    customer_segment TEXT,
    customer_city TEXT,
    customer_state TEXT,
    customer_country TEXT,
    customer_zipcode NUMERIC
);

-- 2. Product dimension
CREATE TABLE IF NOT EXISTS dw.dim_product (
    product_key BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_card_id BIGINT NOT NULL UNIQUE,
    product_name TEXT,
    product_price NUMERIC(18, 2),
    category_id BIGINT,
    category_name TEXT,
    department_id BIGINT,
    department_name TEXT,
    product_image TEXT
);

-- 3. Order geography dimension
CREATE TABLE IF NOT EXISTS dw.dim_geography (
    geography_key BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_city TEXT,
    order_state TEXT,
    order_country TEXT,
    order_region TEXT,
    market TEXT,
    UNIQUE NULLS NOT DISTINCT (
        order_city,
        order_state,
        order_country,
        order_region,
        market
    )
);

-- 4. Order and shipping status dimension
CREATE TABLE IF NOT EXISTS dw.dim_order_status (
    order_status_key BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    shipping_mode TEXT,
    delivery_status TEXT,
    order_status TEXT,
    UNIQUE NULLS NOT DISTINCT (
        shipping_mode,
        delivery_status,
        order_status
    )
);

-- 5. Date dimension
CREATE TABLE IF NOT EXISTS dw.dim_date (
    date_key INTEGER PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    year INTEGER NOT NULL,
    quarter INTEGER NOT NULL,
    month INTEGER NOT NULL,
    month_name TEXT NOT NULL,
    day_of_month INTEGER NOT NULL,
    day_of_week INTEGER NOT NULL,
    day_name TEXT NOT NULL
);
