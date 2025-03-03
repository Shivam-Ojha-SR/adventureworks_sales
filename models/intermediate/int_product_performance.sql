with
    sales_data as (select * from {{ ref("stg_sales_data") }}),

    product_performance as (
        select
            sales_data.salesterritorykey,
            sales_data.productkey,
            round(sum(sales_data.salesamount), 3) as total_sales,
            rank() over (
                partition by sales_data.salesterritorykey
                order by sum(sales_data.salesamount) desc
            ) as sales_rank
        from sales_data
        group by sales_data.salesterritorykey, sales_data.productkey
    )
select *
from product_performance
