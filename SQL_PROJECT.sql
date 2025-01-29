/* CREATING A DATABASE */

CREATE DATABASE SQL_PROJECT_P1

/* CREATING A TABLE */

CREATE TABLE RETAIL_SALES
             (
               TRANSACTION_ID INT PRIMARY KEY,
			   SALE_DATE DATE,
			   SALE_TIME TIME,
			   CUSTOMER_ID INT,
			   GENDER VARCHAR(10),
			   AGE INT,
			   PRODUCT_CATEOGORY VARCHAR(35),
			   QUANTITY_SOLD INT,
			   PRICE_PER_UNIT FLOAT,
			   COGS FLOAT,
			   TOTAL_SALE_AMOUNT FLOAT
			   )
/* IMPORTING DATA AND DISPLAYING IT */

SELECT * FROM RETAIL_SALES

/* DISPLAY FIRST 10 ROWS */

LIMIT 10

/* TOTAL RECORDS IN THE DATASET */

SELECT COUNT (*) FROM RETAIL_SALES

/* DATA CLEANING */

/* DEALING WITH NULL VALUES-CHECK FOR ALL COLUMNS */

SELECT * FROM RETAIL_SALES
WHERE 
      TRANSACTION_ID IS NULL
	  OR
	  SALE_DATE IS NULL
	  OR
	  SALE_TIME IS NULL
	  OR
	  CUSTOMER_ID IS NULL
	  OR
	  GENDER IS NULL
	  OR
	  PRODUCT_CATEOGORY IS NULL
	  OR
	  AGE IS NULL
	  OR
	  QUANTITY_SOLD IS NULL
	  OR
	  PRICE_PER_UNIT IS NULL
	  OR
	  COGS IS NULL
	  OR
	  TOTAL_SALE_AMOUNT IS NULL

/* DELETING THE NULL VALES */

DELETE FROM RETAIL_SALES
WHERE
     TRANSACTION_ID IS NULL
	  OR
	  SALE_DATE IS NULL
	  OR
	  SALE_TIME IS NULL
	  OR
	  CUSTOMER_ID IS NULL
	  OR
	  GENDER IS NULL
	  OR
	  PRODUCT_CATEOGORY IS NULL
	  OR
	  AGE IS NULL
	  OR
	  QUANTITY_SOLD IS NULL
	  OR
	  PRICE_PER_UNIT IS NULL
	  OR
	  COGS IS NULL
	  OR
	  TOTAL_SALE_AMOUNT IS NULL

/* DATA EXPLORATION */

--HOW MANY SALES WE HAVE?

SELECT COUNT(*) AS TOTAL_SALE FROM RETAIL_SALES

--HOW MANY UNIQUE CUSTOMERS WE HAVE?

SELECT COUNT(DISTINCT CUSTOMER_ID) AS TOTAL_SALE FROM RETAIL_SALES

-- CATEOGORY

SELECT DISTINCT PRODUCT_CATEOGORY FROM RETAIL_SALES

/* DATA ANALYSIS AND BUSINESS KEY PROBLEMS AND ANSWERS */

--MY ANALYSIS AND FINDINGS

--1Q: SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON 2022-11-05

SELECT * FROM RETAIL_SALES
WHERE SALE_DATE='2022-11-05'

--2Q: SQL QUERY TO RETRIEVE ALL TRANSACTIONS WHERE THE CATEGORY IS CLOTHING AND THE QUANTITY SOLD IS MORE THAN 2 IN THE MONTH OF NOV-202

SELECT * FROM RETAIL_SALES
WHERE 
     PRODUCT_CATEOGORY ='Clothing'
     AND
	 TO_CHAR(SALE_DATE,'YYYY-MM')='2022-11'
	 AND 
	 QUANTITY_SOLD >2

--3Q: SQL QUERY TO CALCULATE THE TOTAL SALES FOR EACH CATEOGORY

SELECT 
      PRODUCT_CATEOGORY,
	  SUM(TOTAL_SALE_AMOUNT) AS TOTAL_SALE,
	  COUNT(*) AS TOTAL_ORDERS
	  FROM RETAIL_SALES
GROUP BY 1

--4Q: SQ; QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE 'BEAUTY'CATEOGORY

SELECT 
     ROUND(AVG(AGE),2) AS AVERAGE 
	 FROM RETAIL_SALES
WHERE PRODUCT_CATEOGORY='Beauty'

--5Q: SQL QUERY TO FIND ALL THE TRANSACTIONS WHERE THE TOTAL SALE IS GREATER THAN 1000

SELECT *FROM RETAIL_SALES
WHERE TOTAL_SALE_AMOUNT > 1000

--6Q SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTIONS(TRASACTION_ID) MADE BY EACH GENDER IN EACH CATEOGORY

SELECT 
     PRODUCT_CATEOGORY,
	 GENDER,
	 COUNT(*) AS TOTAL_TRANSACTIONS
FROM RETAIL_SALES
GROUP BY
     PRODUCT_CATEOGORY,
	 GENDER
ORDER BY 1

--7Q: SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH.FIND OUT OF THE BEST SELLING MONTH IN EACH YEAR

SELECT YEAR,MONTH,AVG_SALES FROM
(
	SELECT 
     	EXTRACT(YEAR FROM SALE_DATE) AS YEAR,
	 	EXTRACT(MONTH FROM SALE_DATE) AS MONTH,
	 	AVG(TOTAL_SALE_AMOUNT) AS AVG_SALES,
	 	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM SALE_DATE) ORDER BY AVG(TOTAL_SALE_AMOUNT) DESC) AS RANK
	 	FROM RETAIL_SALES
	GROUP BY 1,2
) 
AS T1
WHERE RANK=1


--8Q: SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES
SELECT 
      CUSTOMER_ID,
	  SUM(TOTAL_SALE_AMOUNT) AS TOTAL_SALES
	  FROM RETAIL_SALES
	  
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--9Q: SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PIURCHASED ITEMS FROM EACH CATEOGORY

SELECT 
      PRODUCT_CATEOGORY,
      COUNT(DISTINCT CUSTOMER_ID) AS UNIQUE_CUSTOMERS
	  FROM RETAIL_SALES
	  
GROUP BY PRODUCT_CATEOGORY 

--10Q WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS (EXAMPLE MORNING<=12,AFTERNOON BETWEEN 12 & 17,EVENING >17)

WITH HOURLY_SALES AS
(
SELECT *,
       CASE 
	   WHEN EXTRACT(HOUR FROM SALE_TIME)<12 THEN 'MORNING'
	   WHEN EXTRACT(HOUR FROM SALE_TIME) BETWEEN 12 AND 17 THEN 'AFTERNOON'
	   ELSE 'EVENING'
	END AS SHIFT
FROM RETAIL_SALES
)
SELECT  
      SHIFT,
	  COUNT(*) AS TOTAL_ORDERS
      FROM HOURLY_SALES
GROUP BY SHIFT

--END OF PROJECT




     
	  
	  
	  




			   
