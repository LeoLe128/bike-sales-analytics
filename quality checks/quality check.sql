/*
=================================================================
Data quality checks 
=================================================================
Script Purpose:
	This script explores all the fields in the data set to check
	for data consistency, accuracy, and standardization, including:
		- Null and duplicates primary keys
		- Unwanted spaces in string fields
		- Data standardization and consistency in category fields
		- Invalid date ranges and orders
		- Data consistency among fields

	Usage notes:
		- Detect, investigate then document all issues found along with
		their resolution in the issue log.
		- Ensure transparency
		- Solvable data issues will be addressed when creating the view 
		in the cleaned_data_view script.
=================================================================
*/

--=================================================================
--ORDERS
--Check for null or duplicate primary keys (user_id & order_id)
--Expect: No result
SELECT 
	USER_ID,
	ORDER_ID
FROM dbo.orders
WHERE USER_ID IS NULL --NO NULL

SELECT 
	USER_ID,
	ORDER_ID,
	COUNT(*)
FROM dbo.orders
GROUP BY USER_ID, ORDER_ID
HAVING COUNT(*) > 1

--Check for Null and duplicate in order_id
--Expect: no result
SELECT 
	ORDER_ID,
	COUNT(*)
FROM dbo.orders
GROUP BY ORDER_ID
HAVING ORDER_ID IS NULL OR COUNT(*) != 1

--Check for business logic between user_id and order_id
--Expect: 1 orders can only be done by 1 user at a time
SELECT 
	ORDER_ID,
	COUNT(USER_ID) AS 'no. user'
FROM dbo.orders
GROUP BY ORDER_ID
HAVING COUNT(USER_ID) > 1

SELECT 
	ORDER_ID,
	COUNT(USER_ID) AS 'no. user'
FROM dbo.orders
GROUP BY ORDER_ID
HAVING COUNT(DISTINCT USER_ID) > 1

--Check for invalid date range
--Expect: no result
SELECT * FROM dbo.orders WHERE PURCHASE_TS > SHIP_TS

--check for null date value in date
--Expect: no result
SELECT
	PURCHASE_TS,
	SHIP_TS
FROM dbo.orders
WHERE PURCHASE_TS IS NULL OR SHIP_TS IS NULL 

--check for unwanted spaces
--Expect: no result
SELECT * FROM dbo.orders WHERE PRODUCT_NAME LIKE ' %'

--Consistency and standardization
--Expect: no result
SELECT PRODUCT_NAME, COUNT(DISTINCT PRODUCT_ID) 
FROM dbo.orders
GROUP BY PRODUCT_NAME
HAVING COUNT(DISTINCT PRODUCT_ID) != 1

SELECT DISTINCT PRODUCT_NAME, PRODUCT_ID --different ids of each product
FROM dbo.orders
ORDER BY PRODUCT_NAME

--USD_PRICE
--Check for negative, 0 or null values
SELECT
	*
FROM dbo.orders
WHERE USD_PRICE <= 0 
OR USD_PRICE IS NULL
ORDER BY PRODUCT_NAME

--MARKETING CHANNEL & ACCOUNT CREATING METHOD
SELECT DISTINCT PURCHASE_PLATFORM, MARKETING_CHANNEL, ACCOUNT_CREATION_METHOD 
FROM DBO.orders

SELECT 
	CASE WHEN MARKETING_CHANNEL IS NULL THEN 'unknown'
	ELSE MARKETING_CHANNEL
	END AS MARKETING_CHANNEL,
	CASE WHEN ACCOUNT_CREATION_METHOD IS NULL THEN 'unknown'
	ELSE ACCOUNT_CREATION_METHOD
	END AS ACCOUNT_CREATION_METHOD
FROM DBO.orders

--COUNTRY CODE
SELECT COUNT(*)
FROM dbo.orders
WHERE COUNTRY_CODE IS NULL

--Check for values in order table that's not in the region table
SELECT DISTINCT o.COUNTRY_CODE
FROM orders o
LEFT JOIN region r
	ON o.COUNTRY_CODE = r.COUNTRY_CODE
WHERE r.REGION IS NULL AND o.COUNTRY_CODE IS NOT NULL

SELECT DISTINCT COUNTRY_CODE, COUNT(ORDER_ID)
FROM orders
GROUP BY COUNTRY_CODE
HAVING COUNTRY_CODE LIKE 'A%'
ORDER BY COUNT(ORDER_ID) DESC

--REGION
--INCONSISTENCY AND MISSING VALUES
SELECT 
	DISTINCT REGION
FROM dbo.region

SELECT * 
FROM dbo.region
WHERE REGION = 'X.x' 

SELECT * 
FROM dbo.region
WHERE COUNTRY_CODE IS NULL OR REGION IS NULL
