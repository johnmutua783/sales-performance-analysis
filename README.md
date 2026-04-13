# Sales Performance & Customer Revenue Analysis

## Objective

The goal of this project was to analyze sales transaction data to identify revenue trends, customer behavior, and product performance in order to support data-driven business decisions.

---

## Dataset

The dataset contains sales transaction records including:

* Product details (product line, product code)
* Customer information
* Order details
* Sales revenue
* Territory and region data
* Deal size classification

---

## Tools Used

* SQL 

---

## Project Structure

* `sales_cleaning.sql` - Data cleaning and preprocessing
* `sales_analysis.sql` - Exploratory data analysis and insights

---

## Data Cleaning Process

To ensure data quality and consistency, the following steps were performed:

* Created a working copy of the dataset to preserve original data
* Handled missing values in address-related fields
* Standardized phone numbers by removing non-numeric characters
* Converted order date into proper DATE format
* Identified potential duplicate records
* Removed unnecessary columns with excessive missing values (ADDRESSLINE2, STATE, POSTALCODE)

---

## Exploratory Data Analysis

The cleaned dataset was analyzed to answer key business questions:

* What are the total and average sales performance metrics?
* Which product lines generate the highest revenue?
* How do sales vary across quarters and months?
* Who are the top customers by revenue contribution?
* How do sales differ by territory and region?
* How does deal size impact revenue?

---

## Key Insights

* Certain **product lines generate significantly higher revenue**, indicating strong-performing product categories.

* Sales show clear **seasonal patterns across months and quarters**, suggesting demand fluctuations throughout the year.

* A small group of **top customers contributes a large portion of total revenue**, indicating a concentrated customer base.

* The **deal size distribution shows that medium and large deals generate most of the revenue**, highlighting the importance of high-value transactions.

* Regional performance varies significantly, with some territories outperforming others in total sales.

---

## Recommendations

* Focus marketing efforts on **high-performing product lines** to maximize revenue.

* Develop strategies to **retain and grow top customers**, as they contribute a large share of revenue.

* Optimize sales strategies based on **seasonal demand patterns**.

* Strengthen performance in underperforming territories to balance revenue distribution.

* Encourage higher-value deals through **upselling and bundling strategies**.

---

## Conclusion

This project demonstrates how sales transaction data can be transformed into actionable business insights. The analysis provides a clear understanding of revenue drivers, customer behavior, and product performance, supporting better strategic decision-making.
