with date_data as (
    select
        datekey,
        to_date(date) as date,
        substr(fiscal_year, 3, 4)::int as fiscal_year,
        substr(fiscal_quarter, -1)::int as fiscal_quarter,
        case
            when month like '%Jul%' then 'July'
            when month like '%Aug%' then 'August'
            when month like '%Sep%' then 'September'
            when month like '%Oct%' then 'October'
            when month like '%Nov%' then 'November'
            when month like '%Dec%' then 'December'
            when month like '%Jan%' then 'January'
            when month like '%Feb%' then 'February'
            when month like '%Mar%' then 'March'
            when month like '%Apr%' then 'April'
            when month like '%May%' then 'May'
            when month like '%Jun%' then 'June'
            else null
        end as month,
        full_date,
        monthkey
    from {{ ref('stg_date_data') }}
)
select *
from date_data
