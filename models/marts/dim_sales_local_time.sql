-- models/analytics/sales_with_local_time.sql
with
    time_zone_mapping as (
        -- Mapping for U.S. regions
        select 'United States' as country, 'Northwest' as region, -8 as tz_offset
        union all
        select 'United States', 'Northeast', -5
        union all
        select 'United States', 'Central', -6
        union all
        select 'United States', 'Southwest', -7
        union all
        select 'United States', 'Southeast', -5
        union all
        -- Mapping for other countries
        select 'United Kingdom', null, 0
        union all
        select 'Australia', null, 10
        union all
        select 'Canada', null, -5
        union all
        select 'Germany', null, 1
        union all
        select 'France', null, 1
        union all
        select 'Japan', null, 9
        union all
        select 'Brazil', null, -3
    ),
    sales_with_tz as (
        select
            bs.*,
            case
                when tz.tz_offset is not null
                then dateadd(hour, tz.tz_offset, bs.order_date)
                else bs.order_date  -- Default to UTC if no match
            end as local_date
        from {{ ref("dim_base_sales") }} bs
        left join
            time_zone_mapping tz
            on bs.country = tz.country
            and (tz.region is null or bs.region = tz.region)
    )
select
    *,
    -- Placeholder for business hours (9 AM - 5 PM); refine if time data exists
    true as in_business_hours
from sales_with_tz
