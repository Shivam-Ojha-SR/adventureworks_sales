WITH products AS (
    SELECT * FROM {{ ref('stg_product_data') }}
)
SELECT 
    productkey AS product_id, 
    sku,
    product AS product_name,
    category, 
    subcategory, 
    standardcost,
    listprice,
    color,
    model
FROM products