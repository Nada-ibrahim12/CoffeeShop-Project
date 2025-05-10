CREATE DATABASE CoffeeShop_DWH;

USE CoffeeShop_DWH;

---- DIMENSION TABLES

-- INGREDIENT DIMENSION TABLE
CREATE TABLE Ingredients_Dim (
	ing_id VARCHAR(10),
    ing_name VARCHAR(50),
    ing_weight DECIMAL(10, 2),
    ing_meas VARCHAR(10),
    ing_price DECIMAL(10, 2)
);

-- RECIPE DIMENSION TABLE
CREATE TABLE Recipe_Dim (
	recipe_id varchar(20) PRIMARY KEY,
	ingredients NVARCHAR(MAX),
	quantities NVARCHAR(MAX)
);

-- ITEM DIMENSION TABLE 
CREATE TABLE Item_Dim (
	item_id VARCHAR(10) PRIMARY KEY,
	item_price DECIMAL(10,2),
	item_name VARCHAR(50),
	item_size VARCHAR(10),
	SKU VARCHAR(50)
);

-- ORDER TYPE DIMENSION TABLE 
CREATE TABLE Order_Type_Dim (
	order_type_id VARCHAR(10) PRIMARY KEY,
	order_type_name VARCHAR(10)
);

-- STAFF DIMENSION TABLE
CREATE TABLE Staff_Dim (
	staff_id VARCHAR(10) PRIMARY KEY,
	staff_name VARCHAR(100),
	position VARCHAR(50),
	sal_per_hour DECIMAL(10,2),
);

-- SHIFT DIMENSION TABLE 
CREATE TABLE Shift_Dim (
	shift_id VARCHAR(10) PRIMARY KEY,
	start_time TIME,
	end_time Time,
	day_of_week VARCHAR(50)
);

-- DATE DIMENSION
CREATE TABLE Dim_Date (
    Date_ID BIGINT PRIMARY KEY IDENTITY(1,1),
    FullDate DATE,
    Day INT,
    Month INT,
    Year INT,
    Quarter INT,
    MonthName NVARCHAR(20),
    DayName NVARCHAR(20),
    IsWeekend BIT
);

-- CUSTOMER DIMENSION
CREATE Table Dim_Customer (
  customer_id INT PRIMARY KEY IDENTITY(1,1),
  cust_name VARCHAR(50)
);


---- FACT TABLES

-- SALES FACT TABLE
CREATE TABLE Fact_Sales (
	surrogate_id INT PRIMARY KEY IDENTITY(1,1),
	order_id VARCHAR(10),
    date_id BIGINT FOREIGN KEY REFERENCES Dim_Date(Date_ID),
	cust_id INT FOREIGN KEY REFERENCES Dim_Customer(customer_id),
	order_type_id VARCHAR(10) FOREIGN KEY REFERENCES Order_Type_Dim(order_type_id),
	item_quantity INT,
	sales_amount DECIMAL(10,2) -- item_price * item_quantity
);

-- STAFF COST FACT TABLE
CREATE TABLE Fact_Staff_Cost (
	surrogate_id INT PRIMARY KEY IDENTITY(1,1),
	staff_id VARCHAR(10) FOREIGN KEY REFERENCES Staff_Dim(staff_id),
	shift_id VARCHAR(10) FOREIGN KEY REFERENCES Shift_Dim(shift_id),
    date_id BIGINT FOREIGN KEY REFERENCES Dim_Date(Date_ID),
	worked_hours INT,
	sal_per_hour DECIMAL(10,2),
	cost DECIMAL(10,2)
);

-- RECIPES FACT TABLE
CREATE TABLE Fact_Recipe (
    recipe_id VARCHAR(20),
    item_id VARCHAR(10),
	item_price DECIMAL(10,2),
    total_cost DECIMAL(10,2), 
	profit DECIMAL(10,2), 
    FOREIGN KEY (recipe_id) REFERENCES Recipe_Dim(recipe_id),
    FOREIGN KEY (item_id) REFERENCES Item_Dim(item_id),
);

-- CUSTOMER VISITS FACT TABLE
CREATE TABLE Fact_Customer_Visits_Monthly (
    visit_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT FOREIGN KEY REFERENCES Dim_Customer(customer_id),
    cust_name VARCHAR(50),
    month_name NVARCHAR(20),
    year INT,
    visit_count INT,
    total_spent DECIMAL(10,2),
);



-- OLD SCHEMAA
-- RECIPE INGREDIENT DIMENSION TABLE (OLD)
-- CREATE TABLE IngredientRecipe_Dim (
--    ingredient_recipe_id VARCHAR(20) PRIMARY KEY,
--	recipe_id VARCHAR(20),
--    ing_id VARCHAR(10),
--    ing_name VARCHAR(50),
--    ing_weight DECIMAL(10, 2),
--    ing_meas VARCHAR(10),
--    ing_price DECIMAL(10, 2),
--    recipe_quantity DECIMAL(10, 2),
--);

--1. ITEM PROFIT FACT TABLE
CREATE TABLE Fact_Item_Profit (
	surrogate_id INT PRIMARY KEY IDENTITY(1,1),
	item_id VARCHAR(10) FOREIGN KEY REFERENCES Item_Dim(item_id),
	recipe_id VARCHAR(20) FOREIGN KEY REFERENCES Recipe_Dim(recipe_id),
	item_price DECIMAL(10,2),
	recipe_cost DECIMAL(10,2),
	profit DECIMAL(10,2)
);

--2.INGREDIENTS USAGE FACT TABLE (OLD)
CREATE TABLE Fact_Ingredients_Usage (
    surrogate_id INT PRIMARY KEY IDENTITY(1,1),
    ingredient_recipe_id VARCHAR(20) FOREIGN KEY REFERENCES IngredientRecipe_Dim(ingredient_recipe_id),
    item_id VARCHAR(10) FOREIGN KEY REFERENCES Item_Dim(item_id),
    date_id BIGINT FOREIGN KEY REFERENCES Date_Dim(date_id),
    item_quantity INT,
    ing_quantity_used INT
);