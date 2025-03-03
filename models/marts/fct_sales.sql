WITH sales_data AS (
    SELECT * FROM {{ ref('int_sales_data') }}
),

daily_sales AS (
    SELECT * FROM {{ ref('int_daily_sales') }}
),

weekly_sales AS (
    SELECT * FROM {{ ref('int_weekly_sales') }}
),

monthly_sales AS (
    SELECT * FROM {{ ref('int_monthly_sales') }}
), 

quarterly_sales AS (
    SELECT * FROM {{ ref('int_quarterly_sales') }}
),

rolling_7_day_avg AS (
    SELECT * FROM {{ ref('int_rolling_7d_avg') }}
),

product_performance AS (
    SELECT * FROM {{ ref('int_product_performance') }}
),

fct_sales AS (
    SELECT
        sales_data.salesorderlinekey,
        sales_data.resellerkey,
        sales_data.customerkey,
        sales_data.productkey,
        sales_data.orderdatekey,
        sales_data.duedatekey,
        sales_data.shipdatekey,
        sales_data.salesterritorykey,
        sales_data.orderquantity,
        sales_data.unitprice,
        sales_data.extendedamount,
        sales_data.discountpercentage,
        sales_data.productstandardcost,
        sales_data.totalproductcost,
        sales_data.salesamount,
        daily_sales.daily_sales,
        weekly_sales.weekly_sales,
        monthly_sales.monthly_sales,
        quarterly_sales.quarterly_sales,
        rolling_7_day_avg.rolling_7_day_avg,
        product_performance.sales_rank
    FROM sales_data
    LEFT JOIN daily_sales 
        ON sales_data.productkey = daily_sales.productkey 
        AND sales_data.orderdatekey = daily_sales.orderdatekey
    LEFT JOIN weekly_sales 
        ON sales_data.productkey = weekly_sales.productkey 
        AND sales_data.orderdatekey = weekly_sales.orderdatekey
    LEFT JOIN monthly_sales 
        ON sales_data.productkey = monthly_sales.productkey 
        AND sales_data.orderdatekey = monthly_sales.orderdatekey
    LEFT JOIN quarterly_sales 
        ON sales_data.productkey = quarterly_sales.productkey 
        AND sales_data.orderdatekey = quarterly_sales.orderdatekey
    LEFT JOIN rolling_7_day_avg 
        ON sales_data.productkey = rolling_7_day_avg.productkey 
        AND sales_data.orderdatekey = rolling_7_day_avg.orderdatekey
    LEFT JOIN product_performance 
        ON sales_data.productkey = product_performance.productkey 
        AND sales_data.salesterritorykey = product_performance.salesterritorykey
)

SELECT * FROM fct_sales