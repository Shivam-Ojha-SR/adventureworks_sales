WITH seasonal_sales AS (
    SELECT
        EXTRACT(YEAR FROM order_date) AS year,
        EXTRACT(QUARTER FROM order_date) AS quarter, 
        product_category,  
        region,       
        ROUND(AVG(salesamount), 3) AS avg_quarterly_sales 
    FROM {{ ref('dim_base_sales') }}
    WHERE salesamount IS NOT NULL
        AND order_date IS NOT NULL
    GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(QUARTER FROM order_date), product_category, region
)
SELECT
    quarter,
    ROUND(AVG(avg_quarterly_sales) OVER (
        PARTITION BY quarter
        ORDER BY year
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ), 3) AS avg_seasonal_sales,
    product_category,
    region,
    year,
    avg_quarterly_sales
FROM seasonal_sales
ORDER BY year, product_category, region, quarter