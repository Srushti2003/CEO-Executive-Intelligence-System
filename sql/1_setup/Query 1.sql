SELECT
    current_database() AS database_name,
    current_user AS connected_user,
    version() AS postgresql_version;

CREATE SCHEMA IF NOT EXISTS stg;

SELECT schema_name
FROM information_schema.schemata
WHERE schema_name = 'stg';