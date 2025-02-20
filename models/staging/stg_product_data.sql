select
    productkey,
    sku,
    product,
    standard_cost,
    color,
    list_price,     
    model,
    subcategory,
    category
from {{ source("sales", "product_data") }}