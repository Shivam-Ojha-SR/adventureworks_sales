WITH date_data as(
    select * from {{ ref('stg_date_data') }}
),

dates AS (
    SELECT
        DISTINCT
        datekey,
        date,
        fiscal_year,
        fiscal_quarter,
        month,
        full_date,
        monthkey
    FROM date_data
)
SELECT * FROM dates