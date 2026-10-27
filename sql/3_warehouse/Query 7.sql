
SELECT 'dim_customer' AS table_name, COUNT(*) AS row_count
FROM dw.dim_customer

UNION ALL

SELECT 'dim_product', COUNT(*)
FROM dw.dim_product

UNION ALL

SELECT 'dim_geography', COUNT(*)
FROM dw.dim_geography

UNION ALL

SELECT 'dim_order_status', COUNT(*)
FROM dw.dim_order_status

UNION ALL

SELECT 'dim_date', COUNT(*)
FROM dw.dim_date

ORDER BY table_name;
