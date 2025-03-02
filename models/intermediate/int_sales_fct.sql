WITH sales_source AS (
    SELECT * FROM {{ ref('stg_sales_data') }} AS sales
),
dates_source AS (
    SELECT 
        datekey,
        date,
        fiscal_year AS year,
        month,
        WEEK(date) AS week, 
        DAY(date) AS day 
    FROM {{ ref('dim_dates') }} AS dates
),
performance_source AS (
    SELECT * FROM {{ ref('int_product_performance') }} AS product_performance
),
sales_facts AS (
    SELECT 
        sales.salesorderlinekey AS order_id, 
        sales.productkey AS product_id, 
        sales.customerkey AS customer_id, 
        sales.salesterritorykey AS region_id, 
        sales.orderdatekey AS order_date, 
        sales.orderquantity AS quantity, 
        sales.salesamount AS revenue,
        dates.year,
        dates.month,
        dates.week,
        dates.day,
        product_performance.total_revenue,
        product_performance.sales_rank
    FROM sales_source AS sales
    JOIN dates_source AS dates ON sales.orderdatekey = dates.datekey
    JOIN performance_source AS product_performance 
        ON sales.productkey = product_performance.product_id 
        AND sales.salesterritorykey = product_performance.region_id
)
SELECT * FROM sales_facts