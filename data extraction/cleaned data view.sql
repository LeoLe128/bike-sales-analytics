/*
===============================================================================
This script creates two SQL view named 'cleaned_order_data' and 'cleaned_region_data'
===============================================================================
Script Purpose:
	This view is designed to extract a cleaned and refined subset of transactional 
	and regional information from the raw 'orders' and 'region' tables. It addresses 
	common data quality issues such as missing values, inconsistent formatting, 
	and irrelevant columns, making the data ready for reporting and analysis.
===============================================================================
*/
--Create view aka cleaned order data ready for analysis
IF OBJECT_ID('cleaned_order_data', 'V') IS NOT NULL
    DROP VIEW cleaned_order_data;
GO

CREATE VIEW cleaned_order_data AS 
WITH temp AS (
SELECT
	USER_ID,
	ROW_NUMBER() OVER (PARTITION BY ORDER_ID ORDER BY USER_ID) AS ROW_NUM,
	ORDER_ID,
	CAST(PURCHASE_TS AS DATE) AS PURCHASE_TS,
	CAST(SHIP_TS AS DATE) AS SHIP_TS,
	CASE 
		WHEN PRODUCT_NAME = '27inches 4k gaming monitor' 
		THEN '27in 4k gaming monitor '
		ELSE PRODUCT_NAME
	END AS PRODUCT_NAME,
	PRODUCT_ID,
	USD_PRICE,
	PURCHASE_PLATFORM,
	CASE WHEN MARKETING_CHANNEL IS NULL THEN 'unknown'
	ELSE MARKETING_CHANNEL
	END AS MARKETING_CHANNEL,
	CASE WHEN ACCOUNT_CREATION_METHOD IS NULL THEN 'unknown'
	ELSE ACCOUNT_CREATION_METHOD
	END AS ACCOUNT_CREATION_METHOD,
	COUNTRY_CODE
FROM dbo.orders)

SELECT 
	USER_ID,
	ORDER_ID,
	PURCHASE_TS,
	SHIP_TS,
	PRODUCT_NAME,
	PRODUCT_ID,
	USD_PRICE,
	PURCHASE_PLATFORM,
	MARKETING_CHANNEL,
	ACCOUNT_CREATION_METHOD,
	COUNTRY_CODE
FROM temp
WHERE ROW_NUM = 1
GO

--Create view for cleaned region data
IF OBJECT_ID('cleaned_region_data', 'V') IS NOT NULL
    DROP VIEW cleaned_region_data;
GO

CREATE VIEW cleaned_region_data AS 
SELECT 
	COUNTRY_CODE,
	CASE 
		WHEN COUNTRY_CODE = 'MH' OR COUNTRY_CODE = 'PG' THEN 'APAC'
		WHEN COUNTRY_CODE = 'IE' OR COUNTRY_CODE = 'LB' THEN 'EMEA'
		WHEN REGION = 'North America' THEN 'NA'
	ELSE REGION
	END AS REGION
FROM dbo.region
GO
