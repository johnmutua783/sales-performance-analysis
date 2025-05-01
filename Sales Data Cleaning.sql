-- STEP 1: Create a working copy of the dataset to preserve the original
CREATE TABLE sales_data LIKE sales_data_sample;

-- Populate the working table with the original data
INSERT INTO sales_data
SELECT * FROM sales_data_sample;

-- STEP 2: Preview first few records to understand structure
SELECT * FROM sales_data LIMIT 10;

-- STEP 3: View column names and data types
DESCRIBE sales_data;

-- STEP 4: Check for missing values in key address-related columns
SELECT
  SUM(CASE WHEN ADDRESSLINE2 IS NULL OR ADDRESSLINE2 = '' THEN 1 ELSE 0 END) AS missing_addressline2,
  SUM(CASE WHEN STATE IS NULL OR STATE = '' THEN 1 ELSE 0 END) AS missing_state,
  SUM(CASE WHEN POSTALCODE IS NULL OR POSTALCODE = '' THEN 1 ELSE 0 END) AS missing_postalcode
FROM sales_data;

-- Optional: View exact rows with missing data in specific columns
SELECT * FROM sales_data WHERE POSTALCODE IS NULL OR POSTALCODE = '';
SELECT * FROM sales_data WHERE (STATE IS NULL OR STATE = '') AND (CITY IS NULL OR CITY = '');

-- STEP 5: Standardize phone numbers by removing all non-numeric characters
UPDATE sales_data
SET phone = REGEXP_REPLACE(phone, '[^0-9]', '');

-- Check distribution of phone number lengths (helps decide on formatting)
SELECT LENGTH(phone) AS length, COUNT(*) AS count
FROM sales_data
GROUP BY LENGTH(phone)
ORDER BY count DESC;

-- STEP 6: Standardize the date format (e.g. convert to DATE type if in text)
UPDATE sales_data 
SET ORDERDATE = DATE(STR_TO_DATE(ORDERDATE, '%m/%d/%Y %H:%i')) 
WHERE ORDERDATE IS NOT NULL;

-- Confirm conversion worked
SELECT DISTINCT ORDERDATE FROM sales_data LIMIT 10;

-- STEP 7: Detect duplicates based on ORDERNUMBER and PRODUCTCODE
SELECT ORDERNUMBER, PRODUCTCODE, COUNT(*) AS times
FROM sales_data
GROUP BY ORDERNUMBER, PRODUCTCODE
HAVING COUNT(*) > 1;

-- STEP 8: Drop address-related columns with too many missing values
ALTER TABLE sales_data DROP COLUMN ADDRESSLINE2;
ALTER TABLE sales_data DROP COLUMN STATE;
ALTER TABLE sales_data DROP COLUMN POSTALCODE;
