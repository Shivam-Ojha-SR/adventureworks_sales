WITH dates AS (
    SELECT * FROM {{ ref('stg_date_data') }}
),
date_dim AS (
    SELECT 
        *
    FROM dates
)
SELECT * FROM date_dim