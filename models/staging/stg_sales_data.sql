select
    *
from {{ source("sales", "sales_data") }}