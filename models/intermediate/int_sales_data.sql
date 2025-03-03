WITH sales as(
    select * from {{ ref('stg_sales_data') }}
),

sales_data AS (
    SELECT 
        *
    FROM sales
)
SELECT * FROM sales_data
