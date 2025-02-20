with product_data as (
    select
        productkey,
        sku,
        product,
        cast(
            replace(replace(standardcost, '$', ''), ',', '') as float
        ) as standardcost,
        color,
        cast(
            replace(replace(listprice, '$', ''), ',', '') as float
        ) as listprice,
        model,
        subcategory,
        category
    from {{ ref('stg_product_data') }}
)
select *
from product_data