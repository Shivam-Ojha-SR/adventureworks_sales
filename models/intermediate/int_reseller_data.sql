with reseller_data as (
    select
        resellerkey,
        case
            when reseller_id = '[Not Applicable]' then null 
            else reseller_id
        end as reseller_id,
        case
            when business_type = '[Not Applicable]' then null 
            else business_type
        end as business_type,
        case
            when reseller = '[Not Applicable]' then null 
            else reseller
        end as reseller,
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
    from {{ ref('stg_reseller_data') }}
)
select *
from reseller_data