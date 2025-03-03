WITH reseller_data as(
    select * from {{ ref('stg_reseller_data') }}
),

int_reseller_data AS (
    SELECT DISTINCT
        resellerkey,
        reseller_id,
        business_type,
        reseller,
        city,
        state_province,
        country_region,
        postal_code
        from
    reseller_data
)
SELECT * FROM int_reseller_data