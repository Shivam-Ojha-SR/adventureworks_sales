with
    customer_data as (
        select
            customerkey,
            customer_id,
            customer,
            city,
            state_province,
            country_region,
            postal_code
        from {{ source("sales", "customer_data") }}
    )
select *
from customer_data