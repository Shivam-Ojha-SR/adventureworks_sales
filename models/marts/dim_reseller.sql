WITH reseller_data as(
    select * from {{ ref('int_reseller_data') }}
),

dim_reseller AS (
    SELECT *
    FROM reseller_data
)
SELECT * FROM dim_reseller
