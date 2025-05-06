6CREATE DATABASE CoffeeShop_STG;

USE CoffeeShop_STG;

CREATE TABLE STG_orders (
    order_id VARCHAR(10) NOT NULL,
    created_at DATETIME NOT NULL,
    cust_name VARCHAR(50) NOT NULL,
    in_or_out VARCHAR(10),
    item_name VARCHAR(50) NOT NULL,
    item_cat VARCHAR(20) NOT NULL,
    item_size VARCHAR(10),
	sku VARCHAR(20) NOT NULL,
    item_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    total_price DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (order_id),
	src_update_date DATETIME,
	create_timestamp DATETIME
);

CREATE TABLE STG_recipes (
    recipe_id VARCHAR(20) NOT NULL,
    ing_id VARCHAR(10) NOT NULL,
    ing_name VARCHAR(50) NOT NULL,
    ing_weight DECIMAL(10,2) NOT NULL,
    ing_price DECIMAL(10,2) NOT NULL,
    quantity_used DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (recipe_id, ing_id),
	src_update_date DATETIME,
	create_timestamp DATETIME
);

CREATE TABLE STG_inventory (
    ing_id VARCHAR(10) NOT NULL,
    ing_name VARCHAR(50) NOT NULL,
    ing_weight DECIMAL(10,2) NOT NULL,
    ing_meas VARCHAR(10) NOT NULL,
    ing_price DECIMAL(10,2) NOT NULL,
    inventory_quantity DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (ing_id),
	src_update_date DATETIME,
	create_timestamp DATETIME
);

CREATE TABLE STG_rota (
    rota_id VARCHAR(10) NOT NULL,
    date DATE NOT NULL,
    day_of_week VARCHAR(10) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(20) NOT NULL,
    sal_per_hour DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (rota_id),
	src_update_date DATETIME,
	create_timestamp DATETIME
);

CREATE TABLE STG.Conf_Table
(
  table_name		 varchar(30),
  last_extract_date	 datetime
);