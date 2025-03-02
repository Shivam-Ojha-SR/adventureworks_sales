WITH customers AS (
    SELECT * FROM {{ ref('stg_customer_data') }}
)
SELECT 
    customerkey AS customer_id, 
    customer, 
    city, 
    state_province, 
    country_region, 
    postal_code
FROM customers