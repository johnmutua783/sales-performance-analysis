-- Summary statistics: total rows and sales metrics
SELECT COUNT(*) AS total_records,
       AVG(SALES) AS average_sales,
       MIN(SALES) AS min_sales,
       MAX(SALES) AS max_sales
FROM sales_data;

-- Total and average sales by product line
SELECT PRODUCTLINE,
       ROUND(SUM(SALES), 2) AS total_sales,
       ROUND(AVG(SALES), 2) AS average_sales,
       COUNT(DISTINCT ORDERNUMBER) AS total_orders
FROM sales_data
GROUP BY PRODUCTLINE
ORDER BY total_sales DESC;

-- Total sales per quarter per year
SELECT YEAR_ID, QTR_ID,
       ROUND(SUM(SALES), 2) AS total_sales
FROM sales_data
GROUP BY YEAR_ID, QTR_ID
ORDER BY YEAR_ID, QTR_ID;

-- Top 10 customers by total sales
SELECT CUSTOMERNAME,
       ROUND(SUM(SALES), 2) AS total_sales
FROM sales_data
GROUP BY CUSTOMERNAME
ORDER BY total_sales DESC
LIMIT 10;

-- Total sales per month (seasonality insight)
SELECT MONTH_ID,
       ROUND(SUM(SALES), 2) AS total_sales
FROM sales_data
GROUP BY MONTH_ID
ORDER BY MONTH_ID;

-- Total sales by territory (regional analysis)
SELECT TERRITORY,
       ROUND(SUM(SALES), 2) AS total_sales
FROM sales_data
GROUP BY TERRITORY
ORDER BY total_sales DESC;

-- Deal size vs. sales: to analyze sales distribution across deal tiers
SELECT DEALSIZE,
       ROUND(SUM(SALES), 2) AS total_sales,
       ROUND(AVG(SALES), 2) AS average_sales
FROM sales_data
GROUP BY DEALSIZE
ORDER BY total_sales DESC;
