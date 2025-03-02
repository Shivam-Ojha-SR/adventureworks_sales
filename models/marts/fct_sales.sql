WITH sales AS (
    SELECT * FROM {{ ref('int_sales_fct') }}
),
sales_fact AS (
    SELECT 
        *
    FROM sales
)
SELECT * FROM sales_fact