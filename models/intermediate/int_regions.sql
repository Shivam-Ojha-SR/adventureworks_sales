WITH territories AS (
    SELECT * FROM {{ ref('stg_sales_territory_data') }}
)
SELECT 
    salesterritorykey AS region_id, 
    region AS region_name, 
    country,
    group_name
FROM territories