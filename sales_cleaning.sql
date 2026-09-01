-- SALES PERFORMANCE & CUSTOMER REVENUE ANALYSIS
-- Data Cleaning & Validation

-- 1. Create clean table
-- Convert ORDERDATE to DATE

CREATE TABLE sales_clean AS
SELECT
    ORDERNUMBER,
    QUANTITYORDERED,
    PRICEEACH,
    ORDERLINENUMBER,
    SALES,
    
    STR_TO_DATE(ORDERDATE, '%m/%d/%Y %H:%i') AS ORDERDATE,
    
    STATUS,
    QTR_ID,
    MONTH_ID,
    YEAR_ID,
    PRODUCTLINE,
    MSRP,
    PRODUCTCODE,
    CUSTOMERNAME,
    PHONE,
    ADDRESSLINE1,
    STATE,
    POSTALCODE,
    CITY,
    COUNTRY,
    TERRITORY,
    CONTACTLASTNAME,
    CONTACTFIRSTNAME,
    DEALSIZE
FROM sales_raw;


-- 2. Check total number of records

SELECT COUNT(*) AS total_rows
FROM sales_clean;


-- 3. Check column names and data types

DESCRIBE sales_clean;




-- 4. Check the order date range

SELECT
    MIN(ORDERDATE) AS earliest_order,
    MAX(ORDERDATE) AS latest_order
FROM sales_clean;


-- 5. Validate sales figures

SELECT
    ROUND(SUM(SALES), 2) AS total_sales,
    ROUND(AVG(SALES), 2) AS average_sales,
    MIN(SALES) AS minimum_sales,
    MAX(SALES) AS maximum_sales
FROM sales_clean;


-- 6. Investigate missing geographic fields

SELECT
    COUNTRY,
    COUNT(*) AS total_records,
    SUM(CASE WHEN TRIM(STATE) = '' THEN 1 ELSE 0 END) AS missing_state,
    SUM(CASE WHEN TRIM(POSTALCODE) = '' THEN 1 ELSE 0 END) AS missing_postalcode
FROM sales_clean
GROUP BY COUNTRY
ORDER BY missing_state DESC;


-- 7. Review records with missing postal codes

SELECT
    ORDERNUMBER,
    CUSTOMERNAME,
    ADDRESSLINE1,
    CITY,
    STATE,
    POSTALCODE,
    COUNTRY,
    SALES
FROM sales_clean
WHERE POSTALCODE IS NULL
   OR TRIM(POSTALCODE) = ''
ORDER BY SALES DESC;


-- 8. Check for invalid numeric values

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN QUANTITYORDERED <= 0 THEN 1 ELSE 0 END) AS invalid_quantity,
    SUM(CASE WHEN PRICEEACH < 0 THEN 1 ELSE 0 END) AS negative_price,
    SUM(CASE WHEN SALES < 0 THEN 1 ELSE 0 END) AS negative_sales,
    SUM(CASE WHEN MSRP < 0 THEN 1 ELSE 0 END) AS negative_msrp
FROM sales_clean;


-- 9. Check for blank categorical values

SELECT
    SUM(CASE WHEN TRIM(STATUS) = '' THEN 1 ELSE 0 END) AS blank_status,
    SUM(CASE WHEN TRIM(PRODUCTLINE) = '' THEN 1 ELSE 0 END) AS blank_productline,
    SUM(CASE WHEN TRIM(CUSTOMERNAME) = '' THEN 1 ELSE 0 END) AS blank_customer,
    SUM(CASE WHEN TRIM(COUNTRY) = '' THEN 1 ELSE 0 END) AS blank_country,
    SUM(CASE WHEN TRIM(TERRITORY) = '' THEN 1 ELSE 0 END) AS blank_territory,
    SUM(CASE WHEN TRIM(DEALSIZE) = '' THEN 1 ELSE 0 END) AS blank_dealsize
FROM sales_clean;


-- 10. Check for exact duplicate records

SELECT
    ORDERNUMBER,
    QUANTITYORDERED,
    PRICEEACH,
    ORDERLINENUMBER,
    SALES,
    ORDERDATE,
    STATUS,
    QTR_ID,
    MONTH_ID,
    YEAR_ID,
    PRODUCTLINE,
    MSRP,
    PRODUCTCODE,
    CUSTOMERNAME,
    PHONE,
    ADDRESSLINE1,
    STATE,
    POSTALCODE,
    CITY,
    COUNTRY,
    TERRITORY,
    CONTACTLASTNAME,
    CONTACTFIRSTNAME,
    DEALSIZE,
    COUNT(*) AS duplicate_count
FROM sales_clean
GROUP BY
    ORDERNUMBER,
    QUANTITYORDERED,
    PRICEEACH,
    ORDERLINENUMBER,
    SALES,
    ORDERDATE,
    STATUS,
    QTR_ID,
    MONTH_ID,
    YEAR_ID,
    PRODUCTLINE,
    MSRP,
    PRODUCTCODE,
    CUSTOMERNAME,
    PHONE,
    ADDRESSLINE1,
    STATE,
    POSTALCODE,
    CITY,
    COUNTRY,
    TERRITORY,
    CONTACTLASTNAME,
    CONTACTFIRSTNAME,
    DEALSIZE
HAVING COUNT(*) > 1;


-- 11. Check for duplicate order lines
-- ORDERNUMBER can repeat because orders contain multiple lines

SELECT
    ORDERNUMBER,
    ORDERLINENUMBER,
    COUNT(*) AS duplicate_count
FROM sales_clean
GROUP BY
    ORDERNUMBER,
    ORDERLINENUMBER
HAVING COUNT(*) > 1;

