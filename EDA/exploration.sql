/*
===================================================================
EDA
===================================================================
Purpose:
	This report consolidates key customer metrics and behaviors

Highlights:
	1. Gather essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age group.
	3. Aggregates customer-level metrics:
		- Total orders
		- Total sales
		- Total quantity purchased
		- Total products
		- Lifespan (in months)
	4. Calculate valuable KPIs:
		- Recency (months since last order)
		- Average order value
		- Average monthly spend
===================================================================
*/
/*-----------------------------------------------------------------
1. Sales and growth trends in the 2 recent years (2019 - 2020)
------------------------------------------------------------------*/
--Total sales and growth by month
WITH monthly_sales AS (
    SELECT 
       MONTH(PURCHASE_TS) AS MONTH,
	   YEAR(PURCHASE_TS) AS YEAR,
       SUM(USD_PRICE) AS total_sales
    FROM dbo.cleaned_order_data
    WHERE PURCHASE_TS IS NOT NULL AND YEAR(PURCHASE_TS) in ('2019', '2020')
    GROUP BY YEAR(PURCHASE_TS), MONTH(PURCHASE_TS)
),
sales_with_growth AS (
    SELECT 
		YEAR,
        MONTH,
        total_sales,
        LAG(total_sales) OVER (ORDER BY YEAR, MONTH) AS previous_month_sales,
        COALESCE (ROUND(
            CAST(total_sales - LAG(total_sales) OVER (ORDER BY YEAR, MONTH) AS FLOAT)
            / NULLIF(LAG(total_sales) OVER (ORDER BY YEAR, MONTH), 0) * 100, 2
        ), 0) AS growth_percentage
    FROM monthly_sales
)
SELECT * FROM sales_with_growth

--Sales growth by Year
WITH sales AS (
SELECT
	YEAR(PURCHASE_TS) AS year,
	SUM(USD_PRICE) AS total_sales
FROM cleaned_order_data
WHERE PURCHASE_TS IS NOT NULL AND YEAR(PURCHASE_TS) < 2021
GROUP BY YEAR(PURCHASE_TS)
)
SELECT 
	year,
	total_sales,
	LAG(total_sales) OVER (ORDER BY year) AS previous_sales,
    COALESCE (ROUND(
        CAST(total_sales - LAG(total_sales) OVER (ORDER BY year) AS FLOAT)
        / NULLIF(LAG(total_sales) OVER (ORDER BY year), 0) * 100, 2
    ), 0) AS growth_percentage
FROM sales

--Performance across regions
WITH region_monthly_sales AS (
    SELECT 
	   YEAR(o.PURCHASE_TS) AS YEAR,
	   r.REGION,
	   COUNT(distinct o.order_id) AS order_count,
	   ROUND(SUM(o.usd_price), 2) AS total_sales,
	   ROUND(AVG(o.usd_price), 2) AS aov
    FROM dbo.cleaned_order_data o
	JOIN dbo.cleaned_region_data r
		ON o.COUNTRY_CODE = r.COUNTRY_CODE
    WHERE o.PURCHASE_TS IS NOT NULL AND YEAR(o.PURCHASE_TS) in ('2019', '2020')
    GROUP BY r.REGION, YEAR(o.PURCHASE_TS)
),
region_growth_rate AS (
    SELECT 
		REGION,
		YEAR,
		order_count,
        LAG(order_count) OVER (PARTITION BY REGION ORDER BY YEAR) AS previous_orders,
        COALESCE (ROUND(
            CAST(order_count - LAG(order_count) OVER (PARTITION BY REGION ORDER BY YEAR) AS FLOAT)
            / NULLIF(LAG(order_count) OVER (PARTITION BY REGION ORDER BY YEAR), 0) * 100, 2
        ), 0) AS order_growth_rate,
        total_sales,
        LAG(total_sales) OVER (PARTITION BY REGION ORDER BY YEAR) AS previous_sales,
        COALESCE (ROUND(
            CAST(total_sales - LAG(total_sales) OVER (PARTITION BY REGION ORDER BY YEAR) AS FLOAT)
            / NULLIF(LAG(total_sales) OVER (PARTITION BY REGION ORDER BY YEAR), 0) * 100, 2
        ), 0) AS sale_growth_rate,
		aov,
        LAG(aov) OVER (PARTITION BY REGION ORDER BY YEAR) AS previous_aov,
        COALESCE (ROUND(
            CAST(aov - LAG(aov) OVER (PARTITION BY REGION ORDER BY YEAR) AS FLOAT)
            / NULLIF(LAG(aov) OVER (PARTITION BY REGION ORDER BY YEAR), 0) * 100, 2
        ), 0) AS aov_growth_rate
    FROM region_monthly_sales
)
SELECT * FROM region_growth_rate--Detect 5 records with unrecognizable country code (AP, EU)

--Regional propotion analysis
WITH regional_sales AS (
    SELECT
        r.REGION,
        SUM(o.USD_PRICE) AS total_sales,
		COUNT(o.ORDER_ID) AS total_orders
    FROM cleaned_order_data o
    JOIN cleaned_region_data r
        ON o.COUNTRY_CODE = r.COUNTRY_CODE
    GROUP BY r.REGION
)
SELECT
    REGION,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2) AS percentage_of_total_sales,
	total_orders,
	SUM(total_orders) OVER () AS overall_orders,
    ROUND((CAST(total_orders AS FLOAT) / SUM(total_orders) OVER ()) * 100, 2) AS percentage_of_total_orders,
	ROUND(total_sales / total_orders, 2) AS AOV
FROM regional_sales
ORDER BY total_sales DESC;


--Propotion analysis by country
WITH country_sales AS (
    SELECT
        COUNTRY_CODE,
        SUM(USD_PRICE) AS total_sales,
		COUNT(ORDER_ID) AS total_orders
    FROM cleaned_order_data
	WHERE YEAR(PURCHASE_TS) < 2021 AND USD_PRICE > 0 AND USD_PRICE IS NOT NULL
    GROUP BY COUNTRY_CODE
)
SELECT
    COUNTRY_CODE,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2) AS percentage_of_total_sales,
	total_orders,
	SUM(total_orders) OVER() AS overall_orders,
	ROUND((CAST(total_orders AS FLOAT) / SUM(total_orders) OVER ()) * 100, 2) AS percentage_of_total_orders,
	ROUND(total_sales/total_orders, 2) AS AOV
FROM country_sales
ORDER BY total_sales DESC;

--Performance by products
WITH monthly_product_sales AS (
    SELECT 
	   YEAR(PURCHASE_TS) AS YEAR,
	   PRODUCT_NAME,
	   COUNT(distinct order_id) AS order_count,
	   ROUND(SUM(usd_price), 2) AS total_sales
    FROM cleaned_order_data
    WHERE PURCHASE_TS IS NOT NULL AND YEAR(PURCHASE_TS) < 2021
    GROUP BY PRODUCT_NAME, YEAR(PURCHASE_TS)
),
product_growth_rate AS (
    SELECT 
		PRODUCT_NAME,
		YEAR,
		order_count,
        LAG(order_count) OVER (PARTITION BY PRODUCT_NAME ORDER BY YEAR) AS previous_orders,
        COALESCE (ROUND(
            CAST(order_count - LAG(order_count) OVER (PARTITION BY PRODUCT_NAME ORDER BY YEAR) AS FLOAT)
            / NULLIF(LAG(order_count) OVER (PARTITION BY PRODUCT_NAME ORDER BY YEAR), 0) * 100, 2
        ), 0) AS order_growth_rate,
        total_sales,
        LAG(total_sales) OVER (PARTITION BY PRODUCT_NAME ORDER BY YEAR) AS previous_sales,
        COALESCE (ROUND(
            CAST(total_sales - LAG(total_sales) OVER (PARTITION BY PRODUCT_NAME ORDER BY YEAR) AS FLOAT)
            / NULLIF(LAG(total_sales) OVER (PARTITION BY PRODUCT_NAME ORDER BY YEAR), 0) * 100, 2
        ), 0) AS sale_growth_rate
    FROM monthly_product_sales
)
SELECT * FROM product_growth_rate ORDER BY PRODUCT_NAME, YEAR

--Proportion analysis by product
WITH product_sales AS (
    SELECT 
        PRODUCT_NAME,
        SUM(USD_PRICE) AS total_sales,
		COUNT(ORDER_ID) AS total_orders
    FROM dbo.cleaned_order_data
	WHERE YEAR(PURCHASE_TS) < 2021 AND USD_PRICE > 0 AND USD_PRICE IS NOT NULL
    GROUP BY PRODUCT_NAME
)
SELECT	
	PRODUCT_NAME,
	total_sales,
	SUM(total_sales) OVER() AS overall_sales,
	ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2) AS percentage_of_total_sales,
	total_orders,
	SUM(total_orders) OVER() AS overall_orders,
	ROUND((CAST(total_orders AS FLOAT)/SUM(total_orders) OVER()) *100,2) AS percentage_of_total_orders
FROM product_sales
ORDER BY total_sales DESC

-- Propotional analysis by Marketing channels
WITH product_sales AS (
    SELECT 
        MARKETING_CHANNEL,
        SUM(USD_PRICE) AS total_sales,
		COUNT(ORDER_ID) AS total_orders
    FROM dbo.cleaned_order_data
	WHERE YEAR(PURCHASE_TS) < 2021 AND USD_PRICE > 0 AND USD_PRICE IS NOT NULL
    GROUP BY MARKETING_CHANNEL
)
SELECT	
	MARKETING_CHANNEL,
	total_sales,
	SUM(total_sales) OVER() AS overall_sales,
	ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2) AS percentage_of_total_sales,
	total_orders,
	SUM(total_orders) OVER() AS overall_orders,
	ROUND((CAST(total_orders AS FLOAT)/SUM(total_orders) OVER()) *100,2) AS percentage_of_total_orders,
	ROUND(total_sales/total_orders, 2) AS AOV
FROM product_sales
ORDER BY total_sales DESC

-- Propotional analysis by purchase platforms
WITH product_sales AS (
    SELECT 
        PURCHASE_PLATFORM,
        SUM(USD_PRICE) AS total_sales,
		COUNT(ORDER_ID) AS total_orders
    FROM dbo.cleaned_order_data
	WHERE YEAR(PURCHASE_TS) < 2021 AND USD_PRICE > 0 AND USD_PRICE IS NOT NULL
    GROUP BY PURCHASE_PLATFORM
)
SELECT	
	PURCHASE_PLATFORM,
	total_sales,
	SUM(total_sales) OVER() AS overall_sales,
	ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2) AS percentage_of_total_sales,
	total_orders,
	SUM(total_orders) OVER() AS overall_orders,
	ROUND((CAST(total_orders AS FLOAT)/SUM(total_orders) OVER()) *100,2) AS percentage_of_total_orders,
	ROUND(total_sales/total_orders, 2) AS AOV
FROM product_sales
ORDER BY total_sales DESC

-- orders created by more than 1 users
select 
	ORDER_ID,
	count(USER_ID)
from cleaned_order_data
group by ORDER_ID
having COUNT(USER_ID) > 1

--one-time vs unique customers

SELECT *
FROM cleaned_order_data
WHERE USER_ID IN (
    SELECT USER_ID
    FROM cleaned_order_data
    GROUP BY USER_ID
    HAVING COUNT(*) > 1
)
