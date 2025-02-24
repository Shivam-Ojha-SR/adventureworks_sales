WITH daily_sales AS (
    SELECT
        local_date,
        product_category,
        SUM(salesamount) AS daily_sales
    FROM {{ ref('dim_sales_local_time') }}
    WHERE in_business_hours = TRUE
    GROUP BY local_date, product_category
)
SELECT
    local_date AS daily_date,
    product_category,
    ROUND(daily_sales, 3) AS daily_sales,
    EXTRACT(WEEK FROM local_date) AS week_number,
    EXTRACT(YEAR FROM local_date) AS year,
    ROUND(SUM(daily_sales) OVER (
        PARTITION BY product_category, EXTRACT(WEEK FROM local_date), EXTRACT(YEAR FROM local_date)
        ORDER BY local_date
    ), 3) AS weekly_sales,
    DATE_TRUNC('MONTH', local_date) AS month_start,
    ROUND(SUM(daily_sales) OVER (
        PARTITION BY product_category, DATE_TRUNC('MONTH', local_date)
        ORDER BY local_date
    ), 3) AS monthly_sales,
    DATE_TRUNC('QUARTER', local_date) AS quarter_start,
    ROUND(SUM(daily_sales) OVER (
        PARTITION BY product_category, DATE_TRUNC('QUARTER', local_date)
        ORDER BY local_date
    ), 3) AS quarterly_sales
FROM daily_sales
ORDER BY product_category, local_date