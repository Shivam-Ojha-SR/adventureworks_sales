with
    sales_data as (select * from {{ ref("stg_sales_data") }}),

    daily_sales as (
        select orderdatekey, productkey, 
        round(sum(salesamount), 3) as daily_sales
        from sales_data
        group by orderdatekey, productkey
        order by daily_sales desc
    )
select *
from daily_sales