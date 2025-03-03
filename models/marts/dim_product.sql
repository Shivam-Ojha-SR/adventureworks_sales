WITH product_data as(
    select * from {{ ref('int_product_data') }}
)
,
dim_product AS (
    SELECT *
    FROM product_data
)
SELECT * FROM dim_product
