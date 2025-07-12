# CoffeeShop Data Warehouse Project

## Overview

This project delivers a complete data warehouse solution for a fictional coffee shop chain. It supports robust business analytics and operational insights by integrating transactional, periodic, and dimensional data.

Key objectives:
- Track sales transactions, staff costs, recipe profitability, and customer behavior.
- Enable performance monitoring through KPIs such as Total Sales Revenue, Staff Efficiency, Recipe Profitability, and Customer Visit Frequency.

The project uses **SQL Server** for data storage, **SSIS** for ETL workflows, and **Power BI** for interactive dashboards.

---

## Source System
[Used Dataset](https://www.kaggle.com/datasets/viramatv/coffee-shop-data)


The source operational data comes from normalized tables covering:

- Orders, Items, Inventory  
- Ingredients and Recipes  
- Staff, Rotas, Shifts  
- Customers

**ER Diagram:**  
<img width="1087" height="748" alt="image" src="https://github.com/user-attachments/assets/b8d7fe7f-1b57-4de0-a337-116e9fb2d100" />


---

## Business Processes Modeled

1. Sales Tracking  
2. Staff Cost Management  
3. Recipe Cost Analysis  
4. Monthly Customer Visit Analysis

---

## Fact Tables

| Fact Table                    | Type             | Grain                            | Measures                          |
|-------------------------------|------------------|----------------------------------|-----------------------------------|
| Fact_Sales                    | Transactional    | Per item per order               | `item_quantity`, `sales_amount`   |
| Fact_Staff_Cost               | Snapshot         | Per staff per shift per day      | `worked_hours`, `cost`            |
| Fact_Recipe                   | Transactional    | Per recipe-item                  | `item_price`, `total_cost`, `profit` |
| Fact_Customer_Visits_Monthly  | Snapshot         | Per customer per month per year  | `visit_count`, `total_spent`      |

---

## Dimension Tables

| Dimension      | Type                    | Notes                                         |
|----------------|-------------------------|-----------------------------------------------|
| Dim_Staff      | SCD Type 2              | Tracks historical role and salary changes     |
| Dim_Item       | SCD Type 1, Conformed   | Shared across Fact_Sales and Fact_Recipe      |
| Dim_Recipe     | SCD Type 1              | Stores recipe details and metadata            |
| Dim_Customer   | SCD Type 2, Conformed   | Captures customer changes for trend analysis  |
| Dim_Shift      | Static                  | Defines staff time blocks                     |
| Dim_Ingredient | Static                  | Supports cost breakdowns                      |
| Dim_Date       | Role Playing            | Supports time-series analytics                |

**Star Schema:**  
<img width="1048" height="741" alt="image" src="https://github.com/user-attachments/assets/cd1577ac-6677-480c-b50e-73b3711b24ce" />

---

## ETL Pipeline

**ETL Architecture:**
- **Staging Area:** Raw data landing and preparation.
- **Data Flow Tasks:** Includes lookups, derived columns, and conditional routing.
- **Control Flow:** Automates truncate/load steps, config updates, and error handling.

**Key Packages:**
- `Fact_Sales.dtsx` — Daily, 2:00 AM
- `Fact_Staff_Cost.dtsx` — Daily, 2:00 AM
- `Fact_Recipe.dtsx` — Daily, 2:00 AM
- `Fact_Customer_Visits_Monthly.dtsx` — Monthly, 2:00 AM

Packages run on schedule via SQL Server Agent Jobs.

---

## Analytical Insights

Example business metrics include:
- Total Sales Revenue
- Monthly Staff Cost
- Most Profitable Recipes
- Top 5 Customers by Spending
- Staff Cost per Hour and Sales per Hour
- Customer Loyalty Score

More than 30 analytical SQL queries were written and validated to ensure accuracy and performance.

---

## Power BI Reporting

Interactive dashboards include:
- **Sales Overview:** Sales by item, order type, daily trends.
- **Staff Dashboard:** Cost per shift, productivity analysis.
- **Recipe Analysis:** Profitability by item and ingredient cost breakdown.
- **Customer Insights:** Visit frequency, spending habits, loyalty trends.

Dashboards feature dynamic filtering, drill-downs, and visual KPIs to support decision-making.

---

## Project Summary

This project demonstrates:
- Solid dimensional modeling using a star schema.
- Automated ETL design with SSIS.
- Reliable data mart creation.
- Actionable, interactive dashboards in Power BI.

It provides a scalable solution for retail analytics in the coffee shop industry.

---

## Full Documentation

All project details, diagrams, and analysis are documented here:  
[Project Report PDF](https://github.com/Nada-ibrahim12/CoffeeShop-Project/blob/main/DWH_Project_20220358_20220015_20220345.pdf)

