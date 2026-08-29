# E-Commerce Sales & Customer Analytics

**Author:** Lakshay Kathpalia  
**Tools:** MySQL, SQL, Power BI (dashboard phase)

## Project Overview

This project analyses a small e-commerce dataset to understand sales performance, customer purchasing behaviour, product performance and geographic revenue.

The analysis uses MySQL to transform relational data into business-focused metrics that can later be presented in an interactive Power BI dashboard.

## Business Questions

The project investigates:

- How many customers and orders are in the database?
- How many orders were completed or cancelled?
- What is the total revenue from completed orders?
- Which product categories generate the most revenue?
- Which products are the top revenue generators?
- Who are the highest-value customers?
- How does revenue change by month?
- Which cities generate the most revenue?
- Which customers are repeat purchasers?
- Which customers spend more than ₹50,000?
- What is the average order value?

## Database Schema

```text
customers
    |
    | customer_id
    v
orders
    |
    | order_id
    v
order_items
    |
    | product_id
    v
products
```

Revenue is calculated as:

`Revenue = product price × quantity`

Only orders with `order_status = 'Completed'` are included in revenue analysis.

## SQL Skills Demonstrated

- SELECT and filtering
- WHERE and HAVING
- GROUP BY
- ORDER BY and LIMIT
- COUNT and COUNT(DISTINCT)
- SUM and AVG
- INNER JOIN across multiple tables
- Date formatting with DATE_FORMAT()
- CASE WHEN
- Subquery concepts
- Business KPI calculations

## Key Findings From the Current Dataset

The completed-order analysis produces:

- **10 customers**
- **15 total orders**
- **13 completed orders**
- **2 cancelled orders**
- **₹378,200 completed-order revenue**

### Revenue by category

| Category | Revenue |
|---|---:|
| Electronics | ₹317,900 |
| Furniture | ₹49,500 |
| Accessories | ₹10,800 |

### Monthly revenue

| Month | Revenue |
|---|---:|
| 2024-06 | ₹136,700 |
| 2024-07 | ₹86,200 |
| 2024-08 | ₹155,300 |

### Highest-revenue cities

| City | Revenue |
|---|---:|
| Delhi | ₹211,700 |
| Mumbai | ₹87,400 |
| Pune | ₹30,400 |
| Hyderabad | ₹30,000 |

## Business Insights

1. Electronics is the dominant revenue category in this dataset, contributing the majority of completed-order revenue.
2. Delhi is the strongest city by revenue, driven by multiple customers and higher-value purchases.
3. August generated the highest monthly revenue among the three months analysed.
4. Repeat customers can be identified using order-level aggregation and HAVING filters.
5. The dataset demonstrates how transaction-level data can be converted into customer, product, category and geographic KPIs.

## Power BI Dashboard Plan

The dashboard should contain:

### KPI Cards
- Total Revenue
- Completed Orders
- Average Order Value
- Cancellation Rate

### Visuals
- Monthly Revenue — line chart
- Revenue by Category — bar/donut chart
- Top 5 Products — horizontal bar chart
- Revenue by City — bar/map if appropriate
- Top Customers — table/bar chart
- Completed vs Cancelled Orders — donut/bar chart

### Suggested filters
- Order Month
- Category
- City
- Order Status

## Project Structure

```text
ecommerce-sales-analytics/
│
├── ecommerce_sales_analysis.sql
├── README.md
└── dashboard/
    └── powerbi_dashboard_screenshot.png
```

## Future Improvements

- Add a larger real-world dataset
- Add customer segmentation
- Add month-over-month growth
- Add SQL window functions
- Build the Power BI dashboard
- Add Python-based exploratory analysis
