with sales_aggregates as(
    SELECT * FROM {{ ref('int_sales_aggregates') }}
),

product_performance AS (
    SELECT 
        product_id,
        region_id,
        ROUND(SUM(total_revenue), 3) AS total_revenue,
        SUM(total_quantity) AS total_quantity,
        RANK() OVER (PARTITION BY region_id ORDER BY SUM(total_revenue) DESC) AS sales_rank
    FROM sales_aggregates
    GROUP BY product_id, region_id
)
SELECT * FROM product_performance