with product_data as (
    select
        productkey,
        sku,
        product,
        cast(
            replace(replace(standard_cost, '$', ''), ',', '') as float
        ) as standardcost,
        color,
        cast(
            replace(replace(list_price, '$', ''), ',', '') as float
        ) as listprice,
        model,
        subcategory,
        category
    from {{ source("sales", "product_data") }}
)
select *
from product_data
