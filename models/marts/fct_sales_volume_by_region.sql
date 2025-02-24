WITH regional_product_sales AS (
    SELECT
        region,     
        country,   
        product_category,  
        ROUND(SUM(salesamount), 3) AS total_sales_volume  
    FROM {{ ref('dim_base_sales') }}
    WHERE salesamount IS NOT NULL
    GROUP BY region, country, product_category
)
SELECT
    region,
    country,
    product_category,
    total_sales_volume,
    RANK() OVER (
        PARTITION BY region, country
        ORDER BY total_sales_volume DESC
    ) AS product_rank
FROM regional_product_sales
ORDER BY region, product_rank, country