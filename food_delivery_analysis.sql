CREATE DATABASE food_delivery;

USE food_delivery;

CREATE TABLE orders (
    order_id INT,
    distance_km FLOAT,
    weather VARCHAR(50),
    traffic_level VARCHAR(50),
    time_of_day VARCHAR(50),
    vehicle_type VARCHAR(50),
    preparation_time_min INT,
    courier_experience_yrs FLOAT,
    delivery_time_min INT,
    rating INT,
    is_delayed BOOLEAN,
    customer_type VARCHAR(20)
);

SELECT * FROM orders LIMIT 10;
SHOW TABLES;

SELECT * FROM orders_cleaned LIMIT 10;

-- --Total Orders--
SELECT COUNT(*) AS total_orders
FROM orders_cleaned;

-- Average Delivery Time
SELECT AVG(delivery_time_min) AS avg_delivery_time
FROM orders_cleaned;

-- Delay vs Rating
SELECT 
    is_delayed,
    AVG(rating) AS avg_rating
FROM orders_cleaned
GROUP BY is_delayed;

-- Traffic Impact
SELECT 
    traffic_level,
    AVG(delivery_time_min) AS avg_delivery_time
FROM orders_cleaned
GROUP BY traffic_level
ORDER BY avg_delivery_time DESC;

-- Weather Impact
SELECT 
    weather,
    AVG(delivery_time_min) AS avg_time
FROM orders_cleaned
GROUP BY weather
ORDER BY avg_time DESC;

-- Peak Time
SELECT 
    time_of_day,
    COUNT(*) AS total_orders
FROM orders_cleaned
GROUP BY time_of_day
ORDER BY total_orders DESC;

-- Delay Percentage
SELECT 
    (SUM(CASE WHEN is_delayed = TRUE THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) 
    AS delay_percentage
FROM orders_cleaned;

-- Best Performing Conditions
SELECT 
    weather,
    traffic_level,
    AVG(delivery_time_min) AS avg_time
FROM orders_cleaned
GROUP BY weather, traffic_level
ORDER BY avg_time
LIMIT 5;

-- Worst Performing Conditions
SELECT 
    weather,
    traffic_level,
    AVG(delivery_time_min) AS avg_time
FROM orders_cleaned
GROUP BY weather, traffic_level
ORDER BY avg_time DESC
LIMIT 5;

