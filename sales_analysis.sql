-- SALES PERFORMANCE & CUSTOMER REVENUE ANALYSIS


-- 1. OVERALL BUSINESS PERFORMANCE
-- Summary of revenue, orders, customers and products

SELECT
    ROUND(SUM(SALES), 2) AS total_revenue,
    COUNT(DISTINCT ORDERNUMBER) AS total_orders,
    COUNT(DISTINCT CUSTOMERNAME) AS total_customers,
    COUNT(DISTINCT PRODUCTCODE) AS total_products,
    ROUND(
        SUM(SALES) / COUNT(DISTINCT ORDERNUMBER),
        2
    ) AS avg_order_value
FROM sales_clean;


-- 2. REVENUE BY PRODUCT LINE
-- Compare revenue and order performance by product line

SELECT
    PRODUCTLINE,
    ROUND(SUM(SALES), 2) AS total_revenue,
    COUNT(DISTINCT ORDERNUMBER) AS total_orders,
    ROUND(
        SUM(SALES) / COUNT(DISTINCT ORDERNUMBER),
        2
    ) AS avg_order_value
FROM sales_clean
GROUP BY PRODUCTLINE
ORDER BY total_revenue DESC;


-- 3. PRODUCT LINE REVENUE CONTRIBUTION
-- Calculate each product line's share of total revenue

SELECT
    PRODUCTLINE,
    ROUND(SUM(SALES), 2) AS revenue,
    ROUND(
        SUM(SALES) * 100 / (SELECT SUM(SALES) FROM sales_clean),
        2
    ) AS revenue_percentage
FROM sales_clean
GROUP BY PRODUCTLINE
ORDER BY revenue DESC;


-- 4. TOP 10 CUSTOMERS
-- Identify the customers generating the most revenue

SELECT
    CUSTOMERNAME,
    ROUND(SUM(SALES), 2) AS total_revenue,
    COUNT(DISTINCT ORDERNUMBER) AS total_orders,
    ROUND(
        SUM(SALES) / COUNT(DISTINCT ORDERNUMBER),
        2
    ) AS avg_order_value
FROM sales_clean
GROUP BY CUSTOMERNAME
ORDER BY total_revenue DESC
LIMIT 10;


-- 5. TOP 10 CUSTOMER REVENUE CONTRIBUTION
-- Measure how much revenue comes from the top 10 customers

WITH customer_revenue AS (
    SELECT
        CUSTOMERNAME,
        SUM(SALES) AS total_revenue
    FROM sales_clean
    GROUP BY CUSTOMERNAME
),
top_customers AS (
    SELECT total_revenue
    FROM customer_revenue
    ORDER BY total_revenue DESC
    LIMIT 10
)
SELECT
    ROUND(SUM(total_revenue), 2) AS top_10_revenue,
    ROUND(
        SUM(total_revenue) * 100 /
        (SELECT SUM(SALES) FROM sales_clean),
        2
    ) AS top_10_revenue_percentage
FROM top_customers;


-- 6. REVENUE BY COUNTRY
-- Compare revenue, orders and customers across countries

SELECT
    COUNTRY,
    ROUND(SUM(SALES), 2) AS total_revenue,
    COUNT(DISTINCT ORDERNUMBER) AS total_orders,
    COUNT(DISTINCT CUSTOMERNAME) AS total_customers
FROM sales_clean
GROUP BY COUNTRY
ORDER BY total_revenue DESC;


-- 7. REVENUE PER CUSTOMER BY COUNTRY
-- Identify high-value markets based on customer value

SELECT
    COUNTRY,
    ROUND(SUM(SALES), 2) AS total_revenue,
    COUNT(DISTINCT CUSTOMERNAME) AS total_customers,
    ROUND(
        SUM(SALES) / COUNT(DISTINCT CUSTOMERNAME),
        2
    ) AS revenue_per_customer
FROM sales_clean
GROUP BY COUNTRY
ORDER BY revenue_per_customer DESC;


-- 8. ANNUAL REVENUE TREND
-- Track revenue, orders and customers by year

SELECT
    YEAR(ORDERDATE) AS year,
    ROUND(SUM(SALES), 2) AS total_revenue,
    COUNT(DISTINCT ORDERNUMBER) AS total_orders,
    COUNT(DISTINCT CUSTOMERNAME) AS total_customers
FROM sales_clean
GROUP BY YEAR(ORDERDATE)
ORDER BY year;


-- 9. YEAR-OVER-YEAR REVENUE GROWTH
-- Calculate annual revenue growth

WITH yearly_sales AS (
    SELECT
        YEAR(ORDERDATE) AS year,
        SUM(SALES) AS total_revenue
    FROM sales_clean
    GROUP BY YEAR(ORDERDATE)
)
SELECT
    year,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(
        (
            total_revenue -
            LAG(total_revenue) OVER (ORDER BY year)
        ) * 100 /
        LAG(total_revenue) OVER (ORDER BY year),
        2
    ) AS revenue_growth_percentage
FROM yearly_sales
ORDER BY year;


-- 10. JANUARY-MAY REVENUE COMPARISON
-- Compare the same period across years

SELECT
    YEAR(ORDERDATE) AS year,
    ROUND(SUM(SALES), 2) AS jan_to_may_revenue,
    COUNT(DISTINCT ORDERNUMBER) AS total_orders
FROM sales_clean
WHERE MONTH(ORDERDATE) BETWEEN 1 AND 5
GROUP BY YEAR(ORDERDATE)
ORDER BY year;


-- 11. AVERAGE ORDER VALUE BY YEAR
-- Track order value during the comparable January-May period

SELECT
    YEAR(ORDERDATE) AS year,
    ROUND(SUM(SALES), 2) AS jan_to_may_revenue,
    COUNT(DISTINCT ORDERNUMBER) AS total_orders,
    ROUND(
        SUM(SALES) / COUNT(DISTINCT ORDERNUMBER),
        2
    ) AS revenue_per_order
FROM sales_clean
WHERE MONTH(ORDERDATE) BETWEEN 1 AND 5
GROUP BY YEAR(ORDERDATE)
ORDER BY year;


-- 12. REVENUE BY MONTH
-- Identify the strongest sales months

SELECT
    MONTH(ORDERDATE) AS month,
    MONTHNAME(ORDERDATE) AS month_name,
    ROUND(SUM(SALES), 2) AS total_revenue,
    COUNT(DISTINCT ORDERNUMBER) AS total_orders
FROM sales_clean
GROUP BY
    MONTH(ORDERDATE),
    MONTHNAME(ORDERDATE)
ORDER BY total_revenue DESC;


-- 13. NOVEMBER REVENUE CONTRIBUTION
-- Measure November's share of total revenue

SELECT
    ROUND(
        SUM(
            CASE
                WHEN MONTH(ORDERDATE) = 11 THEN SALES
                ELSE 0
            END
        ),
        2
    ) AS november_revenue,
    ROUND(
        SUM(
            CASE
                WHEN MONTH(ORDERDATE) = 11 THEN SALES
                ELSE 0
            END
        ) * 100 / SUM(SALES),
        2
    ) AS november_revenue_percentage
FROM sales_clean;


-- 14. PRODUCT LINE REVENUE BY YEAR
-- Track product line performance over time

SELECT
    YEAR(ORDERDATE) AS year,
    PRODUCTLINE,
    ROUND(SUM(SALES), 2) AS total_revenue
FROM sales_clean
GROUP BY
    YEAR(ORDERDATE),
    PRODUCTLINE
ORDER BY
    year,
    total_revenue DESC;


-- 15. PRODUCT LINE GROWTH
-- Compare product line revenue during January-May

SELECT
    YEAR(ORDERDATE) AS year,
    PRODUCTLINE,
    ROUND(SUM(SALES), 2) AS jan_to_may_revenue
FROM sales_clean
WHERE MONTH(ORDERDATE) BETWEEN 1 AND 5
GROUP BY
    YEAR(ORDERDATE),
    PRODUCTLINE
ORDER BY
    year,
    jan_to_may_revenue DESC;


-- 16. CUSTOMER PURCHASE HISTORY
-- Identify first and last purchase dates

SELECT
    CUSTOMERNAME,
    MIN(ORDERDATE) AS first_order_date,
    MAX(ORDERDATE) AS last_order_date,
    COUNT(DISTINCT ORDERNUMBER) AS total_orders,
    ROUND(SUM(SALES), 2) AS total_revenue
FROM sales_clean
GROUP BY CUSTOMERNAME
ORDER BY total_revenue DESC;

