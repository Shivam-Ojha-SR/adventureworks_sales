WITH customer_data as(
    select * from {{ ref('int_customer_data') }}
),
    dim_customer AS (
        SELECT *
        FROM customer_data
    )
SELECT * FROM dim_customer
