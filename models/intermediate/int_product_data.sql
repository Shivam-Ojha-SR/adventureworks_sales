WITH product_data as(
    select * from {{ ref('stg_product_data') }}
),

int_product_data AS (
    SELECT DISTINCT
        productkey,
        sku,
        product,
        standardcost,
        color,
        listprice,
        model,
        subcategory,
        category
    FROM product_data
)
SELECT * FROM int_product_data