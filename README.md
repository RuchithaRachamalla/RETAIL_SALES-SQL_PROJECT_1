# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `SQL_PROJECT_P1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a database**: Create and populate a database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `SQL-PROJECT_P1`.
- **Table Creation**: A table named `RETAIL_SALES` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
/* IMPORTING DATA AND DISPLAYING IT */

SELECT * FROM RETAIL_SALES

/* DISPLAY FIRST 10 ROWS */

LIMIT 10

/* TOTAL RECORDS IN THE DATASET */

SELECT COUNT(*) FROM RETAIL_SALES
SELECT COUNT(DISTINCT TRANSACTION_ID) FROM RETAIL_SALES
SELECT DISTINCT PRODUCT_CATEOGORY FROM RETAIL_SALES

/* DATA CLEANING */

/* DEALING WITH NULL VALUES-CHECK NULL VALES IN ALL COLUMNS */

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
```

### 3.Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **SQL query to retrieve all columns for sales made on '2022-11-05'**:

```sql
SELECT * FROM RETAIL_SALES
WHERE SALE_DATE='2022-11-05'
```
2. **SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022**:

```sql
SELECT * FROM RETAIL_SALES
WHERE 
     PRODUCT_CATEOGORY ='Clothing'
     AND
	 TO_CHAR(SALE_DATE,'YYYY-MM')='2022-11'
	 AND 
	 QUANTITY_SOLD >2
```
3. **SQL query to calculate the total sales (total_sale) for each category.**:

```sql
SELECT 
      PRODUCT_CATEOGORY,
	  SUM(TOTAL_SALE_AMOUNT) AS TOTAL_SALE,
	  COUNT(*) AS TOTAL_ORDERS
	  FROM RETAIL_SALES
GROUP BY 1
```
4. **SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:

```sql
SELECT 
     ROUND(AVG(AGE),2) AS AVERAGE 
	 FROM RETAIL_SALES
WHERE PRODUCT_CATEOGORY='Beauty'

```
5. **SQL query to find all transactions where the total_sale is greater than 1000.**:

```sql
SELECT *FROM RETAIL_SALES
WHERE TOTAL_SALE_AMOUNT > 1000
```
6. **SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:

```sql
SELECT 
     PRODUCT_CATEOGORY,
	 GENDER,
	 COUNT(*) AS TOTAL_TRANSACTIONS
FROM RETAIL_SALES
GROUP BY
     PRODUCT_CATEOGORY,
	 GENDER
ORDER BY 1

```
7. **SQL query to calculate the average sale for each month. Find out best selling month in each year**:

```sql
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
```
8. **Write a SQL query to find the top 5 customers based on the highest total sales**:

```sql
SELECT 
      CUSTOMER_ID,
	  SUM(TOTAL_SALE_AMOUNT) AS TOTAL_SALES
	  FROM RETAIL_SALES
	  
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

```
9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:

```sql
SELECT 
      PRODUCT_CATEOGORY,
      COUNT(DISTINCT CUSTOMER_ID) AS UNIQUE_CUSTOMERS
	  FROM RETAIL_SALES
GROUP BY PRODUCT_CATEOGORY
```
10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

```sql
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

```
## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Electronics,Clothing and Beauty .
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## Author - Ruchitha Rachamalla

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### END OF THE PROJECT 


