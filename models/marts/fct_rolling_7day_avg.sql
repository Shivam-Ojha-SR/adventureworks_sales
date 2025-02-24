-- rolling_7day_avg
with
    daily_sales as (
        select local_date, product_category, sum(salesamount) as daily_sales_amount
        from {{ ref("dim_sales_local_time") }}
        -- Remove WHERE in_business_hours if not applicable
        where in_business_hours = true
        group by local_date, product_category
    ),
    rolling_avg as (
        select
            local_date,
            product_category,
            daily_sales_amount,
            avg(daily_sales_amount) over (
                partition by product_category
                order by local_date
                rows between 6 preceding and current row
            ) as rolling_7day_avg_sales
        from daily_sales
    )
select local_date, product_category, ROUND(rolling_7day_avg_sales, 3) as rolling_7day_avg
from rolling_avg
order by product_category, local_date
