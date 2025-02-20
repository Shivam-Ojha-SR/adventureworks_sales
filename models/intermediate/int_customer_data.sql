
with customer_data as (
    select
        customerkey,
        case
            when customer_id = '[Not Applicable]' then null 
            else customer_id
        end as customer_id,
        case
            when customer = '[Not Applicable]' then null 
            else customer
        end as customer,
        case 
            when city = '[Not Applicable]' then null 
            else city 
        end as city,
        case
            when state_province = '[Not Applicable]' then null 
            else state_province
        end as state_province,
        case
            when country_region = '[Not Applicable]' then null 
            else country_region
        end as country_region,
        case
            when postal_code = '[Not Applicable]' then null 
            else postal_code
        end as postal_code
    from {{ ref('stg_customer_data') }}
)
select *
from customer_data