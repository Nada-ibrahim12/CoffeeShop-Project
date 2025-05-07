create database CoffeeShop;

use  CoffeeShop;

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
 select * from staff;
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


-- records of items table --
INSERT INTO items VALUES
('It001','HDR-CAP-MD','Cappuccino','Hot Drinks','Medium',3.45),
('It002','HDR-CAP-LG','Cappuccino','Hot Drinks','Large',3.75),
('It003','HDR-LAT-MD','Latte','Hot Drinks','Medium',3.45),
('It004','HDR-LAT-LG','Latte','Hot Drinks','Large',3.75),
('It005','HDR-FLT','Flat White','Hot Drinks','N/A',3.15),
('It006','HDR-CRM-MD','Caramel Macchiato','Hot Drinks','Medium',4.20),
('It007','HDR-CRM-LG','Caramel Macchiato','Hot Drinks','Large',4.60),
('It008','HDR-ESP','Espresso','Hot Drinks','N/A',2.15),
('It009','HDR-MOC-MD','Mocha','Hot Drinks','Medium',4.00),
('It010','HDR-MOC-LG','Mocha','Hot Drinks','Large',4.60),
('It011','HDR-WMO-MD','White Mocha','Hot Drinks','Medium',4.50),
('It012','HDR-WMO-LG','White Mocha','Hot Drinks','Large',4.70),
('It013','HDR-HCH-MD','Hot Chocolate','Hot Drinks','Medium',4.20),
('It014','HDR-HCH-LG','Hot Chocolate','Hot Drinks','Large',4.60),
('It015','CDR-CCF-MD','Cold Coffee','Cold Drinks','Medium',3.45),
('It016','CDR-CCF-LG','Cold Coffee','Cold Drinks','Large',3.75),
('It017','CDR-CMO-MD','Cold Mocha','Cold Drinks','Medium',4.00),
('It018','CDR-CMO-LG','Cold Mocha','Cold Drinks','Large',4.60),
('It019','CDR-ICT-MD','Iced Tea','Cold Drinks','Medium',3.25),
('It020','CDR-ICT-LG','Iced Tea','Cold Drinks','Large',3.55),
('It021','CDR-LMN-MD','Lemonade','Cold Drinks','Medium',3.35),
('It022','CDR-LMN-LG','Lemonade','Cold Drinks','Large',3.75),
('It023','SNK-SHC','Sandwich Ham&Cheese','Snacks','N/A',5.60),
('It024','SNK-SSM','Sandwich Salami&Mozzarella','Snacks','N/A',5.50);


-- records of ingredients table --
INSERT INTO ingredients VALUES
('ING001','Espresso beans',1000,'grams',12.00),
('ING002','Whole Milk',1000,'ml',1.20),
('ING003','Cheddar',500,'grams',7.45),
('ING004','Mozzarella',500,'grams',5.00),
('ING005','Whipped cream',300,'ml',1.35),
('ING006','Vanilla syrup',1000,'ml',14.52),
('ING007','Barista chocolate syrup',1000,'ml',8.49),
('ING008','Barista white chocolate syrup',1000,'ml',8.49),
('ING009','Barista caramel sauce',1000,'ml',8.49),
('ING010','Sugar',1000,'grams',1.50),
('ING011','Panini Bread',4,'units',1.35),
('ING012','Cocoa powder',1000,'grams',22.00),
('ING013','Chocolate',1000,'grams',10.50),
('ING014','Lemons',5,'units',1.50),
('ING015','Ham',1000,'grams',27.50),
('ING016','Salami',1000,'grams',15.49),
('ING017','Black Tea',1000,'grams',16.00),
('ING018','Vanilla extract',60,'ml',9.99);


-- records of recipes table --
INSERT INTO recipes VALUES
(1,'HDR-CAP-MD','ING001',8),
(2,'HDR-CAP-MD','ING002',130),
(3,'HDR-CAP-LG','ING001',10),
(4,'HDR-CAP-LG','ING002',180),
(5,'HDR-LAT-MD','ING001',8),
(6,'HDR-LAT-MD','ING002',130),
(7,'HDR-LAT-LG','ING001',10),
(8,'HDR-LAT-LG','ING002',180),
(9,'HDR-FLT','ING001',8),
(10,'HDR-FLT','ING002',160),
(11,'HDR-CRM-MD','ING001',8),
(12,'HDR-CRM-MD','ING002',120),
(13,'HDR-CRM-MD','ING009',20),
(14,'HDR-CRM-LG','ING001',10),
(15,'HDR-CRM-LG','ING002',160),
(16,'HDR-CRM-LG','ING009',30),
(17,'HDR-ESP','ING001',8),
(18,'HDR-MOC-MD','ING001',8),
(19,'HDR-MOC-MD','ING002',120),
(20,'HDR-MOC-MD','ING007',20),
(21,'HDR-MOC-LG','ING001',10),
(22,'HDR-MOC-LG','ING002',160),
(23,'HDR-MOC-LG','ING007',30),
(24,'HDR-WMO-MD','ING001',8),
(25,'HDR-WMO-MD','ING002',120),
(26,'HDR-WMO-MD','ING008',20),
(27,'HDR-WMO-LG','ING001',10),
(28,'HDR-WMO-LG','ING002',160),
(29,'HDR-WMO-LG','ING008',30),
(30,'HDR-HCH-MD','ING002',130),
(31,'HDR-HCH-MD','ING012',25),
(32,'HDR-HCH-MD','ING013',20),
(33,'HDR-HCH-MD','ING005',30),
(34,'HDR-HCH-LG','ING002',180),
(35,'HDR-HCH-LG','ING012',35),
(36,'HDR-HCH-LG','ING013',30),
(37,'HDR-HCH-LG','ING005',40),
(38,'CDR-CCF-MD','ING001',8),
(39,'CDR-CCF-MD','ING002',130),
(40,'CDR-CCF-LG','ING001',10),
(41,'CDR-CCF-LG','ING002',180),
(42,'CDR-CMO-MD','ING001',8),
(43,'CDR-CMO-MD','ING002',120),
(44,'CDR-CMO-MD','ING007',20),
(45,'CDR-CMO-LG','ING001',10),
(46,'CDR-CMO-LG','ING002',160),
(47,'CDR-CMO-LG','ING007',30),
(48,'CDR-ICT-MD','ING017',10),
(49,'CDR-ICT-MD','ING010',20),
(50,'CDR-ICT-LG','ING016',15),
(51,'CDR-ICT-LG','ING010',25),
(52,'CDR-LMN-MD','ING014',1),
(53,'CDR-LMN-MD','ING010',30),
(54,'CDR-LMN-LG','ING014',1),
(55,'CDR-LMN-LG','ING010',40),
(56,'SNK-SHC','ING011',1),
(57,'SNK-SHC','ING015',50),
(58,'SNK-SHC','ING003',20),
(59,'SNK-SSM','ING011',1),
(60,'SNK-SSM','ING016',50),
(61,'SNK-SSM','ING004',20);


-- records of inventory table --
INSERT INTO inventory VALUES
('inv001','ING001',4),
('inv002','ING002',55),
('inv003','ING003',1),
('inv004','ING004',4),
('inv005','ING005',7),
('inv006','ING006',3),
('inv007','ING007',3),
('inv008','ING008',4),
('inv009','ING009',1),
('inv010','ING010',4),
('inv011','ING011',20),
('inv012','ING012',5),
('inv013','ING013',2),
('inv014','ING014',10),
('inv015','ING015',3),
('inv016','ING016',2),
('inv017','ING017',2),
('inv018','ING018',2);


-- records of staff table --
INSERT INTO staff VALUES
('ST001','Emma','Johnson','Barista',10.00),
('ST002','Liam','Smith','Barista',10.00),
('ST003','Olivia','Williams','Barista',10.00),
('ST004','Noah','Brown','Barista',10.00);


-- records of shift table --
INSERT INTO shift VALUES
('SH001','Monday','07:00:00','13:00:00'),
('SH002','Monday','13:00:00','17:00:00'),
('SH003','Tuesday','07:00:00','13:00:00'),
('SH004','Tuesday','13:00:00','17:00:00'),
('SH005','Wednesday','07:00:00','13:00:00'),
('SH006','Wednesday','13:00:00','17:00:00'),
('SH007','Thursday','07:00:00','13:00:00'),
('SH008','Thursday','13:00:00','17:00:00'),
('SH009','Friday','07:00:00','13:00:00'),
('SH010','Friday','13:00:00','17:00:00'),
('SH011','Saturday','07:00:00','13:00:00'),
('SH012','Saturday','13:00:00','17:00:00');

INSERT INTO rota VALUES
(1,'RT001','2024-02-12','SH001','ST001'),
(2,'RT001','2024-02-12','SH001','ST003'),
(3,'RT001','2024-02-12','SH002','ST001'),
(4,'RT002','2024-02-13','SH003','ST002'),
(5,'RT002','2024-02-13','SH003','ST004'),
(6,'RT002','2024-02-13','SH004','ST002'),
(7,'RT003','2024-02-14','SH005','ST001'),
(8,'RT003','2024-02-14','SH005','ST003'),
(9,'RT003','2024-02-14','SH006','ST003'),
(10,'RT004','2024-02-15','SH007','ST002'),
(11,'RT004','2024-02-15','SH007','ST004'),
(12,'RT004','2024-02-15','SH008','ST004'),
(13,'RT005','2024-02-16','SH009','ST001'),
(14,'RT005','2024-02-16','SH009','ST002'),
(15,'RT005','2024-02-16','SH010','ST002'),
(16,'RT006','2024-02-17','SH011','ST003'),
(17,'RT006','2024-02-17','SH011','ST004'),
(18,'RT006','2024-02-17','SH012','ST004');


INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out) VALUES
(1, 'ORD001', '2024-02-12 07:04:00', 'It008', 1, 'Alex', 'out'),
(2, 'ORD002', '2024-02-12 07:09:00', 'It014', 1, 'Jordan', 'in'),
(3, 'ORD003', '2024-02-12 07:14:00', 'It008', 1, 'Taylor', 'out'),
(4, 'ORD004', '2024-02-12 07:18:00', 'It019', 1, 'Casey', 'out'),
(5, 'ORD005', '2024-02-12 07:23:00', 'It024', 1, 'Jamie', 'out'),
(6, 'ORD006', '2024-02-12 07:28:00', 'It001', 1, 'Morgan', 'in'),
(7, 'ORD006', '2024-02-12 07:28:00', 'It016', 1, 'Morgan', 'in'),
(8, 'ORD007', '2024-02-12 07:33:00', 'It005', 1, 'Riley', 'out');

INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out) VALUES
(9, 'ORD007', '2024-02-12 07:33:00', 'It020', 1, 'Riley', NULL),
(10, 'ORD008', '2024-02-12 07:39:00', 'It006', 1, 'Cameron', 'in'),
(11, 'ORD008', '2024-02-12 07:39:00', 'It018', 1, 'Cameron', NULL),
(12, 'ORD009', '2024-02-12 07:44:00', 'It023', 1, 'Quinn', 'out'),
(13, 'ORD009', '2024-02-12 07:44:00', 'It011', 1, 'Quinn', NULL),
(14, 'ORD010', '2024-02-12 07:49:00', 'It024', 1, 'Peyton', 'out'),
(15, 'ORD010', '2024-02-12 07:49:00', 'It014', 1, 'Peyton', NULL),
(16, 'ORD011', '2024-02-12 07:53:00', 'It003', 1, 'Brooke', 'out'),
(17, 'ORD012', '2024-02-12 07:58:00', 'It007', 1, 'Blake', 'out'),
(18, 'ORD013', '2024-02-12 08:03:00', 'It009', 1, 'Charlie', 'in'),
(19, 'ORD013', '2024-02-12 08:03:00', 'It021', 1, 'Charlie', NULL),
(20, 'ORD014', '2024-02-12 08:08:00', 'It012', 1, 'Dakota', 'in'),
(21, 'ORD014', '2024-02-12 08:08:00', 'It022', 1, 'Dakota', NULL),
(22, 'ORD015', '2024-02-12 08:12:00', 'It004', 1, 'Emerson', 'out'),
(23, 'ORD016', '2024-02-12 08:17:00', 'It002', 1, 'Finley', 'out'),
(24, 'ORD017', '2024-02-12 08:22:00', 'It001', 1, 'Harper', 'in'),
(25, 'ORD018', '2024-02-12 08:26:00', 'It014', 1, 'Jordan', 'out'),
(26, 'ORD019', '2024-02-12 08:31:00', 'It011', 1, 'Kendall', 'in'),
(27, 'ORD020', '2024-02-12 08:36:00', 'It017', 1, 'Logan', 'out'),
(28, 'ORD020', '2024-02-12 08:36:00', 'It020', 1, 'Logan', NULL),
(29, 'ORD021', '2024-02-12 08:41:00', 'It005', 1, 'Morgan', 'out'),
(30, 'ORD022', '2024-02-12 08:45:00', 'It006', 1, 'Parker', 'in'),
(31, 'ORD022', '2024-02-12 08:45:00', 'It014', 1, 'Peyton', NULL),
(32, 'ORD023', '2024-02-12 08:50:00', 'It008', 1, 'Alex', 'out'),
(33, 'ORD024', '2024-02-12 08:55:00', 'It016', 1, 'Jordan', 'out'),
(34, 'ORD025', '2024-02-12 09:00:00', 'It006', 1, 'Taylor', 'out'),
(35, 'ORD026', '2024-02-12 09:04:00', 'It019', 1, 'Casey', 'in'),
(36, 'ORD027', '2024-02-12 09:09:00', 'It009', 1, 'Jamie', 'out'),
(37, 'ORD028', '2024-02-12 09:14:00', 'It001', 1, 'Morgan', 'in'),
(38, 'ORD028', '2024-02-12 09:14:00', 'It016', 1, 'Morgan', NULL),
(39, 'ORD029', '2024-02-12 09:19:00', 'It005', 1, 'Riley', 'in'),
(40, 'ORD029', '2024-02-12 09:19:00', 'It020', 1, 'Riley', NULL),
(41, 'ORD029', '2024-02-12 09:19:00', 'It012', 1, 'Riley', NULL),
(42, 'ORD030', '2024-02-12 09:35:00', 'It004', 1, 'Jordan', 'out'),
(43, 'ORD031', '2024-02-12 09:48:00', 'It021', 1, 'Harper', 'out'),
(44, 'ORD032', '2024-02-12 10:02:00', 'It007', 1, 'Casey', 'out'),
(45, 'ORD033', '2024-02-12 10:17:00', 'It010', 1, 'Riley', 'out'),
(46, 'ORD034', '2024-02-12 10:33:00', 'It017', 1, 'Alex', 'in'),
(47, 'ORD035', '2024-02-12 10:50:00', 'It009', 1, 'Jamie', 'out'),
(48, 'ORD036', '2024-02-12 11:08:00', 'It018', 1, 'Taylor', 'out'),
(49, 'ORD037', '2024-02-12 11:27:00', 'It005', 1, 'Quinn', 'in'),
(50, 'ORD037', '2024-02-12 11:27:00', 'It002', 1, 'Quinn', NULL),
(51, 'ORD038', '2024-02-12 12:08:00', 'It015', 1, 'Peyton', 'in'),
(52, 'ORD038', '2024-02-12 12:08:00', 'It003', 1, 'Peyton', NULL),
(53, 'ORD038', '2024-02-12 12:08:00', 'It016', 1, 'Peyton', NULL),
(54, 'ORD039', '2024-02-12 12:10:00', 'It005', 1, 'Riley', 'out'),
(55, 'ORD039', '2024-02-12 12:10:00', 'It020', 1, 'Riley', NULL),
(56, 'ORD040', '2024-02-12 12:11:00', 'It006', 1, 'Cameron', 'out'),
(57, 'ORD040', '2024-02-12 12:11:00', 'It018', 1, 'Cameron', NULL),
(58, 'ORD041', '2024-02-12 12:16:00', 'It023', 1, 'Quinn', 'in'),
(59, 'ORD041', '2024-02-12 12:16:00', 'It011', 1, 'Quinn', NULL),
(60, 'ORD041', '2024-02-12 12:16:00', 'It011', 1, 'Quinn', NULL),
(61, 'ORD042', '2024-02-12 12:18:00', 'It004', 1, 'Taylor', 'out'),
(62, 'ORD043', '2024-02-12 12:21:00', 'It022', 1, 'Jamie', 'out'),
(63, 'ORD044', '2024-02-12 12:23:00', 'It018', 1, 'Riley', 'out'),
(64, 'ORD045', '2024-02-12 12:26:00', 'It017', 1, 'Alex', 'in'),
(65, 'ORD046', '2024-02-12 12:29:00', 'It009', 1, 'Casey', 'out'),
(66, 'ORD047', '2024-02-12 12:32:00', 'It009', 1, 'Brooke', 'out'),
(67, 'ORD048', '2024-02-12 12:35:00', 'It012', 1, 'Jordan', 'out'),
(68, 'ORD049', '2024-02-12 12:38:00', 'It005', 1, 'Peyton', 'in'),
(69, 'ORD050', '2024-02-12 12:41:00', 'It019', 1, 'Morgan', 'out'),
(70, 'ORD051', '2024-02-12 12:44:00', 'It020', 1, 'Harper', 'in'),
(71, 'ORD052', '2024-02-12 12:47:00', 'It021', 1, 'Cameron', 'out'),
(72, 'ORD053', '2024-02-12 12:50:00', 'It014', 1, 'Avery', 'in'),
(73, 'ORD054', '2024-02-12 12:53:00', 'It016', 1, 'Quinn', 'out'),
(74, 'ORD055', '2024-02-12 12:56:00', 'It023', 1, 'Taylor', 'out'),
(75, 'ORD056', '2024-02-12 12:59:00', 'It020', 1, 'Jamie', 'out'),
(76, 'ORD057', '2024-02-12 13:02:00', 'It013', 1, 'Riley', 'in'),
(77, 'ORD058', '2024-02-12 13:05:00', 'It001', 1, 'Alex', 'out'),
(78, 'ORD059', '2024-02-12 13:08:00', 'It003', 1, 'Casey', 'in'),
(79, 'ORD060', '2024-02-12 13:11:00', 'It008', 1, 'Brooke', 'out'),
(80, 'ORD061', '2024-02-12 13:13:00', 'It002', 1, 'Harper', 'in'),
(81, 'ORD061', '2024-02-12 13:13:00', 'It007', 1, 'Harper', NULL),
(82, 'ORD062', '2024-02-12 13:15:00', 'It019', 1, 'Jordan', 'out'),
(83, 'ORD063', '2024-02-12 13:17:00', 'It021', 1, 'Avery', 'out'),
(84, 'ORD063', '2024-02-12 13:17:00', 'It005', 1, 'Avery', NULL),
(85, 'ORD063', '2024-02-12 13:17:00', 'It014', 1, 'Avery', NULL),
(86, 'ORD064', '2024-02-12 13:20:00', 'It004', 1, 'Casey', 'in'),
(87, 'ORD064', '2024-02-12 13:20:00', 'It003', 1, 'Casey', NULL),
(88, 'ORD065', '2024-02-12 13:22:00', 'It012', 1, 'Taylor', 'out'),
(89, 'ORD065', '2024-02-12 13:22:00', 'It009', 1, 'Taylor', NULL),
(90, 'ORD066', '2024-02-12 13:25:00', 'It018', 1, 'Riley', 'out'),
(91, 'ORD066', '2024-02-12 13:25:00', 'It022', 1, 'Riley', NULL),
(92, 'ORD067', '2024-02-12 13:27:00', 'It011', 1, 'Jamie', 'out'),
(93, 'ORD067', '2024-02-12 13:27:00', 'It015', 1, 'Jamie', NULL),
(94, 'ORD068', '2024-02-12 13:30:00', 'It006', 1, 'Morgan', 'out'),
(95, 'ORD068', '2024-02-12 13:30:00', 'It022', 1, 'Morgan', NULL),
(96, 'ORD069', '2024-02-12 13:32:00', 'It010', 1, 'Quinn', 'out'),
(97, 'ORD069', '2024-02-12 13:32:00', 'It024', 1, 'Quinn', NULL),
(98, 'ORD070', '2024-02-12 13:35:00', 'It001', 1, 'Peyton', 'in'),
(99, 'ORD070', '2024-02-12 13:35:00', 'It017', 1, 'Peyton', NULL),
(100, 'ORD078', '2024-02-12 13:55:00', 'It020', 1, 'Alex', 'out'),
(101, 'ORD079', '2024-02-12 14:05:00', 'It021', 1, 'Harper', 'in'),
(102, 'ORD080', '2024-02-12 14:17:00', 'It004', 1, 'Taylor', 'out'),
(103, 'ORD080', '2024-02-12 14:17:00', 'It013', 1, 'Taylor', NULL),
(104, 'ORD081', '2024-02-12 14:30:00', 'It018', 1, 'Jordan', 'in'),
(105, 'ORD082', '2024-02-12 14:45:00', 'It007', 1, 'Casey', 'in'),
(106, 'ORD082', '2024-02-12 14:45:00', 'It011', 1, 'Casey', NULL),
(107, 'ORD083', '2024-02-12 15:00:00', 'It013', 1, 'Riley', 'out'),
(108, 'ORD084', '2024-02-12 15:20:00', 'It009', 1, 'Jamie', 'in'),
(109, 'ORD084', '2024-02-12 15:20:00', 'It003', 1, 'Jamie', NULL);


INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out) VALUES
(110, 'ORD085', '2024-02-12 15:40:00', 'It014', 1, 'Morgan', 'out'),
(111, 'ORD085', '2024-02-12 15:40:00', 'It022', 1, 'Morgan', NULL),
(112, 'ORD086', '2024-02-12 16:00:00', 'It005', 1, 'Brooke', 'out'),
(113, 'ORD087', '2024-02-12 16:25:00', 'It017', 1, 'Avery', 'out');

INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out) VALUES
(114, 'ORD088', '2024-02-12 16:50:00', 'It012', 1, 'Quinn', 'out');

INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out) VALUES
(115, 'ORD089', '2024-02-12 17:00:00', 'It001', 1, 'Sam', 'out'),
(116, 'ORD090', '2024-02-13 07:14:00', 'It002', 1, 'Anna', 'out'),
(117, 'ORD091', '2024-02-13 07:19:00', 'It004', 1, 'Chris', 'in');

INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out) VALUES
(119, 'ORD092', '2024-02-13 07:24:00', 'It017', 1, 'Pat', 'out');

INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out) VALUES
(120, 'ORD093', '2024-02-13 07:30:00', 'It023', 1, 'Alex', 'in'),
(121, 'ORD093', '2024-02-13 07:30:00', 'It011', 1, 'Alex', NULL),
(122, 'ORD094', '2024-02-13 07:35:00', 'It006', 1, 'Jordan', 'out'),
(123, 'ORD095', '2024-02-13 07:40:00', 'It021', 1, 'Taylor', 'in'),
(124, 'ORD096', '2024-02-13 07:45:00', 'It015', 1, 'Casey', 'out'),
(125, 'ORD097', '2024-02-13 07:50:00', 'It008', 1, 'Jamie', 'in'),
(126, 'ORD097', '2024-02-13 07:50:00', 'It024', 1, 'Jamie', NULL),
(127, 'ORD098', '2024-02-13 07:56:00', 'It001', 1, 'Morgan', 'out'),
(128, 'ORD099', '2024-02-13 08:01:00', 'It019', 1, 'Riley', 'in'),
(129, 'ORD100', '2024-02-13 08:06:00', 'It003', 1, 'Cameron', 'out'),
(131, 'ORD101', '2024-02-13 08:11:00', 'It022', 1, 'Quinn', 'in'),
(132, 'ORD102', '2024-02-13 08:17:00', 'It018', 1, 'Peyton', 'out'),
(133, 'ORD103', '2024-02-13 08:22:00', 'It005', 1, 'Brooke', 'in'),
(134, 'ORD103', '2024-02-13 08:22:00', 'It012', 1, 'Brooke', NULL),
(135, 'ORD104', '2024-02-13 08:27:00', 'It010', 1, 'Sam', 'out'),
(136, 'ORD105', '2024-02-13 08:32:00', 'It007', 1, 'Alex', 'in'),
(138, 'ORD106', '2024-02-13 08:38:00', 'It020', 1, 'Pat', NULL),
(139, 'ORD107', '2024-02-13 08:43:00', 'It014', 1, 'Chris', 'in'),
(140, 'ORD108', '2024-02-13 08:48:00', 'It009', 1, 'Jordan', 'out'),
(141, 'ORD109', '2024-02-13 08:53:00', 'It002', 1, 'Taylor', 'in'),
(142, 'ORD109', '2024-02-13 08:53:00', 'It016', 1, 'Taylor', NULL),
(143, 'ORD110', '2024-02-13 08:58:00', 'It013', 1, 'Casey', 'out'),
(145, 'ORD112', '2024-02-13 09:09:00', 'It004', 1, 'Morgan', 'out'),
(146, 'ORD113', '2024-02-13 09:14:00', 'It021', 1, 'Riley', 'in'),
(147, 'ORD114', '2024-02-13 09:19:00', 'It006', 1, 'Cameron', 'out'),
(148, 'ORD115', '2024-02-13 09:25:00', 'It019', 1, 'Quinn', 'in'),
(149, 'ORD116', '2024-02-13 09:30:00', 'It003', 1, 'Peyton', 'out'),
(150, 'ORD117', '2024-02-13 09:35:00', 'It022', 1, 'Brooke', 'in');

INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out) VALUES
(151, 'ORD117', '2024-02-13 09:35:00', 'It012', 1, 'Brooke', NULL),
(152, 'ORD118', '2024-02-13 09:40:00', 'It018', 1, 'Sam', 'out'),
(153, 'ORD119', '2024-02-13 09:46:00', 'It005', 1, 'Alex', 'in'),
(155, 'ORD121', '2024-02-13 09:56:00', 'It014', 1, 'Chris', 'in'),
(156, 'ORD122', '2024-02-13 10:01:00', 'It009', 1, 'Jordan', 'out'),
(158, 'ORD124', '2024-02-13 10:31:00', 'It005', 1, 'Casey', 'out'),
(159, 'ORD125', '2024-02-13 10:45:00', 'It014', 1, 'Riley', 'in'),
(160, 'ORD125', '2024-02-13 10:45:00', 'It023', 1, 'Riley', NULL),
(161, 'ORD126', '2024-02-13 11:00:00', 'It018', 1, 'Jamie', 'out'),
(162, 'ORD127', '2024-02-13 11:15:00', 'It002', 1, 'Alex', 'in'),
(163, 'ORD128', '2024-02-13 11:29:00', 'It011', 1, 'Sam', 'out'),
(165, 'ORD129', '2024-02-13 11:43:00', 'It020', 1, 'Quinn', NULL),
(166, 'ORD130', '2024-02-13 11:57:00', 'It008', 1, 'Pat', 'out'),
(167, 'ORD131', '2024-02-13 12:03:00', 'It022', 1, 'Chris', 'in'),
(168, 'ORD132', '2024-02-13 12:10:00', 'It004', 1, 'Alex', 'out'),
(169, 'ORD133', '2024-02-13 12:17:00', 'It015', 1, 'Jordan', 'in'),
(171, 'ORD134', '2024-02-13 12:24:00', 'It018', 1, 'Morgan', NULL),
(172, 'ORD135', '2024-02-13 12:31:00', 'It007', 1, 'Taylor', 'in'),
(173, 'ORD136', '2024-02-13 12:38:00', 'It020', 1, 'Casey', 'out'),
(174, 'ORD137', '2024-02-13 12:45:00', 'It003', 1, 'Jamie', 'in'),
(175, 'ORD138', '2024-02-13 12:52:00', 'It016', 1, 'Riley', 'out'),
(176, 'ORD139', '2024-02-13 12:59:00', 'It009', 1, 'Cameron', 'in'),
(178, 'ORD140', '2024-02-13 13:06:00', 'It012', 1, 'Quinn', 'out'),
(179, 'ORD141', '2024-02-13 13:13:00', 'It001', 1, 'Peyton', 'in'),
(180, 'ORD142', '2024-02-13 13:20:00', 'It019', 1, 'Brooke', 'out'),
(181, 'ORD143', '2024-02-13 13:27:00', 'It005', 1, 'Sam', 'in'),
(182, 'ORD143', '2024-02-13 13:27:00', 'It011', 1, 'Sam', NULL),
(184, 'ORD145', '2024-02-13 13:41:00', 'It010', 1, 'Alex', 'in'),
(185, 'ORD146', '2024-02-13 13:48:00', 'It024', 1, 'Chris', 'out'),
(186, 'ORD147', '2024-02-13 13:55:00', 'It017', 1, 'Jordan', 'in'),
(187, 'ORD147', '2024-02-13 13:55:00', 'It021', 1, 'Jordan', NULL),
(188, 'ORD148', '2024-02-13 14:03:00', 'It006', 1, 'Morgan', 'out'),
(189, 'ORD149', '2024-02-13 14:10:00', 'It023', 1, 'Taylor', 'in'),
(190, 'ORD150', '2024-02-13 14:30:00', 'It002', 1, 'Jordan', 'out'),
(191, 'ORD151', '2024-02-13 14:50:00', 'It018', 1, 'Chris', 'in'),
(192, 'ORD152', '2024-02-13 15:10:00', 'It005', 1, 'Alex', 'out'),
(194, 'ORD154', '2024-02-13 15:50:00', 'It011', 1, 'Taylor', 'out'),
(195, 'ORD155', '2024-02-13 16:09:00', 'It004', 1, 'Casey', 'in'),
(197, 'ORD156', '2024-02-13 16:29:00', 'It014', 1, 'Jamie', 'out'),
(198, 'ORD157', '2024-02-13 16:49:00', 'It021', 1, 'Riley', 'in'),
(199, 'ORD158', '2024-02-13 17:00:00', 'It007', 1, 'Cameron', 'out'),
(200, 'ORD159', '2024-02-14 07:06:00', 'It001', 1, 'Elvis', 'out'),
(201, 'ORD160', '2024-02-14 07:13:00', 'It014', 1, 'Jordan', 'in'),
(203, 'ORD162', '2024-02-14 07:27:00', 'It008', 1, 'Alex', 'in'),
(204, 'ORD162', '2024-02-14 07:27:00', 'It022', 1, 'Alex', NULL),
(205, 'ORD163', '2024-02-14 07:34:00', 'It017', 1, 'Morgan', 'out'),
(206, 'ORD164', '2024-02-14 07:41:00', 'It005', 1, 'Taylor', 'in'),
(207, 'ORD165', '2024-02-14 07:49:00', 'It023', 1, 'Casey', 'out'),
(208, 'ORD166', '2024-02-14 07:56:00', 'It011', 1, 'Jamie', 'in'),
(209, 'ORD167', '2024-02-14 08:03:00', 'It019', 1, 'Riley', 'out'),
(210, 'ORD168', '2024-02-14 08:10:00', 'It003', 1, 'Cameron', 'in'),
(212, 'ORD170', '2024-02-14 08:24:00', 'It006', 1, 'Peyton', 'in'),
(213, 'ORD171', '2024-02-14 08:31:00', 'It020', 1, 'Brooke', 'out'),
(214, 'ORD172', '2024-02-14 08:38:00', 'It010', 1, 'Sam', 'in'),
(216, 'ORD173', '2024-02-14 08:45:00', 'It007', 1, 'Pat', NULL),
(217, 'ORD174', '2024-02-14 08:53:00', 'It013', 1, 'Alex', 'in'),
(219, 'ORD176', '2024-02-14 09:07:00', 'It004', 1, 'Chris', 'in'),
(220, 'ORD177', '2024-02-14 09:14:00', 'It016', 1, 'Morgan', 'out'),
(221, 'ORD178', '2024-02-14 09:21:00', 'It024', 1, 'Taylor', 'in'),
(222, 'ORD179', '2024-02-14 09:28:00', 'It012', 1, 'Casey', 'out'),
(223, 'ORD180', '2024-02-14 09:35:00', 'It009', 1, 'Jamie', 'in');

INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out) VALUES
(224, 'ORD181', '2024-02-14 09:42:00', 'It002', 1, 'Riley', 'out'),
(225, 'ORD182', '2024-02-14 09:49:00', 'It018', 1, 'Cameron', 'in'),
(226, 'ORD183', '2024-02-14 09:57:00', 'It021', 1, 'Quinn', 'out'),
(227, 'ORD184', '2024-02-14 10:04:00', 'It015', 1, 'Brooke', 'in'),
(228, 'ORD185', '2024-02-14 10:21:00', 'It007', 1, 'Sam', 'out'),
(230, 'ORD187', '2024-02-14 10:55:00', 'It001', 1, 'Alex', 'out'),
(231, 'ORD188', '2024-02-14 11:12:00', 'It024', 1, 'Jordan', 'in'),
(232, 'ORD189', '2024-02-14 11:29:00', 'It018', 1, 'Chris', 'out'),
(233, 'ORD189', '2024-02-14 11:29:00', 'It022', 1, 'Chris', NULL),
(234, 'ORD190', '2024-02-14 11:46:00', 'It012', 1, 'Morgan', 'in'),
(235, 'ORD191', '2024-02-14 12:03:00', 'It003', 1, 'Taylor', 'out'),
(236, 'ORD192', '2024-02-14 12:10:00', 'It016', 1, 'Casey', 'in'),
(237, 'ORD193', '2024-02-14 12:17:00', 'It009', 1, 'Jamie', 'out'),
(239, 'ORD195', '2024-02-14 12:31:00', 'It005', 1, 'Cameron', 'out'),
(240, 'ORD195', '2024-02-14 12:31:00', 'It011', 1, 'Cameron', NULL),
(241, 'ORD196', '2024-02-14 12:38:00', 'It014', 1, 'Quinn', 'in');

INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out) VALUES
(242, 'ORD197', '2024-02-14 12:45:00', 'It020', 1, 'Peyton', 'out'),
(243, 'ORD198', '2024-02-14 12:52:00', 'It006', 1, 'Brooke', 'in'),
(244, 'ORD199', '2024-02-14 13:00:00', 'It022', 1, 'Sam', 'out'),
(245, 'ORD200', '2024-02-14 13:08:00', 'It017', 1, 'Pat', 'in'),
(246, 'ORD201', '2024-02-14 13:15:00', 'It010', 1, 'Alex', 'out'),
(247, 'ORD202', '2024-02-14 13:22:00', 'It024', 1, 'Jordan', 'in'),
(248, 'ORD202', '2024-02-14 13:22:00', 'It008', 1, 'Jordan', NULL),
(249, 'ORD203', '2024-02-14 13:29:00', 'It001', 1, 'Chris', 'out'),
(250, 'ORD204', '2024-02-14 13:36:00', 'It019', 1, 'Morgan', 'in'),
(251, 'ORD205', '2024-02-14 13:43:00', 'It013', 1, 'Taylor', 'out'),
(253, 'ORD207', '2024-02-14 13:57:00', 'It004', 1, 'Jamie', 'out'),
(254, 'ORD208', '2024-02-14 14:05:00', 'It021', 1, 'Riley', 'in'),
(255, 'ORD208', '2024-02-14 14:05:00', 'It002', 1, 'Riley', NULL),
(256, 'ORD209', '2024-02-14 14:12:00', 'It018', 1, 'Cameron', 'out'),
(258, 'ORD211', '2024-02-14 14:26:00', 'It007', 1, 'Peyton', 'out'),
(259, 'ORD212', '2024-02-14 14:33:00', 'It012', 1, 'Brooke', 'in'),
(261, 'ORD214', '2024-02-14 14:47:00', 'It015', 1, 'Pat', 'in'),
(262, 'ORD215', '2024-02-14 15:04:00', 'It002', 1, 'Alex', 'out'),
(263, 'ORD216', '2024-02-14 15:22:00', 'It024', 1, 'Jordan', 'in'),
(264, 'ORD217', '2024-02-14 15:41:00', 'It018', 1, 'Chris', 'out'),
(265, 'ORD218', '2024-02-14 15:59:00', 'It011', 1, 'Morgan', 'in'),
(266, 'ORD219', '2024-02-14 16:17:00', 'It005', 1, 'Taylor', 'out'),
(267, 'ORD220', '2024-02-14 16:35:00', 'It017', 1, 'Casey', 'in'),
(268, 'ORD221', '2024-02-14 16:53:00', 'It009', 1, 'Jamie', 'out'),
(270, 'ORD223', '2024-02-15 07:02:00', 'It003', 1, 'Anna', 'out'),
(271, 'ORD224', '2024-02-15 07:09:00', 'It017', 1, 'Bob', 'in'),
(272, 'ORD224', '2024-02-15 07:09:00', 'It021', 1, 'Bob', NULL),
(273, 'ORD225', '2024-02-15 07:16:00', 'It006', 1, 'Carol', 'out'),
(275, 'ORD227', '2024-02-15 07:30:00', 'It011', 1, 'Eve', 'out'),
(276, 'ORD227', '2024-02-15 07:30:00', 'It014', 1, 'Eve', NULL),
(277, 'ORD228', '2024-02-15 07:37:00', 'It001', 1, 'Frank', 'in'),
(278, 'ORD229', '2024-02-15 07:44:00', 'It019', 1, 'Grace', 'out'),
(279, 'ORD230', '2024-02-15 07:52:00', 'It024', 1, 'Helen', 'in'),
(280, 'ORD231', '2024-02-15 07:59:00', 'It005', 1, 'Ian', 'out'),
(281, 'ORD231', '2024-02-15 07:59:00', 'It008', 1, 'Ian', NULL),
(282, 'ORD232', '2024-02-15 08:06:00', 'It010', 1, 'Jenny', 'in'),
(283, 'ORD233', '2024-02-15 08:13:00', 'It013', 1, 'Kyle', 'out'),
(284, 'ORD234', '2024-02-15 08:20:00', 'It016', 1, 'Laura', 'in'),
(285, 'ORD234', '2024-02-15 08:20:00', 'It022', 1, 'Laura', NULL),
(287, 'ORD236', '2024-02-15 08:34:00', 'It007', 1, 'Nina', 'in'),
(288, 'ORD237', '2024-02-15 08:41:00', 'It018', 1, 'Oscar', 'out'),
(289, 'ORD238', '2024-02-15 08:48:00', 'It004', 1, 'Paula', 'in'),
(291, 'ORD239', '2024-02-15 08:56:00', 'It009', 1, 'Quinn', 'out'),
(292, 'ORD240', '2024-02-15 09:03:00', 'It002', 1, 'Rachel', 'in'),
(293, 'ORD241', '2024-02-15 09:10:00', 'It020', 1, 'Steve', 'out'),
(294, 'ORD242', '2024-02-15 09:17:00', 'It012', 1, 'Tina', 'in'),
(295, 'ORD243', '2024-02-15 09:24:00', 'It015', 1, 'Umar', 'out'),
(297, 'ORD244', '2024-02-15 09:31:00', 'It023', 1, 'Victor', 'in'),
(298, 'ORD245', '2024-02-15 09:38:00', 'It008', 1, 'Wendy', 'out'),
(299, 'ORD246', '2024-02-15 09:48:00', 'It012', 1, 'Alice', 'in'),
(300, 'ORD247', '2024-02-15 10:04:00', 'It021', 1, 'Bob', 'out'),
(301, 'ORD248', '2024-02-15 10:20:00', 'It004', 1, 'Charlie', 'in'),
(303, 'ORD250', '2024-02-15 10:52:00', 'It009', 1, 'Evan', 'in'),
(304, 'ORD251', '2024-02-15 11:08:00', 'It018', 1, 'Fiona', 'out'),
(305, 'ORD251', '2024-02-15 11:08:00', 'It022', 1, 'Fiona', NULL),
(306, 'ORD252', '2024-02-15 11:24:00', 'It006', 1, 'George', 'in'),
(307, 'ORD253', '2024-02-15 11:40:00', 'It016', 1, 'Hannah', 'out'),
(308, 'ORD254', '2024-02-15 11:56:00', 'It001', 1, 'Ian', 'in'),
(309, 'ORD255', '2024-02-15 12:06:00', 'It007', 1, 'Jake', 'out'),
(310, 'ORD256', '2024-02-15 12:12:00', 'It019', 1, 'Karen', 'in'),
(311, 'ORD256', '2024-02-15 12:12:00', 'It023', 1, 'Karen', NULL),
(312, 'ORD257', '2024-02-15 12:18:00', 'It002', 1, 'Leo', 'out'),
(313, 'ORD258', '2024-02-15 12:24:00', 'It015', 1, 'Mia', 'in'),
(314, 'ORD259', '2024-02-15 12:30:00', 'It010', 1, 'Noah', 'out'),
(316, 'ORD261', '2024-02-15 12:42:00', 'It005', 1, 'Paul', 'out'),
(317, 'ORD262', '2024-02-15 12:48:00', 'It013', 1, 'Quinn', 'in'),
(318, 'ORD263', '2024-02-15 12:54:00', 'It020', 1, 'Riley', 'out'),
(319, 'ORD263', '2024-02-15 12:54:00', 'It008', 1, 'Riley', NULL),
(320, 'ORD264', '2024-02-15 13:00:00', 'It024', 1, 'Sam', 'in'),
(321, 'ORD265', '2024-02-15 13:06:00', 'It011', 1, 'Tina', 'out'),
(322, 'ORD266', '2024-02-15 13:12:00', 'It017', 1, 'Umar', 'in'),
(323, 'ORD267', '2024-02-15 13:18:00', 'It003', 1, 'Victor', 'out'),
(324, 'ORD268', '2024-02-15 13:24:00', 'It014', 1, 'Wendy', 'in'),
(325, 'ORD269', '2024-02-15 13:30:00', 'It001', 1, 'Xavier', 'out'),
(326, 'ORD270', '2024-02-15 13:36:00', 'It009', 1, 'Yara', 'in'),
(327, 'ORD271', '2024-02-15 13:42:00', 'It018', 1, 'Zoe', 'out'),
(328, 'ORD272', '2024-02-15 13:48:00', 'It004', 1, 'Amy', 'in'),
(330, 'ORD273', '2024-02-15 13:54:00', 'It021', 1, 'Brad', 'out'),
(331, 'ORD274', '2024-02-15 14:00:00', 'It006', 1, 'Cindy', 'in'),
(332, 'ORD275', '2024-02-15 14:06:00', 'It022', 1, 'Derek', 'out'),
(333, 'ORD276', '2024-02-15 14:12:00', 'It012', 1, 'Eliza', 'in');

INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out) VALUES
(335, 'ORD278', '2024-02-15 14:24:00', 'It016', 1, 'Gigi', 'in'),
(337, 'ORD280', '2024-02-15 14:36:00', 'It008', 1, 'Ivy', 'in'),
(338, 'ORD281', '2024-02-15 14:52:00', 'It002', 1, 'Jake', 'out'),
(339, 'ORD282', '2024-02-15 15:08:00', 'It017', 1, 'Kara', 'in'),
(340, 'ORD340', '2024-02-16 13:56:00', 'It007', 1, 'Zack', 'out'),
(341, 'ORD341', '2024-02-16 14:03:00', 'It015', 1, 'Amelia', 'in'),
(342, 'ORD341', '2024-02-16 14:03:00', 'It024', 1, 'Amelia', NULL),
(343, 'ORD342', '2024-02-16 14:09:00', 'It002', 1, 'Brad', 'out'),
(344, 'ORD343', '2024-02-16 14:16:00', 'It021', 1, 'Cindy', 'in'),
(345, 'ORD344', '2024-02-16 14:22:00', 'It011', 1, 'Derek', 'out'),
(347, 'ORD346', '2024-02-16 14:35:00', 'It016', 1, 'Faisal', 'out'),
(348, 'ORD347', '2024-02-16 14:42:00', 'It005', 1, 'Georgia', 'in'),
(349, 'ORD348', '2024-02-16 14:48:00', 'It022', 1, 'Haris', 'out'),
(350, 'ORD349', '2024-02-16 14:55:00', 'It009', 1, 'Ida', 'in'),
(352, 'ORD351', '2024-02-16 15:08:00', 'It018', 1, 'Kurt', 'in'),
(353, 'ORD352', '2024-02-16 15:14:00', 'It003', 1, 'Lana', 'out'),
(354, 'ORD353', '2024-02-16 15:21:00', 'It014', 1, 'Moe', 'in'),
(355, 'ORD354', '2024-02-16 15:34:00', 'It022', 1, 'Ian', 'out'),
(356, 'ORD355', '2024-02-16 15:54:00', 'It009', 1, 'Jenna', 'in'),
(357, 'ORD356', '2024-02-16 16:14:00', 'It005', 1, 'Keith', 'out'),
(358, 'ORD357', '2024-02-16 16:34:00', 'It018', 1, 'Lila', 'in'),
(359, 'ORD358', '2024-02-16 16:54:00', 'It001', 1, 'Mason', 'out'),
(360, 'ORD359', '2024-02-16 17:00:00', 'It014', 1, 'Nora', 'in'),
(361, 'ORD360', '2024-02-17 07:03:00', 'It001', 1, 'Susie', 'in'),
(362, 'ORD361', '2024-02-17 07:08:00', 'It017', 1, 'Tom', 'out'),
(363, 'ORD361', '2024-02-17 07:08:00', 'It023', 1, 'Tom', NULL),
(364, 'ORD362', '2024-02-17 07:13:00', 'It004', 1, 'Ulla', 'in'),
(366, 'ORD363', '2024-02-17 07:18:00', 'It020', 1, 'Victor', NULL),
(367, 'ORD364', '2024-02-17 07:23:00', 'It009', 1, 'Wendy', 'in'),
(368, 'ORD365', '2024-02-17 07:28:00', 'It014', 1, 'Xavier', 'out'),
(369, 'ORD365', '2024-02-17 07:28:00', 'It007', 1, 'Xavier', NULL),
(370, 'ORD366', '2024-02-17 07:34:00', 'It022', 1, 'Yara', 'in'),
(371, 'ORD367', '2024-02-17 07:39:00', 'It005', 1, 'Zoe', 'out'),
(372, 'ORD368', '2024-02-17 07:44:00', 'It012', 1, 'Amy', 'in'),
(373, 'ORD368', '2024-02-17 07:44:00', 'It018', 1, 'Amy', NULL),
(375, 'ORD370', '2024-02-17 07:54:00', 'It003', 1, 'Cara', 'in'),
(376, 'ORD371', '2024-02-17 07:59:00', 'It016', 1, 'Dan', 'out'),
(377, 'ORD371', '2024-02-17 07:59:00', 'It008', 1, 'Dan', NULL),
(378, 'ORD372', '2024-02-17 08:04:00', 'It011', 1, 'Eve', 'in'),
(379, 'ORD373', '2024-02-17 08:10:00', 'It024', 1, 'Finn', 'out'),
(380, 'ORD374', '2024-02-17 08:15:00', 'It006', 1, 'Gia', 'in'),
(381, 'ORD374', '2024-02-17 08:15:00', 'It021', 1, 'Gia', NULL),
(382, 'ORD375', '2024-02-17 08:20:00', 'It010', 1, 'Hal', 'out'),
(384, 'ORD377', '2024-02-17 08:30:00', 'It013', 1, 'Jed', 'out'),
(385, 'ORD377', '2024-02-17 08:30:00', 'It019', 1, 'Jed', NULL),
(386, 'ORD378', '2024-02-17 08:35:00', 'It002', 1, 'Kip', 'in'),
(388, 'ORD380', '2024-02-17 08:45:00', 'It015', 1, 'Moe', 'in'),
(389, 'ORD381', '2024-02-17 08:51:00', 'It007', 1, 'Nia', 'out'),
(390, 'ORD381', '2024-02-17 08:51:00', 'It023', 1, 'Nia', NULL),
(391, 'ORD382', '2024-02-17 08:56:00', 'It001', 1, 'Oli', 'in'),
(392, 'ORD383', '2024-02-17 09:01:00', 'It017', 1, 'Pam', 'out'),
(393, 'ORD384', '2024-02-17 09:06:00', 'It004', 1, 'Quin', 'in'),
(394, 'ORD384', '2024-02-17 09:06:00', 'It020', 1, 'Quin', NULL),
(395, 'ORD385', '2024-02-17 09:11:00', 'It009', 1, 'Rae', 'out'),
(397, 'ORD387', '2024-02-17 09:21:00', 'It012', 1, 'Ty', 'out'),
(398, 'ORD388', '2024-02-17 09:27:00', 'It018', 1, 'Uma', 'in'),
(399, 'ORD388', '2024-02-17 09:27:00', 'It022', 1, 'Uma', NULL),
(400, 'ORD389', '2024-02-17 09:32:00', 'It005', 1, 'Val', 'out'),
(401, 'ORD390', '2024-02-17 09:37:00', 'It011', 1, 'Wes', 'in'),
(403, 'ORD392', '2024-02-17 09:47:00', 'It003', 1, 'Yol', 'in'),
(404, 'ORD393', '2024-02-17 09:52:00', 'It016', 1, 'Zed', 'out'),
(405, 'ORD393', '2024-02-17 09:52:00', 'It024', 1, 'Zed', NULL),
(406, 'ORD394', '2024-02-17 09:57:00', 'It008', 1, 'Amy', 'in'),
(407, 'ORD394', '2024-02-17 10:08:00', 'It016', 1, 'Zack', NULL),
(408, 'ORD395', '2024-02-17 10:24:00', 'It024', 1, 'Alex', 'in'),
(409, 'ORD395', '2024-02-17 10:24:00', 'It008', 1, 'Alex', NULL),
(410, 'ORD396', '2024-02-17 10:40:00', 'It002', 1, 'Brooke', 'out'),
(411, 'ORD397', '2024-02-17 10:56:00', 'It010', 1, 'Charles', 'in'),
(412, 'ORD398', '2024-02-17 11:12:00', 'It005', 1, 'Dana', 'out'),
(414, 'ORD400', '2024-02-17 11:44:00', 'It013', 1, 'Fiona', 'out'),
(415, 'ORD401', '2024-02-17 12:00:00', 'It021', 1, 'George', 'in'),
(416, 'ORD402', '2024-02-17 12:16:00', 'It017', 1, 'Heidi', 'out'),
(417, 'ORD403', '2024-02-17 12:00:00', 'It022', 1, 'Ivy', 'in'),
(418, 'ORD404', '2024-02-17 12:07:00', 'It004', 1, 'Jack', 'out'),
(419, 'ORD404', '2024-02-17 12:07:00', 'It006', 1, 'Jack', NULL),
(420, 'ORD405', '2024-02-17 12:14:00', 'It018', 1, 'Kiera', 'in'),
(421, 'ORD406', '2024-02-17 12:21:00', 'It011', 1, 'Leo', 'out'),
(422, 'ORD407', '2024-02-17 12:28:00', 'It023', 1, 'Mia', 'in'),
(424, 'ORD408', '2024-02-17 12:35:00', 'It009', 1, 'Noah', 'out'),
(425, 'ORD409', '2024-02-17 12:42:00', 'It015', 1, 'Olivia', 'in'),
(427, 'ORD411', '2024-02-17 12:56:00', 'It003', 1, 'Quinn', 'in'),
(428, 'ORD412', '2024-02-17 13:03:00', 'It020', 1, 'Rachel', 'out'),
(429, 'ORD412', '2024-02-17 13:03:00', 'It014', 1, 'Rachel', NULL),
(430, 'ORD413', '2024-02-17 13:10:00', 'It001', 1, 'Sam', 'in'),
(431, 'ORD414', '2024-02-17 13:17:00', 'It008', 1, 'Tina', 'out'),
(432, 'ORD415', '2024-02-17 13:24:00', 'It017', 1, 'Umar', 'in'),
(433, 'ORD416', '2024-02-17 13:31:00', 'It005', 1, 'Vivian', 'out'),
(434, 'ORD417', '2024-02-17 13:38:00', 'It012', 1, 'Wendy', 'in'),
(435, 'ORD417', '2024-02-17 13:38:00', 'It024', 1, 'Wendy', NULL),
(436, 'ORD418', '2024-02-17 13:45:00', 'It010', 1, 'Xavier', 'out'),
(438, 'ORD420', '2024-02-17 13:59:00', 'It019', 1, 'Zack', 'out'),
(439, 'ORD421', '2024-02-17 14:06:00', 'It007', 1, 'Amelia', 'in'),
(440, 'ORD422', '2024-02-17 14:13:00', 'It002', 1, 'Brad', 'out'),
(441, 'ORD423', '2024-02-17 14:20:00', 'It013', 1, 'Chloe', 'in'),
(442, 'ORD424', '2024-02-17 14:27:00', 'It021', 1, 'Derek', 'out'),
(443, 'ORD424', '2024-02-17 14:27:00', 'It016', 1, 'Derek', NULL),
(445, 'ORD426', '2024-02-17 14:41:00', 'It009', 1, 'Fred', 'out'),
(446, 'ORD427', '2024-02-17 14:48:00', 'It006', 1, 'Gina', 'in'),
(447, 'ORD428', '2024-02-17 14:55:00', 'It023', 1, 'Hugh', 'out'),
(448, 'ORD429', '2024-02-17 15:02:00', 'It018', 1, 'Iris', 'in'),
(449, 'ORD429', '2024-02-17 15:02:00', 'It011', 1, 'Iris', NULL),
(450, 'ORD430', '2024-02-17 15:23:00', 'It015', 1, 'Liam', 'out');

INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out) VALUES
(452, 'ORD432', '2024-02-17 15:55:00', 'It009', 1, 'Fred', 'out'),
(453, 'ORD433', '2024-02-17 16:11:00', 'It023', 1, 'Gina', 'in'),
(454, 'ORD434', '2024-02-17 16:27:00', 'It006', 1, 'Hugh', 'out'),
(455, 'ORD435', '2024-02-17 16:43:00', 'It018', 1, 'Iris', 'in'),
(456, 'ORD436', '2024-02-17 16:59:00', 'It002', 1, 'Jack', 'out'),
(458, 'ORD384', '2024-02-17 09:06:00', 'It004', 1, 'Quin', 'in'),
(459, 'ORD384', '2024-02-17 09:06:00', 'It020', 1, 'Quin', ' '),
(460, 'ORD385', '2024-02-17 09:11:00', 'It009', 1, 'Rae', 'out'),
(462, 'ORD387', '2024-02-17 09:21:00', 'It012', 1, 'Ty', 'out'),
(463, 'ORD388', '2024-02-17 09:27:00', 'It018', 1, 'Uma', 'in'),
(464, 'ORD388', '2024-02-17 09:27:00', 'It022', 1, 'Uma', ' ');

-- Insert row 465
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (465, 'ORD389', '2024-02-17 09:32:00', 'It005', 1, 'Val', 'out');

-- Insert row 466
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (466, 'ORD390', '2024-02-17 09:37:00', 'It011', 1, 'Wes', 'in');


-- Insert row 468
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (468, 'ORD392', '2024-02-17 09:47:00', 'It003', 1, 'Yol', 'in');

-- Insert row 469
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (469, 'ORD393', '2024-02-17 09:52:00', 'It016', 1, 'Zed', 'out');

INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (470, 'ORD393', '2024-02-17 09:52:00', 'It024', 1, 'Zed', ' ');

-- Insert row 471
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (471, 'ORD394', '2024-02-17 09:57:00', 'It008', 1, 'Amy', 'in');

-- Insert row 472
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (472, 'ORD394', '2024-02-17 10:08:00', 'It016', 1, 'Zack', ' ');

-- Insert row 473
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (473, 'ORD395', '2024-02-17 10:24:00', 'It024', 1, 'Alex', 'in');

INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (474, 'ORD395', '2024-02-17 10:24:00', 'It008', 1, 'Alex', ' ');

-- Insert row 475
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (475, 'ORD396', '2024-02-17 10:40:00', 'It002', 1, 'Brooke', 'out');

-- Insert row 476
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (476, 'ORD397', '2024-02-17 10:56:00', 'It010', 1, 'Charles', 'in');

-- Insert row 477
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (477, 'ORD398', '2024-02-17 11:12:00', 'It005', 1, 'Dana', 'out');


-- Insert row 479
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (479, 'ORD400', '2024-02-17 11:44:00', 'It013', 1, 'Fiona', 'out');

-- Insert row 480
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (480, 'ORD401', '2024-02-17 12:00:00', 'It021', 1, 'George', 'in');

-- Insert row 481
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (481, 'ORD402', '2024-02-17 12:16:00', 'It017', 1, 'Heidi', 'out');

-- Insert row 482
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (482, 'ORD403', '2024-02-17 12:00:00', 'It022', 1, 'Ivy', 'in');

-- Insert row 483
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (483, 'ORD404', '2024-02-17 12:07:00', 'It004', 1, 'Jack', 'out');

INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (484, 'ORD404', '2024-02-17 12:07:00', 'It006', 1, 'Jack', ' ');

-- Insert row 485
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (485, 'ORD405', '2024-02-17 12:14:00', 'It018', 1, 'Kiera', 'in');

-- Insert row 486
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (486, 'ORD406', '2024-02-17 12:21:00', 'It011', 1, 'Leo', 'out');

-- Insert row 487
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (487, 'ORD407', '2024-02-17 12:28:00', 'It023', 1, 'Mia', 'in');


-- Insert row 489
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (489, 'ORD408', '2024-02-17 12:35:00', 'It009', 1, 'Noah', 'out');

-- Insert row 490
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (490, 'ORD409', '2024-02-17 12:42:00', 'It015', 1, 'Olivia', 'in');



-- Insert row 492
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (492, 'ORD411', '2024-02-17 12:56:00', 'It003', 1, 'Quinn', 'in');

-- Insert row 493
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (493, 'ORD412', '2024-02-17 13:03:00', 'It020', 1, 'Rachel', 'out');

INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (494, 'ORD412', '2024-02-17 13:03:00', 'It014', 1, 'Rachel', ' ');

-- Insert row 495
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (495, 'ORD413', '2024-02-17 13:10:00', 'It001', 1, 'Sam', 'in');

-- Insert row 496
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (496, 'ORD414', '2024-02-17 13:17:00', 'It008', 1, 'Tina', 'out');

-- Insert row 497
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (497, 'ORD415', '2024-02-17 13:24:00', 'It017', 1, 'Umar', 'in');

-- Insert row 498
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (498, 'ORD416', '2024-02-17 13:31:00', 'It005', 1, 'Vivian', 'out');

-- Insert row 499
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (499, 'ORD417', '2024-02-17 13:38:00', 'It012', 1, 'Wendy', 'in');

INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (500, 'ORD417', '2024-02-17 13:38:00', 'It024', 1, 'Wendy', ' ');

-- Insert row 501
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (501, 'ORD418', '2024-02-17 13:45:00', 'It010', 1, 'Xavier', 'out');


-- Insert row 503
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (503, 'ORD420', '2024-02-17 13:59:00', 'It019', 1, 'Zack', 'out');

-- Insert row 504
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (504, 'ORD421', '2024-02-17 14:06:00', 'It007', 1, 'Amelia', 'in');

-- Insert row 505
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (505, 'ORD422', '2024-02-17 14:13:00', 'It002', 1, 'Brad', 'out');

-- Insert row 506
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (506, 'ORD423', '2024-02-17 14:20:00', 'It013', 1, 'Chloe', 'in');

-- Insert row 507
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (507, 'ORD424', '2024-02-17 14:27:00', 'It021', 1, 'Derek', 'out');

INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (508, 'ORD424', '2024-02-17 14:27:00', 'It016', 1, 'Derek', ' ');



-- Insert row 510
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (510, 'ORD426', '2024-02-17 14:41:00', 'It009', 1, 'Fred', 'out');

-- Insert row 511
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (511, 'ORD427', '2024-02-17 14:48:00', 'It006', 1, 'Gina', 'in');

-- Insert row 512
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (512, 'ORD428', '2024-02-17 14:55:00', 'It023', 1, 'Hugh', 'out');

-- Insert row 513
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (513, 'ORD429', '2024-02-17 15:02:00', 'It018', 1, 'Iris', 'in');

INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (514, 'ORD429', '2024-02-17 15:02:00', 'It011', 1, 'Iris', ' ');

-- Insert row 515
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (515, 'ORD430', '2024-02-17 15:23:00', 'It015', 1, 'Liam', 'out');



-- Insert row 517
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (517, 'ORD432', '2024-02-17 15:55:00', 'It009', 1, 'Fred', 'out');

-- Insert row 518
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (518, 'ORD433', '2024-02-17 16:11:00', 'It023', 1, 'Gina', 'in');

-- Insert row 519
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (519, 'ORD434', '2024-02-17 16:27:00', 'It006', 1, 'Hugh', 'out');

-- Insert row 520
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (520, 'ORD435', '2024-02-17 16:43:00', 'It018', 1, 'Iris', 'in');

-- Insert row 521
INSERT INTO orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
VALUES (521, 'ORD436', '2024-02-17 16:59:00', 'It002', 1, 'Jack', 'out');

