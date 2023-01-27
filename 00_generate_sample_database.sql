CREATE DATABASE sample_database;

USE sample_database;

CREATE TABLE item ( item_id VARCHAR(16) PRIMARY KEY,
                    item_name VARCHAR(96),
                    lot_size INT NOT NULL,
                    lead_time INT NOT NULL,
                    inventory INT NOT NULL);

INSERT INTO item (item_id, item_name, lot_size, lead_time, inventory)
VALUES  ("001", "Trumpet", 1, 2, 3),
        ("002", "Valve Casing Assembly", 10, 4, 10),
        ("003", "Bell Assembly", 10, 2, 10),
        ("004", "Slide Assemblies", 20, 2, 20),
        ("005", "Valves", 30, 3, 30);

CREATE TABLE bom (  item_id VARCHAR(16),
                    component_id VARCHAR(16),
                    bom_multiplier INT NOT NULL,
                    PRIMARY KEY (item_id, component_id));

INSERT INTO bom (item_id, component_id, bom_multiplier)
VALUES  ("001", "002", 1),
        ("001", "003", 1),
        ("002", "004", 3),
        ("002", "005", 3);                  

CREATE TABLE item_period (  item_id VARCHAR(16),
                            period_number INT,
                            gross_requirement INT,
                            projected_inventory INT,
                            planned_order_receipt INT,
                            planned_order_release INT,
                            PRIMARY KEY (item_id, period_number));

INSERT INTO item_period (   item_id, period_number, gross_requirement,
                            projected_inventory, planned_order_receipt,
                            planned_order_release)
VALUES  ("001", 0, 0, 3, 0, 0),         
        ("001", 1, 0, 3, 0, 0),       
        ("001", 2, 0, 3, 0, 0),
        ("001", 3, 0, 3, 0, 0),
        ("001", 4, 0, 3, 0, 0),
        ("001", 5, 0, 3, 0, 0),
        ("001", 6, 0, 3, 0, 0),
        ("001", 7, 0, 3, 0, 0),
        ("001", 8, 0, 3, 0, 0),
        ("001", 9, 0, 3, 0, 0),
        ("001", 10, 0, 3, 0, 0),
        ("001", 11, 0, 3, 0, 0),
        ("001", 12, 0, 3, 0, 0),
        ("002", 0, 0, 10, 0, 0),      
        ("002", 1, 0, 10, 0, 0),
        ("002", 2, 0, 10, 0, 0),
        ("002", 3, 0, 10, 0, 0),
        ("002", 4, 0, 10, 0, 0),
        ("002", 5, 0, 10, 0, 0),
        ("002", 6, 0, 10, 0, 0),
        ("002", 7, 0, 10, 0, 0),
        ("002", 8, 0, 10, 0, 0),
        ("002", 9, 0, 10, 0, 0),
        ("002", 10, 0, 10, 0, 0),
        ("002", 11, 0, 10, 0, 0),
        ("002", 12, 0, 10, 0, 0),
        ("003", 0, 0, 10, 0, 0),        
        ("003", 1, 0, 10, 0, 0),
        ("003", 2, 0, 10, 0, 0),
        ("003", 3, 0, 10, 0, 0),
        ("003", 4, 0, 10, 0, 0),
        ("003", 5, 0, 10, 0, 0),
        ("003", 6, 0, 10, 0, 0),
        ("003", 7, 0, 10, 0, 0),
        ("003", 8, 0, 10, 0, 0),
        ("003", 9, 0, 10, 0, 0),
        ("003", 10, 0, 10, 0, 0),
        ("003", 11, 0, 10, 0, 0),
        ("003", 12, 0, 10, 0, 0),
        ("004", 0, 0, 20, 0, 0),        
        ("004", 1, 0, 20, 0, 0),
        ("004", 2, 0, 20, 0, 0),
        ("004", 3, 0, 20, 0, 0),
        ("004", 4, 0, 20, 0, 0),
        ("004", 5, 0, 20, 0, 0),
        ("004", 6, 0, 20, 0, 0),
        ("004", 7, 0, 20, 0, 0),
        ("004", 8, 0, 20, 0, 0),
        ("004", 9, 0, 20, 0, 0),
        ("004", 10, 0, 20, 0, 0),
        ("004", 11, 0, 20, 0, 0),
        ("004", 12, 0, 20, 0, 0),
        ("005", 0, 0, 30, 0, 0),       
        ("005", 1, 0, 30, 0, 0),
        ("005", 2, 0, 30, 0, 0),
        ("005", 3, 0, 30, 0, 0),
        ("005", 4, 0, 30, 0, 0),
        ("005", 5, 0, 30, 0, 0),
        ("005", 6, 0, 30, 0, 0),
        ("005", 7, 0, 30, 0, 0),
        ("005", 8, 0, 30, 0, 0),
        ("005", 9, 0, 30, 0, 0),
        ("005", 10, 0, 30, 0, 0),
        ("005", 11, 0, 30, 0, 0),
        ("005", 12, 0, 30, 0, 0);

CREATE TABLE orders (   order_id VARCHAR(16) PRIMARY KEY,
                        customer_id VARCHAR(16),
                        period_number INT NOT NULL,
                        item_id VARCHAR(16) NOT NULL,
                        amount INT NOT NULL,
                        order_date DATETIME);

CREATE TABLE periods (  period_number INT PRIMARY KEY,
                        start_date DATE,
                        end_date DATE);

INSERT INTO periods (period_number)
VALUES  (1), (2), (3), (4), (5), (6),
        (7), (8), (9), (10), (11), (12);

CREATE TABLE customer ( customer_id VARCHAR(16) PRIMARY KEY,
                        customer_name VARCHAR(16));

CREATE TABLE required_items (   required_item VARCHAR(16),
                                required_amount INT,
                                due_period INT)