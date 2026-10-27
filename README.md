# CEO Executive Intelligence System

An end-to-end data analytics project that transforms supply chain data into executive-level business insights using **Python, PostgreSQL, SQL, and Power BI**.

## Project Overview

The CEO Executive Intelligence System is designed to help business decision-makers monitor sales performance, understand customer segments, evaluate geographic markets, analyze product performance, and identify shipping and delivery risks.

The project follows an analytics workflow from data profiling and preprocessing to relational data modeling, SQL-based analysis, and interactive Power BI reporting.

## Business Problem

Supply chain businesses generate large volumes of transactional data, but raw records do not automatically provide actionable business insights.

Decision-makers need a consolidated view of key performance indicators, sales trends, customer contributions, market performance, and delivery risks to identify areas that require attention.

This project addresses that need by organizing transactional data into an analytical data warehouse and presenting the results through an executive dashboard.

## Project Objectives

- Profile and clean the source dataset.
- Identify data-quality issues and document preprocessing decisions.
- Build a structured PostgreSQL analytical data model.
- Create SQL views for reusable business analysis.
- Analyze sales, orders, customers, products, geography, and delivery performance.
- Develop a multi-page Power BI report for executive decision support.

## Technology Stack

| Technology | Purpose |
|---|---|
| Python | Data profiling and preprocessing |
| Pandas | Data manipulation and cleaning |
| Jupyter Notebook | Exploratory data profiling |
| PostgreSQL | Data storage and analytical database |
| SQL | Data modeling, transformations, aggregations, and analytical views |
| Power BI Desktop | Interactive dashboard development |
| Git and GitHub | Version control and project documentation |

## Dataset

The project uses the DataCo Smart Supply Chain dataset.

### Dataset profile

- Original records: **180,519 rows**
- Original columns: **53**
- Processed analytical columns: **45**
- Order date range: **January 2015 – January 2018**
- Exact duplicate rows detected during initial profiling: **0**

The dataset contains order, product, customer, sales, geography, and shipping-related information.

For privacy and repository size considerations, the source CSV files and processed datasets are excluded from the public GitHub repository. Obtain the dataset from its original authorized source and place the files in the corresponding local `data/` directories before running the workflow.

## Data Cleaning and Quality Assessment

Data profiling and preprocessing were performed in Python.

Key activities included:

- Inspecting dataset dimensions, data types, missing values, and duplicate records.
- Identifying columns with extensive missing values or limited analytical usefulness.
- Excluding customer-identifying fields such as names, email addresses, street addresses, and password-related data from the core analytical dataset.
- Excluding the constant `Product Status` column.
- Converting order and shipping date fields to datetime types.
- Reviewing order and shipping date consistency.
- Saving the cleaned dataset with 180,519 rows and 45 columns.

The project includes a data-quality report documenting the initial findings and preprocessing decisions.

**Data-quality note:** Initial profiling did not identify exact duplicate rows. Further validation of geographic coordinates, remaining missing values, and business metric definitions should be performed when extending the analysis.

## Data Warehouse and SQL Analytics

PostgreSQL was used to organize the data into staging, warehouse, and analytical layers.

The warehouse includes a fact table for order items and dimensions for relevant business entities, including dates, order status, products, customers, and geography.

### SQL workflow

1. **Setup:** Create the database and required schemas.
2. **Staging:** Load and prepare the source data.
3. **Warehouse:** Build fact and dimension tables.
4. **Analytics:** Create reusable views for business reporting.

### Analytical views

The project includes the following reporting views:

- `mart.vw_executive_kpis`
- `mart.vw_monthly_performance`
- `mart.vw_product_performance`
- `mart.vw_customer_segment_performance`
- `mart.vw_geography_performance`
- `mart.vw_shipping_performance`

These views provide aggregated data for Power BI reporting.

## Power BI Executive Dashboard

The Power BI report contains five pages.

### 1. Executive Overview

Provides a high-level summary of business performance through KPI cards and charts.

- Total Sales
- Total Orders
- Total Customers
- Reported Profit
- Late Delivery Rate
- Average Actual Shipping Days
- Monthly Sales Trend
- Sales by Customer Segment
- Sales by Product Category

![Executive Overview](power%20bi/screenshots/CEO%20Executive%20Intelligence%20Dashboard_page-0001.jpg)

### 2. Sales & Product Performance

Analyzes product-level and category-level sales and reported profit.

- Top 10 Products by Sales
- Monthly Reported Profit Trend
- Sales vs. Reported Profit by Category
- Product Category Sales Ranking

![Sales and Product Performance](power%20bi/screenshots/CEO%20Executive%20Intelligence%20Dashboard_page-0002.jpg)

### 3. Customer Intelligence

Compares customer segments to understand their contribution to business performance.

- Sales by Customer Segment
- Orders by Customer Segment
- Customers by Segment
- Average Sales per Customer by Segment

![Customer Intelligence](power%20bi/screenshots/CEO%20Executive%20Intelligence%20Dashboard_page-0003.jpg)

### 4. Geographic Performance

Explores geographic sales distribution and differences in market activity.

- Top 10 Countries by Sales
- Geographic Sales Distribution
- Top 10 Countries by Order Volume
- Sales by Market

![Geographic Performance](power%20bi/screenshots/CEO%20Executive%20Intelligence%20Dashboard_page-0004.jpg)

### 5. Shipping & Delivery Risk

Examines shipping duration, delivery outcomes, and late-delivery risk.

- Late Delivery Risk by Shipping Mode
- Actual vs. Scheduled Shipping Days
- Delivery Status Distribution
- Late Delivery Risk by Shipping Mode and Status

![Shipping and Delivery Risk](power%20bi/screenshots/CEO%20Executive%20Intelligence%20Dashboard_page-0005.jpg)

## Key Findings

The following findings were identified from the dataset and SQL analysis:

- **Sales:** Total sales were approximately 36.78 million in the dataset's recorded currency units.
- **Reported profit:** The dataset's reported profit measure totaled approximately 3.97 million.
- **Customer segments:** Consumer customers contributed approximately 19.10 million in sales, followed by Corporate at 11.17 million and Home Office at 6.52 million.
- **Product performance:** Fishing was among the leading categories by sales, at approximately 6.93 million.
- **Delivery risk:** Approximately 54.83% of order items were flagged with late-delivery risk in the initial analysis.
- **Shipping performance:** Average actual shipping time was approximately 3.50 days, compared with approximately 2.93 scheduled days.

These are historical descriptive findings, not forecasts or proof of causation. The late-delivery-risk indicator is not necessarily equivalent to confirmed late delivery, and the dataset-reported profit measure should not be treated as independently verified accounting profit.

January 2018 is a partial month in the available data, so monthly comparisons involving that period require caution.

## Repository Structure

```text
CEO Executive Intelligence System/
├── data/
│   ├── raw/
│   └── processed/
├── docs/
│   ├── data_quality_report.md
│   └── SQL Results.docx
├── python/
│   └── notebooks/
│       └── 01_data_profiling.ipynb
├── sql/
│   ├── 1_setup/
│   ├── 2_staging/
│   ├── 3_warehouse/
│   └── 4_analytics/
├── power bi/
│   ├── CEO Executive Intelligence Dashboard.pbix
│   └── screenshots/
├── .gitignore
└── README.md
```

The data directories are retained locally but excluded from version control.

## How to Reproduce the Project

### Prerequisites

- Python 3
- Jupyter Notebook
- PostgreSQL
- A SQL client such as pgAdmin
- Power BI Desktop

### Setup

1. Obtain the DataCo Smart Supply Chain dataset from its authorized source.
2. Place the required source files in `data/raw/`.
3. Install the Python packages needed by the profiling notebook, including Pandas and Jupyter.
4. Run `python/notebooks/01_data_profiling.ipynb` and review the documented data-quality findings.
5. Follow the SQL scripts in the numbered folders under `sql/`, in workflow order: setup, staging, warehouse, and analytics.
6. Update database connection settings as needed for your local PostgreSQL environment.
7. Open the Power BI file in `power bi/` and configure the PostgreSQL connection for your own database.
8. Refresh the report after the required tables and views have been created.

SQL scripts may need to be executed in their intended sequence. Database names, credentials, and local paths should be configured for the environment in which the project is reproduced.

## Limitations and Future Improvements

- Validate remaining missing values and geographic coordinates more comprehensively.
- Standardize SQL script names to make execution order easier to follow.
- Add automated data-quality checks and repeatable pipeline execution.
- Further validate the definitions and denominators used for delivery-risk KPIs.
- Add forecasting or anomaly detection for sales and shipping performance.
- Improve documentation of metric definitions and expected outputs.

## Author

**Srushti Dewalekar**

Aspiring Data Analyst | SQL | Python | PostgreSQL | Power BI

This project demonstrates practical skills in data cleaning, relational data modeling, SQL analytics, KPI development, data visualization, and business-oriented reporting.
