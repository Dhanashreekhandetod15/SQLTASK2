CREATE TABLE Category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR UNIQUE NOT NULL,
    CHECK (length(name) >= 3)
);


CREATE TABLE Material (
    material_id SERIAL PRIMARY KEY,
    name VARCHAR UNIQUE NOT NULL,
    CHECK (name IN ('Wood', 'Metal', 'Glass', 'Fabric', 'Leather', 'Plastic'))
);

CREATE TABLE Warehouse (
    warehouse_id SERIAL PRIMARY KEY,
    location_name VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR NOT NULL,
    capacity INT,
    CHECK (capacity BETWEEN 100 AND 1000)
);


CREATE TABLE Styles (
    style_id SERIAL PRIMARY KEY, -- PK
    style_name VARCHAR(50) UNIQUE NOT NULL,
    brought_year INT,
    CHECK (brought_year <= 1999) -- CHECK Constraint Year must be in the past or present
);

CREATE TABLE Orders (
    customer_id INT NOT NULL REFERENCES Customers(customer_id),
    order_date DATE NOT NULL,
    quantity INT NOT NULL,
    unit_price NUMERIC(10, 2) NOT NULL,
    CHECK (quantity > 0)
);

CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY, 
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR UNIQUE NOT NULL, 
    loyalty_level VARCHAR NOT NULL,
    CHECK (loyalty_level IN ('Silver', 'Gold')) -- CHECK Constraint Restricts loyalty level of values
);

----insert data

-- Categories
INSERT INTO Category (category_id, name) VALUES (1, 'Seating'), (2, 'Tables'), (3, 'Storage');

-- Materials
INSERT INTO Material (material_id, name) VALUES 
(1, 'Wood'), 
(2, 'Metal'), 
(3, 'Glass'), 
(4, 'Fabric'), 
(5, 'Leather'),
(6, 'Plastic');

-- Styles 
INSERT INTO Styles (style_name, brought_year) VALUES
('Mid-Century Modern', 1965),
('Victorian', 1890),
('Art Deco', 1930),
('Industrial', 1999),
('Rustic Farmhouse', 1950);

-- Warehouses 
INSERT INTO Warehouse (location_name, city, capacity) VALUES
('East Coast Hub', 'New York', 850),
('West Coast Depot', 'Los Angeles', 990),
('Midwest Center', 'Chicago', 500),
('Southern Storage', 'Dallas', 720);

--customer
INSERT INTO Customers (first_name, last_name, email, loyalty_level) VALUES
('Alice', 'Smith', 'alice.smith@example.com', 'Gold'),
('Bob', 'Johnson', 'bob.johnson@example.com', 'Silver'),
('Charlie', 'Brown', 'charlie.brown@example.com', 'Gold'),
('Diana', 'Prince', 'diana.prince@example.com', 'Silver');


--orders
INSERT INTO Orders (customer_id, order_date, quantity, unit_price) VALUES
(1, '2025-10-20', 2, 450.00), -- Alice (Gold) bought 2 items at 450.00
(2, '2025-10-21', 1, 120.50), -- Bob (Silver) bought 1 item at 120.50
(1, '2025-11-01', 5, 25.99),  -- Alice (Gold) bought 5 items at 25.99
(3, '2025-11-05', 3, 75.00),  -- Charlie (Gold) bought 3 items at 75.00
(4, '2025-11-20', 1, 899.99); -- Diana (Silver) bought 1 item at 899.99


---queries for data 
select * from Category;
select name from Material;
select style_name, brought_year from Styles;
select location_name, city from Warehouse;
select first_name, last_name, email from Customers;

select * from Orders;
select * from material where material_id=(1);

select * from styles where brought_year<1950;

select * from warehouse where city ='New York';

select * from Customers where loyalty_level='Silver'; 
select * from Customers where loyalty_level='Gold'; 

select * from orders where unit_price > 90.00;

select * from orders where unit_price < 100.00 ;

select * from customers ;

select * from customers where last_name = 'Smith';

select * from category where name != 'Tables';

select * from Material where name = 'wood' or name ='Metal';

select * from styles where brought_year between 1900 and 1960;

select * from orders where order_date > '2025-10-31';

select * from orders where quantity =1;

select * from customers where loyalty_level= 'Silver' and last_name like 'P%';
select * from customers where loyalty_level= 'Gold' and last_name like 'S%';


------------
select count(*)as total_categories from Category; 

select Max(capacity) as max_capacity from warehouse;

select avg(unit_price) as average_price  from orders;

select sum(quantity)as total_items_orders from orders;

select min(brought_year)as era_year from  styles;

select count(*) as gold_customers from Customers where loyalty_level='Gold';

select sum(quantity * unit_price) as total_value from orders;

select  style_name from styles order by style_name asc;

select  style_name from styles order by style_name desc;

select location_name, capacity from warehouse order by  capacity desc;

select customer_id,count(order_id) as number_of_orders from orders group by customer_id;


