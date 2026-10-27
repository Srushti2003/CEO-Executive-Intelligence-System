
CREATE SCHEMA IF NOT EXISTS dw;
CREATE SCHEMA IF NOT EXISTS mart;

-- Verify the schemas
SELECT schema_name
FROM information_schema.schemata
WHERE schema_name IN ('stg', 'dw', 'mart')
ORDER BY schema_name;
