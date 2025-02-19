with
    reseller_data as (
        select
            resellerkey,
            reseller_id,
            business_type,
            reseller,
            city,
            state_province,
            country_region,
            postal_code
        from {{ source("sales", "reseller_data") }}
    )
select *
from reseller_data
