WITH products AS (
    SELECT * FROM {{ ref('int_products') }}
),
product_dim AS (
    SELECT 
        *
    FROM products
)
SELECT * FROM product_dim