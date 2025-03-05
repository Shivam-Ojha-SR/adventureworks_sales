WITH sales_data AS (
    SELECT * FROM {{ ref('int_sales_data') }}
),

date AS (
    SELECT datekey FROM {{ ref('int_date_data') }}
),

customer AS (
    SELECT customerkey FROM {{ ref('int_customer_data') }}
),

product AS (
    SELECT productkey FROM {{ ref('int_product_data') }}
),

reseller AS (
    SELECT resellerkey FROM {{ ref('int_reseller_data') }}
),

sales_territory AS (
    SELECT salesterritorykey FROM {{ ref('int_sales_territory_data') }}
),

fct_sales AS (
    SELECT
        sales_data.salesorderlinekey,
        
        -- FK for dims
        sales_data.orderdatekey,
        sales_data.duedatekey,
        sales_data.shipdatekey,
        sales_data.customerkey,
        sales_data.productkey,
        sales_data.resellerkey,
        sales_data.salesterritorykey,

        -- quantitative stuff
        sales_data.orderquantity,
        sales_data.unitprice,
        sales_data.extendedamount,
        sales_data.discountpercentage,
        sales_data.productstandardcost,
        sales_data.totalproductcost,
        sales_data.salesamount,
        sales_data.daily_sales,
        sales_data.rolling_7_day_avg,
        sales_data.sales_rank
    FROM sales_data

    LEFT JOIN date ON sales_data.orderdatekey = date.datekey
    LEFT JOIN customer ON sales_data.customerkey = customer.customerkey
    LEFT JOIN product ON sales_data.productkey = product.productkey
    LEFT JOIN reseller ON sales_data.resellerkey = reseller.resellerkey
    LEFT JOIN sales_territory ON sales_data.salesterritorykey = sales_territory.salesterritorykey
)

SELECT * FROM fct_sales