WITH
    date_source AS (
        SELECT * FROM {{ source("sales", "date_data") }}
    ),
    date_data AS (
        SELECT
            datekey,
            TO_DATE(date, 'DD-MM-YYYY') AS date,
            SUBSTR(fiscal_year, 3, 4)::INT AS fiscal_year,
            SUBSTR(fiscal_quarter, -1)::INT AS fiscal_quarter,
            CASE
                WHEN month LIKE '%Jul%' THEN 'July'
                WHEN month LIKE '%Aug%' THEN 'August'
                WHEN month LIKE '%Sep%' THEN 'September'
                WHEN month LIKE '%Oct%' THEN 'October'
                WHEN month LIKE '%Nov%' THEN 'November'
                WHEN month LIKE '%Dec%' THEN 'December'
                WHEN month LIKE '%Jan%' THEN 'January'
                WHEN month LIKE '%Feb%' THEN 'February'
                WHEN month LIKE '%Mar%' THEN 'March'
                WHEN month LIKE '%Apr%' THEN 'April'
                WHEN month LIKE '%May%' THEN 'May'
                WHEN month LIKE '%Jun%' THEN 'June'
                ELSE NULL
            END AS month,
            full_date,
            monthkey
        FROM date_source
    )
SELECT * FROM date_data
