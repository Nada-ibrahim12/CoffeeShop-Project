CREATE DATABASE CoffeeShop_DWH;

USE CoffeeShop_DWH;
---- DIMENSION TABLES
DROP DATABASE CoffeeShop_DWH;

--1. RECIPE DIMENSION TABLE
SELECT * FROM IngredientRecipe_Dim;

DELETE FROM IngredientRecipe_Dim;

-- conformed (used in ETL)
CREATE TABLE IngredientRecipe_Dim (
    ingredient_recipe_id VARCHAR(30) PRIMARY KEY,
	recipe_id VARCHAR(20),
    ing_id VARCHAR(10),
    ing_name VARCHAR(50),
    ing_weight DECIMAL(10, 2),
    ing_meas VARCHAR(10),
    ing_price DECIMAL(10, 2),
    recipe_quantity DECIMAL(10, 2)
);

-- SCD Type 1
CREATE TABLE Recipe_Dim (
    recipe_id VARCHAR(20) PRIMARY KEY,
);


DROP TABLE IngredientRecipe_Dim;
--3. ITEM DIMENSION TABLE (SCD type 1 -> overwrite)
CREATE TABLE Item_Dim (
	item_id VARCHAR(10) PRIMARY KEY,
	item_price DECIMAL(10,2),
	item_name VARCHAR(50),
	item_size VARCHAR(10),
	SKU VARCHAR(50),
); 

--4. ORDER TYPE DIMENSION TABLE 
CREATE TABLE Order_Type_Dim (
	order_type_id VARCHAR(10) PRIMARY KEY,
	order_type_name VARCHAR(10)
);

--5. STAFF DIMENSION TABLE
CREATE TABLE Staff_Dim (
	staff_id VARCHAR(10) PRIMARY KEY,
	staff_name VARCHAR(100),
	position VARCHAR(50),
	sal_per_hour DECIMAL(10,2),
	Start_Date_Sal_Position DATE,
    End_Date_Sal_Position DATE,
    Current_Flag_Sal_Position BIT
);

--6. SHIFT DIMENSION TABLE 
CREATE TABLE Shift_Dim (
	shift_id VARCHAR(10) PRIMARY KEY,
	start_time TIME,
	end_time Time,
	day_of_week VARCHAR(50)
);

--7. ROTATION DIMENSION TABLE
--CREATE TABLE Rota_Dim (
--	rota_id VARCHAR(10) PRIMARY KEY,
--	staff_id VARCHAR(10),
--	shift_id VARCHAR(10),
--	[date] Date
--);

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
select * from Dim_Date;
INSERT INTO Dim_Date (FullDate, Day, Month, Year, Quarter, MonthName, DayName, IsWeekend)
VALUES 
('2024-02-12', 12, 2, 2024, 1, 'January', 'Wednesday', 0),
('2024-02-13', 13, 2, 2024, 1, 'January', 'Thursday', 0),
('2024-02-14', 14, 2, 2024, 1, 'January', 'Friday', 0),
('2024-02-15', 15, 2, 2024, 1, 'January', 'Saturday', 1),
('2024-02-16', 16, 2, 2024, 1, 'January', 'Sunday', 1),
('2024-02-17', 17, 2, 2024, 1, 'January', 'Monday', 0),
('2024-02-18', 18, 2, 2024, 1, 'January', 'Tuesday', 0);

CREATE Table Dim_Customer (
  customer_id INT PRIMARY KEY,
  cust_name VARCHAR(50)
);


---- FACT TABLES
--1. ITEM PROFIT FACT TABLE
CREATE TABLE Fact_Item_Profit (
	surrogate_id INT PRIMARY KEY IDENTITY(1,1),
	item_id VARCHAR(10) FOREIGN KEY REFERENCES Item_Dim(item_id),
    recipe_id VARCHAR(20),
	item_price DECIMAL(10,2),
	recipe_cost DECIMAL(10,2),
	profit DECIMAL(10,2)
);
SELECT * FROM Fact_Item_Profit;

DROP TABLE Fact_Item_Profit;

--2. INGREDIENTS USAGE FACT TABLE
CREATE TABLE Fact_Ingredients_Usage (
    surrogate_id INT PRIMARY KEY IDENTITY(1,1),
    ingredient_recipe_id VARCHAR(30) FOREIGN KEY REFERENCES IngredientRecipe_Dim(ingredient_recipe_id),
    item_id VARCHAR(10) FOREIGN KEY REFERENCES Item_Dim(item_id),
    date_id BIGINT FOREIGN KEY REFERENCES Dim_Date(Date_ID),
    item_quantity INT,  
    ing_quantity_used INT 
);


select * from Fact_Ingredients_Usage;
drop table Fact_Ingredients_Usage;
--3. SALES FACT TABLE
CREATE TABLE Fact_Sales (
	surrogate_id INT PRIMARY KEY IDENTITY(1,1),
	order_id VARCHAR(10),
	item_id VARCHAR(10) FOREIGN KEY REFERENCES Item_Dim(item_id),
	date_id BIGINT FOREIGN KEY REFERENCES Dim_Date(Date_ID), 
	cust_id INT FOREIGN KEY REFERENCES Dim_Customer(customer_id),
	order_type_id VARCHAR(10) FOREIGN KEY REFERENCES Order_Type_Dim(order_type_id),
	item_price DECIMAL(10,2),
	item_quantity INT,
	sales_amount DECIMAL(10,2) -- item_price * item_quantity
);

--4. STAFF COST FACT TABLE
CREATE TABLE Fact_Staff_Cost (
	surrogate_id INT PRIMARY KEY IDENTITY(1,1),
	staff_id VARCHAR(10) FOREIGN KEY REFERENCES Staff_Dim(staff_id),
	shift_id VARCHAR(10) FOREIGN KEY REFERENCES Shift_Dim(shift_id),
	date_id BIGINT FOREIGN KEY REFERENCES Dim_Date(Date_ID), 
	worked_hours INT,
	sal_per_hour DECIMAL(10,2),
	cost DECIMAL(10,2)
);