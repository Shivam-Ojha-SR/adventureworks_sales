with
    sales_data as (select * from {{ ref("stg_sales_data") }}),

    rolling_7_day_avg as (
        select
            orderdatekey,
            productkey,
            round(
                avg(salesamount) over (
                    partition by productkey
                    order by orderdatekey
                    rows between 6 preceding and current row
                ),
                3
            ) as rolling_7_day_avg
        from sales_data
        order by rolling_7_day_avg desc
    )
select *
from rolling_7_day_avg
