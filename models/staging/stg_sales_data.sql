with
    sales_data as (
        select
            salesorderlinekey,
            resellerkey,
            customerkey,
            productkey,
            orderdatekey,
            duedatekey,
            shipdatekey,
            salesterritorykey,
            cast(replace(order_quantity, ',', '') as int) as orderquantity,
            cast(replace(replace(unit_price, '$', ''), ',', '') as float) as unitprice,
            cast(
                replace(replace(extended_amount, '$', ''), ',', '') as float
            ) as extendedamount,
            cast(replace(unit_price_discount_pct, '%', '') as float)
            / 100 as discountpercentage,
            cast(
                replace(replace(product_standard_cost, '$', ''), ',', '') as float
            ) as productstandardcost,
            cast(
                replace(replace(total_product_cost, '$', ''), ',', '') as float
            ) as totalproductcost,
            cast(
                replace(replace(sales_amount, '$', ''), ',', '') as float
            ) as salesamount
        from {{ source("sales", "sales_data") }}
    )
select *
from sales_data