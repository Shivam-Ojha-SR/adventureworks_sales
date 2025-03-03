WITH sales_territory as(
    select * from {{ ref('int_sales_territory_data') }}
),

dim_sales_territory AS (
    SELECT *
    FROM sales_territory
)
SELECT * FROM dim_sales_territory
