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

- The **Classic Cars product line generated the highest revenue**, significantly outperforming other categories, making it the primary driver of overall sales.

- Sales peaked during **Q4 (October–December)**, indicating strong seasonal demand likely driven by end-of-year purchasing behavior.

- A small number of **high-value customers contributed a disproportionate share of total revenue**, highlighting customer concentration risk.

- The **EMEA region recorded the highest total sales**, while some regions lagged behind, indicating uneven market performance.

- **Medium and Large deal sizes accounted for the majority of revenue**, while small deals contributed minimally to overall sales performance.

- Monthly sales trends show **consistent growth toward the end of each year**, reinforcing the presence of seasonal purchasing patterns.

---

## Recommendations

- Increase investment in **high-performing product lines such as Classic Cars** through targeted marketing and inventory expansion.

- Leverage **Q4 seasonal demand** by launching promotions, discounts, and campaigns earlier in the year to maximize revenue.

- Reduce dependency on a few key customers by **diversifying the customer base** and improving engagement with mid-tier clients.

- Improve performance in underperforming regions by **analyzing regional market challenges and adjusting sales strategies accordingly**.

- Focus on **upselling and bundling strategies** to shift more customers toward medium and large deal sizes.

- Implement data-driven sales forecasting to better align inventory and marketing efforts with **seasonal demand patterns**.

---

## Conclusion

This project demonstrates how sales transaction data can be transformed into actionable business insights. The analysis provides a clear understanding of revenue drivers, customer behavior, and product performance, supporting better strategic decision-making.
