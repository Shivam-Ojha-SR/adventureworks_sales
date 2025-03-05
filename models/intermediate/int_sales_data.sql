WITH sales_data AS (
    SELECT * FROM {{ ref("stg_sales_data") }}
),

daily_sales AS (
    SELECT 
        orderdatekey, 
        productkey, 
        ROUND(SUM(salesamount), 3) AS daily_sales
    FROM sales_data
    GROUP BY orderdatekey, productkey
),

rolling_7_day_avg AS (
    SELECT
        orderdatekey,
        productkey,
        ROUND(
            AVG(salesamount) OVER (
                PARTITION BY productkey
                ORDER BY orderdatekey
                ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
            ), 
            3
        ) AS rolling_7_day_avg
    FROM sales_data
),

product_performance AS (
    SELECT
        salesterritorykey,
        productkey,
        ROUND(SUM(salesamount), 3) AS total_sales,
        RANK() OVER (
            PARTITION BY salesterritorykey
            ORDER BY SUM(salesamount) DESC
        ) AS sales_rank
    FROM sales_data
    GROUP BY salesterritorykey, productkey
),

final_sales_data AS (
    SELECT 
        s.*,
        d.daily_sales,
        r.rolling_7_day_avg,
        p.sales_rank
    FROM sales_data s
    LEFT JOIN daily_sales d 
        ON s.productkey = d.productkey 
        AND s.orderdatekey = d.orderdatekey
    LEFT JOIN rolling_7_day_avg r 
        ON s.productkey = r.productkey 
        AND s.orderdatekey = r.orderdatekey
    LEFT JOIN product_performance p 
        ON s.productkey = p.productkey 
        AND s.salesterritorykey = p.salesterritorykey
)

SELECT * FROM final_sales_data