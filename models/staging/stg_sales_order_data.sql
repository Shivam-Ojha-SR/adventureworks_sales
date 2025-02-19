with
    sales_order_data as (
        select channel, salesorderlinekey, sales_order, sales_order_line
        from {{ source("sales", "sales_order_data") }}
    )
select *
from sales_order_data