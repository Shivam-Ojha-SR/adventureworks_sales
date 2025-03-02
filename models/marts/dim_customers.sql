WITH customers AS (
    SELECT * FROM {{ ref('int_customers') }}
),
customer_dim AS (
    SELECT 
        customer_id,
        customer,
        city,
        state_province,
        country_region,
        postal_code
    FROM customers
)
SELECT * FROM customer_dim