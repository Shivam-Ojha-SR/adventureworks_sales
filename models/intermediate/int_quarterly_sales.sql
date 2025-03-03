with
    sales_data as (select * from {{ ref("stg_sales_data") }}),

    date_data as (select * from {{ ref("stg_date_data") }}),

    quarterly_sales as (
        select
            sales_data.orderdatekey,
            date_data.fiscal_quarter as quarter_name,
            date_data.fiscal_year,
            sales_data.productkey,
            round(sum(sales_data.salesamount), 3) as quarterly_sales
        from sales_data
        join date_data on sales_data.orderdatekey = date_data.datekey
        group by
            sales_data.orderdatekey,
            quarter_name,
            date_data.fiscal_year,
            sales_data.productkey
        order by quarterly_sales desc
    )
select *
from quarterly_sales
