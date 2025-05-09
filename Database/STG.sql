create DATABASE CoffeeShop_STG;

USE CoffeeShop_STG;
alter table stg_staff
drop column 

CREATE TABLE stg_staff (
    staff_id VARCHAR(10),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    position VARCHAR(20),
    sal_per_hour DECIMAL(10, 2),
	src_update_date  datetime,
  create_timestamp	datetime
);

CREATE TABLE stg_items (
    item_id VARCHAR(10),
    sku VARCHAR(20),
    item_name VARCHAR(50),
    item_cat VARCHAR(20),
    item_size VARCHAR(10),
    item_price DECIMAL(10, 2),
	src_update_date  datetime,
  create_timestamp	datetime
);

CREATE TABLE stg_orders (
    row_id INT,
    order_id VARCHAR(10),
    created_at DATETIME,
    item_id VARCHAR(10),
    quantity INT,
    cust_name VARCHAR(50),
    in_or_out VARCHAR(10),
	src_update_date  datetime,
  create_timestamp	datetime
);


CREATE TABLE stg_recipes (
    row_id INT,
    recipe_id VARCHAR(20),
	ing_id VARCHAR(10),
    ing_name VARCHAR(50),
    ing_weight DECIMAL(10, 2),
    ing_meas VARCHAR(10),
    ing_price DECIMAL(10, 2),
	recipe_quantity DECIMAL(10, 2),
	src_update_date  datetime,
  create_timestamp	datetime
);

CREATE TABLE stg_inventory (
    inv_id VARCHAR(10),
    ing_id VARCHAR(10),
    quantity DECIMAL(10, 2),
	src_update_date  datetime,
  create_timestamp	datetime
);

CREATE TABLE stg_shift (
    shift_id VARCHAR(10),
    day_of_week VARCHAR(10),
    start_time TIME,
    end_time TIME,
	src_update_date  datetime,
    create_timestamp	datetime
);


CREATE TABLE stg_rota (
    row_id INT,
    rota_id VARCHAR(10),
    date DATE,
    shift_id VARCHAR(10),
    staff_id VARCHAR(10),
	src_update_date  datetime,
  create_timestamp	datetime
);

CREATE TABLE Conf_Table
(
  table_name		 varchar(30),
  last_extract_date	 datetime
);

DELETE FROM Conf_Table;

INSERT INTO Conf_Table VALUES
	('orders', '1950-01-01'),
	('items', '1950-01-01'),
	('inventory', '1950-01-01'),
	('rota', '1950-01-01'),
	('shift', '1950-01-01'),
	('staff', '1950-01-01'),
	('ingredients', '1950-01-01'),
	('recipes', '1950-01-01');


	SELECT * FROM stg_recipes;
	SELECT * FROM Conf_Table;