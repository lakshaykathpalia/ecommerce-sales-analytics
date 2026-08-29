-- E-Commerce Sales & Customer Analytics
-- Author: Lakshay Kathpalia
-- Database: MySQL

CREATE DATABASE IF NOT EXISTS ecommerce_analytics;
USE ecommerce_analytics;

-- =========================================================
-- 1. TABLES
-- =========================================================

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(150),
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- =========================================================
-- 2. DATA
-- =========================================================

INSERT INTO customers
(customer_id, customer_name, email, city, state, signup_date)
VALUES
(1, 'Rahul Sharma', 'rahul@gmail.com', 'Delhi', 'Delhi', '2024-01-15'),
(2, 'Priya Mehta', 'priya@gmail.com', 'Mumbai', 'Maharashtra', '2024-02-10'),
(3, 'Arjun Kapoor', 'arjun@gmail.com', 'Delhi', 'Delhi', '2024-02-18'),
(4, 'Sneha Verma', 'sneha@gmail.com', 'Bangalore', 'Karnataka', '2024-03-05'),
(5, 'Rohan Gupta', 'rohan@gmail.com', 'Pune', 'Maharashtra', '2024-03-21'),
(6, 'Ananya Singh', 'ananya@gmail.com', 'Delhi', 'Delhi', '2024-04-12'),
(7, 'Karan Malhotra', 'karan@gmail.com', 'Chandigarh', 'Chandigarh', '2024-04-25'),
(8, 'Neha Jain', 'neha@gmail.com', 'Jaipur', 'Rajasthan', '2024-05-03'),
(9, 'Aditya Rao', 'aditya@gmail.com', 'Hyderabad', 'Telangana', '2024-05-19'),
(10, 'Simran Kaur', 'simran@gmail.com', 'Amritsar', 'Punjab', '2024-06-01');

INSERT INTO products
(product_id, product_name, category, price)
VALUES
(101, 'Laptop', 'Electronics', 65000),
(102, 'Smartphone', 'Electronics', 35000),
(103, 'Headphones', 'Electronics', 2500),
(104, 'Office Chair', 'Furniture', 8500),
(105, 'Desk', 'Furniture', 12000),
(106, 'Backpack', 'Accessories', 1800),
(107, 'Keyboard', 'Electronics', 2200),
(108, 'Mouse', 'Electronics', 1200),
(109, 'Monitor', 'Electronics', 15000),
(110, 'Notebook', 'Stationery', 300);

INSERT INTO orders
(order_id, customer_id, order_date, order_status)
VALUES
(1001, 1, '2024-06-10', 'Completed'),
(1002, 2, '2024-06-12', 'Completed'),
(1003, 3, '2024-06-15', 'Completed'),
(1004, 4, '2024-06-18', 'Cancelled'),
(1005, 5, '2024-06-20', 'Completed'),
(1006, 6, '2024-07-02', 'Completed'),
(1007, 7, '2024-07-05', 'Completed'),
(1008, 8, '2024-07-10', 'Cancelled'),
(1009, 9, '2024-07-15', 'Completed'),
(1010, 10, '2024-07-20', 'Completed'),
(1011, 1, '2024-08-01', 'Completed'),
(1012, 2, '2024-08-05', 'Completed'),
(1013, 3, '2024-08-10', 'Completed'),
(1014, 5, '2024-08-15', 'Completed'),
(1015, 6, '2024-08-20', 'Completed');

INSERT INTO order_items
(order_item_id, order_id, product_id, quantity)
VALUES
(1, 1001, 101, 1),
(2, 1001, 103, 2),
(3, 1002, 102, 1),
(4, 1002, 108, 2),
(5, 1003, 104, 1),
(6, 1003, 106, 2),
(7, 1004, 105, 1),
(8, 1005, 109, 1),
(9, 1005, 107, 1),
(10, 1006, 102, 1),
(11, 1006, 103, 1),
(12, 1007, 105, 1),
(13, 1007, 106, 1),
(14, 1008, 101, 1),
(15, 1009, 109, 2),
(16, 1010, 103, 1),
(17, 1010, 108, 2),
(18, 1011, 101, 1),
(19, 1011, 107, 1),
(20, 1012, 102, 1),
(21, 1012, 109, 1),
(22, 1013, 104, 2),
(23, 1014, 105, 1),
(24, 1014, 108, 1),
(25, 1015, 106, 3),
(26, 1015, 103, 1);

-- =========================================================
-- 3. EXPLORATORY ANALYSIS
-- =========================================================

-- Q1: Total customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Q2: Total orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Q3: Completed orders
SELECT COUNT(*) AS completed_orders
FROM orders
WHERE order_status = 'Completed';

-- Q4: Cancelled orders
SELECT COUNT(*) AS cancelled_orders
FROM orders
WHERE order_status = 'Cancelled';

-- Q5: Total revenue from completed orders
SELECT
    SUM(p.price * oi.quantity) AS total_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON p.product_id = oi.product_id
WHERE o.order_status = 'Completed';

-- Q6: Revenue by product category
SELECT
    p.category,
    SUM(p.price * oi.quantity) AS total_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON p.product_id = oi.product_id
WHERE o.order_status = 'Completed'
GROUP BY p.category
ORDER BY total_revenue DESC;

-- Q7: Top 5 products by revenue
SELECT
    p.product_name,
    SUM(p.price * oi.quantity) AS total_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON p.product_id = oi.product_id
WHERE o.order_status = 'Completed'
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5;

-- Q8: Top 5 customers by spending
SELECT
    c.customer_name,
    SUM(p.price * oi.quantity) AS total_spent
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON oi.order_id = o.order_id
JOIN products AS p
    ON p.product_id = oi.product_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 5;

-- Q9: Monthly revenue
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    SUM(p.price * oi.quantity) AS revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON p.product_id = oi.product_id
WHERE o.order_status = 'Completed'
GROUP BY order_month
ORDER BY order_month;

-- Q10: Revenue by city
SELECT
    c.city,
    SUM(p.price * oi.quantity) AS revenue
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON p.product_id = oi.product_id
WHERE o.order_status = 'Completed'
GROUP BY c.city
ORDER BY revenue DESC;

-- Q11: Repeat customers (2+ completed orders)
SELECT
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS completed_orders
FROM customers AS c
JOIN orders AS o
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_name
HAVING COUNT(DISTINCT o.order_id) >= 2
ORDER BY completed_orders DESC;

-- Q12: Customers spending more than 50,000
SELECT
    c.customer_name,
    SUM(p.price * oi.quantity) AS total_spent
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_name
HAVING total_spent > 50000
ORDER BY total_spent DESC;

-- Q13: Monthly completed order volume
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(DISTINCT order_id) AS completed_orders
FROM orders
WHERE order_status = 'Completed'
GROUP BY order_month
ORDER BY order_month;

-- Q14: Average order value
SELECT
    SUM(p.price * oi.quantity) / COUNT(DISTINCT o.order_id) AS average_order_value
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON p.product_id = oi.product_id
WHERE o.order_status = 'Completed';

-- =========================================================
-- 4. DATA QUALITY / VALIDATION
-- =========================================================

SELECT COUNT(*) AS customer_rows FROM customers;
SELECT COUNT(*) AS product_rows FROM products;
SELECT COUNT(*) AS order_rows FROM orders;
SELECT COUNT(*) AS order_item_rows FROM order_items;

-- Check order statuses
SELECT order_status, COUNT(*) AS order_count
FROM orders
GROUP BY order_status;

-- =========================================================
-- 5. OPTIONAL ADVANCED ANALYSIS
-- =========================================================

-- Customer spending category using CASE
SELECT
    c.customer_name,
    SUM(p.price * oi.quantity) AS total_spent,
    CASE
        WHEN SUM(p.price * oi.quantity) >= 100000 THEN 'High Value'
        WHEN SUM(p.price * oi.quantity) >= 50000 THEN 'Medium Value'
        ELSE 'Standard'
    END AS customer_segment
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_name
ORDER BY total_spent DESC;
