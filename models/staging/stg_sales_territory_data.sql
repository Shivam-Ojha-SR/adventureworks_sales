with
    sales_territory_data as (
        select salesterritorykey, region, country, group_name
        from {{ source("sales", "sales_territory_data") }}
    )
select *
from sales_territory_data
