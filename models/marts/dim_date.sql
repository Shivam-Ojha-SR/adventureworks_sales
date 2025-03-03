WITH dates as(
    select * from {{ ref('int_date_data') }}
),
dim_date AS (
    SELECT *
    FROM dates
)
SELECT * FROM dim_date
