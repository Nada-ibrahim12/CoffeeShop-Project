CREATE TABLE [Item_Dim] (
  [item_id] varchar(10) PRIMARY KEY,
  [item_price] decimal(10,2),
  [item_name] varchar(50),
  [item_size] varchar(50),
  [sku] varchar(50)
)
GO

CREATE TABLE [Recipe_Dim] (
  [recipe_id] varchar(10) PRIMARY KEY,
  [ing_id] varchar(10),
  [quantity] int
)
GO

CREATE TABLE [Ingredient_Dim] (
  [ing_id] varchar(10) PRIMARY KEY,
  [ing_price] decimal(10,2),
  [ing_name] varchar(50)
)
GO

CREATE TABLE [Order_Type_Dim] (
  [order_type_id] varchar(10) PRIMARY KEY,
  [order_type_name] varchar(10)
)
GO

CREATE TABLE [Customer_Dim] (
  [customer_id] varchar(10) PRIMARY KEY,
  [cust_name] varchar(50)
)
GO

CREATE TABLE [Shift_Dim] (
  [shift_id] varchar(10) PRIMARY KEY,
  [start_time] time,
  [end_time] time,
  [day_of_week] varchar(10)
)
GO

CREATE TABLE [Date_Dim] (
  [date_id] int PRIMARY KEY,
  [year] int,
  [month] int,
  [day] int,
  [weekday_name] varchar(10)
)
GO

CREATE TABLE [Rota_Dim] (
  [rota_id] varchar(10) PRIMARY KEY,
  [staff_id] varchar(10),
  [shift_id] varchar(10),
  [date] date
)
GO

CREATE TABLE [Staff_Dim] (
  [staff_id] varchar(10) PRIMARY KEY,
  [first_name] varchar(50),
  [last_name] varchar(50),
  [position] varchar(50),
  [sal_per_hour] decimal(10,2)
)
GO

CREATE TABLE [Fact_Sales] (
  [surrogate_id] int PRIMARY KEY,
  [order_id] varchar(10),
  [customer_id] varchar(10),
  [item_id] varchar(10),
  [date_id] int,
  [price] decimal(10,2),
  [quantity] int,
  [sales_amount] decimal(12,2)
)
GO

CREATE TABLE [Fact_Orders] (
  [surrogate_id] int PRIMARY KEY,
  [order_id] varchar(10),
  [customer_id] varchar(10),
  [date_id] int,
  [order_type_id] varchar(10),
  [order_count] int
)
GO

CREATE TABLE [Fact_Ingredient_Usage] (
  [surrogate_id] int PRIMARY KEY,
  [ing_id] varchar(10),
  [order_id] varchar(10),
  [recipe_id] varchar(10),
  [item_id] varchar(10),
  [date_id] int,
  [item_unit] varchar(10),
  [item_quantity] int,
  [quantity_used] decimal(10,2)
)
GO

CREATE TABLE [Fact_Item_Profit] (
  [surrogate_id] int PRIMARY KEY,
  [item_id] varchar(10),
  [recipe_id] varchar(10),
  [ing_id] varchar(10),
  [item_price] decimal(10,2),
  [recipe_cost] decimal(10,2),
  [profit] decimal(10,2)
)
GO

CREATE TABLE [Fact_Staff_Cost] (
  [surrogate_id] int PRIMARY KEY,
  [staff_id] varchar(10),
  [shift_id] varchar(10),
  [rota_id] varchar(10),
  [date_id] int,
  [worked_hours] decimal(5,2),
  [sal_per_hour] decimal(10,2),
  [cost] decimal(12,2)
)
GO

ALTER TABLE [Fact_Sales] ADD FOREIGN KEY ([item_id]) REFERENCES [Item_Dim] ([item_id])
GO

ALTER TABLE [Fact_Sales] ADD FOREIGN KEY ([customer_id]) REFERENCES [Customer_Dim] ([customer_id])
GO

ALTER TABLE [Fact_Sales] ADD FOREIGN KEY ([date_id]) REFERENCES [Date_Dim] ([date_id])
GO

ALTER TABLE [Fact_Orders] ADD FOREIGN KEY ([customer_id]) REFERENCES [Customer_Dim] ([customer_id])
GO

ALTER TABLE [Fact_Orders] ADD FOREIGN KEY ([date_id]) REFERENCES [Date_Dim] ([date_id])
GO

ALTER TABLE [Fact_Orders] ADD FOREIGN KEY ([order_type_id]) REFERENCES [Order_Type_Dim] ([order_type_id])
GO

ALTER TABLE [Fact_Ingredient_Usage] ADD FOREIGN KEY ([ing_id]) REFERENCES [Ingredient_Dim] ([ing_id])
GO

ALTER TABLE [Fact_Ingredient_Usage] ADD FOREIGN KEY ([recipe_id]) REFERENCES [Recipe_Dim] ([recipe_id])
GO

ALTER TABLE [Fact_Ingredient_Usage] ADD FOREIGN KEY ([item_id]) REFERENCES [Item_Dim] ([item_id])
GO

ALTER TABLE [Fact_Ingredient_Usage] ADD FOREIGN KEY ([date_id]) REFERENCES [Date_Dim] ([date_id])
GO

ALTER TABLE [Fact_Item_Profit] ADD FOREIGN KEY ([item_id]) REFERENCES [Item_Dim] ([item_id])
GO

ALTER TABLE [Fact_Item_Profit] ADD FOREIGN KEY ([recipe_id]) REFERENCES [Recipe_Dim] ([recipe_id])
GO

ALTER TABLE [Fact_Item_Profit] ADD FOREIGN KEY ([ing_id]) REFERENCES [Ingredient_Dim] ([ing_id])
GO

ALTER TABLE [Fact_Staff_Cost] ADD FOREIGN KEY ([staff_id]) REFERENCES [Staff_Dim] ([staff_id])
GO

ALTER TABLE [Fact_Staff_Cost] ADD FOREIGN KEY ([shift_id]) REFERENCES [Shift_Dim] ([shift_id])
GO

ALTER TABLE [Fact_Staff_Cost] ADD FOREIGN KEY ([rota_id]) REFERENCES [Rota_Dim] ([rota_id])
GO

ALTER TABLE [Fact_Staff_Cost] ADD FOREIGN KEY ([date_id]) REFERENCES [Date_Dim] ([date_id])
GO
