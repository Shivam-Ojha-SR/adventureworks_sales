WITH product_sales AS (
    SELECT
        product_category,
        SUM(salesamount) AS total_sales_amount
    FROM {{ ref('dim_base_sales') }}
    WHERE salesamount IS NOT NULL
    GROUP BY product_category
)
SELECT
    product_category AS top_selling_product,
    total_sales_amount
FROM product_sales
ORDER BY total_sales_amount DESC