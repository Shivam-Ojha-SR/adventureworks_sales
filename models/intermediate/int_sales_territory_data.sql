WITH sales_territory_data as(
    select * from {{ ref('stg_sales_territory_data') }}
),
int_sales_territory_data AS (
    SELECT DISTINCT
        salesterritorykey,
        region,
        country,
        group_name
    FROM sales_territory_data
)
SELECT * FROM int_sales_territory_data