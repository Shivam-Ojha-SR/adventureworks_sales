WITH territories AS (
    SELECT * FROM {{ ref('int_regions') }}
),
territory_dim AS (
    SELECT 
        *
    FROM territories
)
SELECT * FROM territory_dim