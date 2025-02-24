WITH sales AS (
    SELECT
        sd.salesorderlinekey,
        sd.orderdatekey,
        TO_DATE(sd.orderdatekey, 'YYYYMMDD') AS order_date,
        sd.salesamount AS salesamount,
        sd.salesterritorykey,
        pd.category AS product_category
    FROM {{ ref('int_sales_data') }} sd
    LEFT JOIN {{ ref('int_product_data') }} pd
        ON sd.productkey = pd.productkey
)
SELECT
    s.*,
    st.region,
    st.country,
    st.group_name
FROM sales s
LEFT JOIN {{ ref('int_sales_territory_data') }} st
    ON s.salesterritorykey = st.salesterritorykey
WHERE s.salesamount IS NOT NULL
  AND s.order_date IS NOT NULL