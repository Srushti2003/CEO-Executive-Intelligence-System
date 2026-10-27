# Data Quality Report — DataCo Supply Chain Dataset

## 1. Source Dataset

- Original rows: 180,519
- Original columns: 53
- Exact duplicate rows detected during initial profiling: 0
- Order date range: January 1, 2015 – January 31, 2018

## 2. Data Quality Findings

- `Order Item Id` contains 180,519 unique, non-null values.
- `Order Id` repeats because multiple order items can belong to one order.
- `Product Description` is completely missing.
- `Order Zipcode` is missing in approximately 86.24% of rows.
- Eight customer last names and three customer ZIP codes are missing.
- No shipping dates precede their corresponding order dates.
- Calculated elapsed time between order and shipping timestamps differs from the recorded shipping duration by no more than 0.5 days.

## 3. Initial Transformations

The following columns were excluded from the core analytical dataset:

- `Product Description`
- `Order Zipcode`
- `Customer Email`
- `Customer Fname`
- `Customer Lname`
- `Customer Street`
- `Customer Password`
- `Product Status` — excluded because it has only one distinct value.

Both order and shipping date columns were converted to datetime types.

No transaction rows were intentionally removed.

## 4. Output

- Processed file: `data/processed/dataco_cleaned.csv`
- Expected rows: 180,519
- Expected columns: 45

## 5. Outstanding Validation

- Independently verify the saved CSV.
- Investigate geographic coordinate quality and remaining missing values.
- Validate business metrics and field definitions before building the warehouse.
