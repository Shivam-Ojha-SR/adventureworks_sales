with
    sales as (select * from {{ ref("stg_sales_data") }}),

    sales_aggregates as (
        select
            productkey as product_id,
            salesterritorykey as region_id,
            orderdatekey as order_date,
            sum(orderquantity) as total_quantity,
            round(sum(salesamount), 3) as total_revenue
        from sales
        group by productkey, salesterritorykey, orderdatekey
    ),
    rolling_avg as (
        select
            sales_aggregates.*,
            round(
                avg(total_revenue) over (
                    partition by product_id
                    order by
                        to_date(cast(order_date as string), 'YYYYMMDD')
                        range between interval '6 days' preceding and current row
                ),
                3
            ) as rolling_7d_avg
        from sales_aggregates
    )
select *
from rolling_avg
