with
    sales_data as (select * from {{ ref("stg_sales_data") }}),
    date_data as (select * from {{ ref("stg_date_data") }}),
    monthly_sales as (
        SELECT
        sales_data.orderdatekey,
        date_data.month AS month_name,
        date_data.fiscal_year,
        sales_data.productkey,
        ROUND(SUM(sales_data.salesamount), 3) AS monthly_sales
    FROM sales_data
    JOIN date_data ON sales_data.orderdatekey = date_data.datekey
    GROUP BY sales_data.orderdatekey, month_name, date_data.fiscal_year, sales_data.productkey
    )
select *
from monthly_sales
