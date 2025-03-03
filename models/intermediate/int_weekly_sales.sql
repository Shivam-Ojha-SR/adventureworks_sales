with
    sales_data as (select * from {{ ref("stg_sales_data") }}),
    weekly_sales as (
        select orderdatekey, productkey, 
        round(sum(salesamount), 3) as weekly_sales
        from sales_data
        group by orderdatekey, productkey
        order by weekly_sales desc
    )
select *
from weekly_sales
