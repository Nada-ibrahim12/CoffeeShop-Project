CREATE DATABASE CoffeeShop;
DROP DATABASE CoffeeShop;
USE  CoffeeShop;

CREATE TABLE staff (
    staff_id VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position VARCHAR(20) NOT NULL,
    sal_per_hour DECIMAL(10,2) NOT NULL

);

CREATE TABLE items (
    item_id VARCHAR(10) PRIMARY KEY,
    sku VARCHAR(20) NOT NULL,
    item_name VARCHAR(50) NOT NULL,
    item_cat VARCHAR(20) NOT NULL,
    item_size VARCHAR(10),
    item_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE orders (
    row_id INT PRIMARY KEY,
    order_id VARCHAR(10) NOT NULL,
    created_at DATETIME NOT NULL,
    item_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    cust_name VARCHAR(50) NOT NULL,
    in_or_out VARCHAR(10),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

CREATE TABLE ingredients (
    ing_id VARCHAR(10) PRIMARY KEY,
    ing_name VARCHAR(50) NOT NULL,
    ing_weight DECIMAL(10,2) NOT NULL,
    ing_meas VARCHAR(10) NOT NULL,
    ing_price DECIMAL(10,2) NOT NULL
);

SELECT * FROM ingredients;

CREATE TABLE recipes (
    row_id INT PRIMARY KEY,
    recipe_id VARCHAR(20) NOT NULL,
    ing_id VARCHAR(10) NOT NULL,
    quantity DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ing_id) REFERENCES ingredients(ing_id)
);

CREATE TABLE inventory (
    inv_id VARCHAR(10) PRIMARY KEY,
    ing_id VARCHAR(10) NOT NULL,
    quantity DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ing_id) REFERENCES ingredients(ing_id)
);

CREATE TABLE shift (
    shift_id VARCHAR(10) PRIMARY KEY,
    day_of_week VARCHAR(10) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);

CREATE TABLE rota (
    row_id INT PRIMARY KEY,
    rota_id VARCHAR(10) NOT NULL,
    date DATE NOT NULL,
    shift_id VARCHAR(10) NOT NULL,
    staff_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (shift_id) REFERENCES shift(shift_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- staff table
ALTER TABLE staff 
ADD last_update DATETIME NOT NULL CONSTRAINT DF_staff_last_update DEFAULT (GETDATE());

-- items table
ALTER TABLE items 
ADD last_update DATETIME NOT NULL CONSTRAINT DF_items_last_update DEFAULT (GETDATE());

-- orders table
ALTER TABLE orders 
ADD last_update DATETIME NOT NULL CONSTRAINT DF_orders_last_update DEFAULT (GETDATE());

-- ingredients table
ALTER TABLE ingredients 
ADD last_update DATETIME NOT NULL CONSTRAINT DF_ingredients_last_update DEFAULT (GETDATE());

-- recipes table
ALTER TABLE recipes 
ADD last_update DATETIME NOT NULL CONSTRAINT DF_recipes_last_update DEFAULT (GETDATE());

-- inventory table
ALTER TABLE inventory 
ADD last_update DATETIME NOT NULL CONSTRAINT DF_inventory_last_update DEFAULT (GETDATE());

-- shift table
ALTER TABLE shift 
ADD last_update DATETIME NOT NULL CONSTRAINT DF_shift_last_update DEFAULT (GETDATE());

-- rota table
ALTER TABLE rota 
ADD last_update DATETIME NOT NULL CONSTRAINT DF_rota_last_update DEFAULT (GETDATE());
