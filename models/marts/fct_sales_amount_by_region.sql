WITH regional_sales AS (
    SELECT
        region,     
        country,
        salesamount AS sales_amount
    FROM {{ ref('dim_base_sales') }}
    WHERE salesamount IS NOT NULL
)
SELECT
    region,
    country,
    ROUND(SUM(sales_amount), 3) AS total_sales_amount
FROM regional_sales
GROUP BY region, country
ORDER BY total_sales_amount DESC