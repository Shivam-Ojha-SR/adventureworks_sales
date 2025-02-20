{{ config(materialized='view') }}

select
    datekey,
    date,
    fiscal_year,
    fiscal_quarter,
    month,
    full_date,
    monthkey
from {{ source("sales", "date_data") }}
