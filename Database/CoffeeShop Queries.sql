USE CoffeeShop_DWH;


SELECT * FROM Fact_Sales
WHERE cust_id = 11;

SELECT * FROM Fact_Customer_Visits_Monthly
WHERE customer_id = 11;


SELECT 
    COUNT(CASE WHEN order_type_id = 1 THEN 1 END) AS In_order_Count,
    COUNT(CASE WHEN order_type_id = 2 THEN 1 END) AS Out_order_Count
FROM Fact_Sales;

SELECT 
    order_type_id,
    COUNT(order_type_id) AS order_count
FROM Fact_Sales
GROUP BY order_type_id;


-------------------------------------
------------ FACT_SALES --------------
-- Total Sales Amount
SELECT SUM(sales_amount) AS Total_Sales FROM Fact_Sales;

-- Count of All Orders
SELECT COUNT(*) AS Total_Orders FROM Fact_Sales;

-- Sales by Order Type
SELECT o.order_type_name, SUM(fs.sales_amount) AS Total_Sales
FROM Fact_Sales fs
JOIN Order_Type_Dim o ON fs.order_type_id = o.order_type_id
GROUP BY o.order_type_name;

-- Number of Unique Customers per Order Type
SELECT order_type_id, COUNT(DISTINCT cust_id) AS Unique_Customers
FROM Fact_Sales
GROUP BY order_type_id;

-- Average Sales Amount Per Order
SELECT AVG(sales_amount) AS Avg_Sales_Amount FROM Fact_Sales;

-- Monthly Sales Trend
SELECT d.MonthName, d.Year, SUM(fs.sales_amount) AS Monthly_Sales
FROM Fact_Sales fs
JOIN Dim_Date d ON fs.date_id = d.Date_ID
GROUP BY d.MonthName, d.Year
ORDER BY d.Year, d.MonthName;

-- Top 5 Customers by Total Sales
SELECT c.customer_id, c.cust_name, SUM(fs.sales_amount) AS Total_Spent
FROM Fact_Sales fs
JOIN Dim_Customer c ON fs.cust_id = c.customer_id
GROUP BY c.customer_id, c.cust_name
ORDER BY Total_Spent DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- Monthly Sales Growth (Percent Change)
WITH MonthlySales AS (
  SELECT d.Year, d.Month, 
         SUM(fs.sales_amount) AS Total_Sales
  FROM Fact_Sales fs
  JOIN Dim_Date d ON fs.date_id = d.Date_ID
  GROUP BY d.Year, d.Month
)
SELECT Year, Month, Total_Sales,
       LAG(Total_Sales) OVER (ORDER BY Year, Month) AS Prev_Month_Sales,
       ROUND(
         (Total_Sales - LAG(Total_Sales) OVER (ORDER BY Year, Month)) * 100.0 /
         NULLIF(LAG(Total_Sales) OVER (ORDER BY Year, Month), 0), 2
       ) AS Sales_Growth_Percent
FROM MonthlySales;


------------------------------------------
------------ FACT_STAFF_COST--------------
-- Total Staff Cost
SELECT SUM(cost) AS Total_Staff_Cost FROM Fact_Staff_Cost;

-- Count of Shifts Worked
SELECT COUNT(*) AS Total_Shifts FROM Fact_Staff_Cost;

-- Total Hours Worked Per Staff
SELECT staff_id, SUM(worked_hours) AS Total_Hours
FROM Fact_Staff_Cost
GROUP BY staff_id;

-- Average Salary Per Hour Across All Staff
SELECT AVG(sal_per_hour) AS Avg_Salary_Per_Hour FROM Fact_Staff_Cost;

-- Staff with Highest Cost in a Single Month
SELECT TOP 1 s.staff_id, s.staff_name, d.MonthName, d.Year, SUM(fsc.cost) AS Monthly_Cost
FROM Fact_Staff_Cost fsc
JOIN Staff_Dim s ON fsc.staff_id = s.staff_id
JOIN Dim_Date d ON fsc.date_id = d.Date_ID
GROUP BY s.staff_id, s.staff_name, d.MonthName, d.Year
ORDER BY Monthly_Cost DESC;

-- Staff Cost Per Month
SELECT d.MonthName, d.Year, SUM(fsc.cost) AS Monthly_Staff_Cost
FROM Fact_Staff_Cost fsc
JOIN Dim_Date d ON fsc.date_id = d.Date_ID
GROUP BY d.MonthName, d.Year
ORDER BY d.Year, d.MonthName;

-- Staff Efficiency: Cost per Hour
SELECT staff_id, SUM(cost)/NULLIF(SUM(worked_hours), 0) AS Cost_Per_Hour
FROM Fact_Staff_Cost
GROUP BY staff_id;

-- Staff Cost vs Worked Hours Correlation
SELECT staff_id, 
       SUM(cost) AS Total_Cost, 
       SUM(worked_hours) AS Total_Hours,
       ROUND(SUM(cost)*1.0 / NULLIF(SUM(worked_hours), 0), 2) AS Effective_Rate
FROM Fact_Staff_Cost
GROUP BY staff_id
ORDER BY Effective_Rate DESC;


--------------------------------------
------------ FACT_RECIPE--------------
-- Total Profit from All Recipes
SELECT SUM(profit) AS Total_Profit FROM Fact_Recipe;

-- Total Cost of Ingredients Used
SELECT SUM(total_cost) AS Total_Recipe_Cost FROM Fact_Recipe;

-- Profit by Item
SELECT item_id, SUM(profit) AS Profit_Per_Item
FROM Fact_Recipe
GROUP BY item_id;

-- Most Expensive Recipe (By Cost)
SELECT TOP 1 recipe_id, total_cost
FROM Fact_Recipe
ORDER BY total_cost DESC;


-- Average Item Price
SELECT AVG(item_price) AS Avg_Item_Price FROM Fact_Recipe;

-- Top 5 Most Profitable Recipes
SELECT recipe_id, SUM(profit) AS Total_Profit
FROM Fact_Recipe
GROUP BY recipe_id
ORDER BY Total_Profit DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- Profit Margin per Item
SELECT item_id, 
       SUM(profit) / NULLIF(SUM(item_price * 1.0), 0) AS Profit_Margin
FROM Fact_Recipe
GROUP BY item_id;

------------------------------------
-----FACT_CUSTOMER_VISITS_MONTHLY---
-- Total Visits
SELECT SUM(visit_count) AS Total_Visits FROM Fact_Customer_Visits_Monthly;

-- Total Revenue from Visits
SELECT SUM(total_spent) AS Total_Revenue FROM Fact_Customer_Visits_Monthly;

-- Visits Per Month
SELECT month_name, year, SUM(visit_count) AS Monthly_Visits
FROM Fact_Customer_Visits_Monthly
GROUP BY month_name, year
ORDER BY year, month_name;

-- Average Spending per Customer
SELECT customer_id, cust_name, 
       AVG(total_spent) AS Avg_Spending
FROM Fact_Customer_Visits_Monthly
GROUP BY customer_id, cust_name;

-- Average Monthly Visit Count Per Customer
SELECT customer_id, cust_name, 
       AVG(visit_count) AS Avg_Monthly_Visits
FROM Fact_Customer_Visits_Monthly
GROUP BY customer_id, cust_name;

-- Top 5 Customers by Spending
SELECT customer_id, cust_name, 
       SUM(total_spent) AS Total_Spent
FROM Fact_Customer_Visits_Monthly
GROUP BY customer_id, cust_name
ORDER BY Total_Spent DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- Visit Frequency & Spending Trend per Year
SELECT year, 
       AVG(visit_count) AS Avg_Visits, 
       AVG(total_spent) AS Avg_Spent
FROM Fact_Customer_Visits_Monthly
GROUP BY year
ORDER BY year;

-- Loyalty Score: Total Visits * Avg Spend
SELECT customer_id, cust_name,
       SUM(visit_count) * AVG(total_spent / NULLIF(visit_count, 0)) AS Loyalty_Score
FROM Fact_Customer_Visits_Monthly
GROUP BY customer_id, cust_name
ORDER BY Loyalty_Score DESC;


----------------------------------------------------
-------MULTIPLE TABLES
-- Total Profit by Customer (Sales + Recipe)
SELECT c.customer_id, c.cust_name,
       SUM(fs.sales_amount) AS Total_Sales,
       SUM(fr.profit) AS Estimated_Recipe_Profit
FROM Fact_Sales fs
JOIN Dim_Customer c ON fs.cust_id = c.customer_id
JOIN Fact_Recipe fr ON fs.order_id = fr.recipe_id -- Assuming mapping exists
GROUP BY c.customer_id, c.cust_name;

-- Profit Per Staff Hour (Sales / Worked Hours)
SELECT fsc.staff_id, 
       ROUND(SUM(fs.sales_amount) / NULLIF(SUM(fsc.worked_hours), 0), 2) AS Sales_Per_Hour
FROM Fact_Staff_Cost fsc
JOIN Fact_Sales fs ON fsc.date_id = fs.date_id
GROUP BY fsc.staff_id;
