WITH customer_data as(
    select * from {{ ref('stg_customer_data') }}
),
int_customer_data AS (
    SELECT DISTINCT
        customerkey,
        customer_id,
        customer,
        city,
        state_province,
        country_region,
        postal_code
    FROM customer_data
)
SELECT * FROM int_customer_data