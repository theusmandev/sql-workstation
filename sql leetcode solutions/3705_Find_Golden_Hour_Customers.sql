CREATE TABLE restaurant_orders_3705_Find_Golden_Hour_Customers (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_timestamp DATETIME,
    order_amount DECIMAL(10,2),
    payment_method VARCHAR(20),
    order_rating INT
);



INSERT INTO restaurant_orders_3705_Find_Golden_Hour_Customers
(order_id, customer_id, order_timestamp, order_amount, payment_method, order_rating)
VALUES
(1, 101, '2024-03-01 12:30:00', 25.50, 'card', 5),
(2, 101, '2024-03-02 19:15:00', 32.00, 'app', 4),
(3, 101, '2024-03-03 13:45:00', 28.75, 'card', 5),
(4, 101, '2024-03-04 20:30:00', 41.00, 'app', NULL),

(5, 102, '2024-03-01 11:30:00', 18.50, 'cash', 4),
(6, 102, '2024-03-02 12:00:00', 22.00, 'card', 3),
(7, 102, '2024-03-03 15:30:00', 19.75, 'cash', NULL),

(8, 103, '2024-03-01 19:00:00', 55.00, 'app', 5),
(9, 103, '2024-03-02 20:45:00', 48.50, 'app', 4),
(10, 103, '2024-03-03 18:30:00', 62.00, 'card', 5),

(11, 104, '2024-03-01 10:00:00', 15.00, 'cash', 3),
(12, 104, '2024-03-02 09:30:00', 18.00, 'cash', 2),
(13, 104, '2024-03-03 16:00:00', 20.00, 'card', 3),

(14, 105, '2024-03-01 12:15:00', 30.00, 'app', 4),
(15, 105, '2024-03-02 13:00:00', 35.50, 'app', 5),
(16, 105, '2024-03-03 11:45:00', 28.00, 'card', 4);






SELECT * FROM restaurant_orders_3705_Find_Golden_Hour_Customers;




WITH CustomerMetrics AS (
    SELECT 
        customer_id,
        COUNT(*) AS total_orders,
        -- Peak hour orders count
        SUM(CASE 
            WHEN CAST(order_timestamp AS TIME) BETWEEN '11:00:00' AND '14:00:00' 
              OR CAST(order_timestamp AS TIME) BETWEEN '18:00:00' AND '21:00:00' 
            THEN 1 ELSE 0 END) AS peak_orders,
        -- Rated orders count (ignores NULLs)
        COUNT(order_rating) AS rated_orders,
        -- Average rating (CAST to float to avoid integer division)
        AVG(CAST(order_rating AS FLOAT)) AS avg_rating
    FROM restaurant_orders_3705_Find_Golden_Hour_Customers
    GROUP BY customer_id
)
SELECT 
    customer_id,
    total_orders,
    -- Yahan ROUND(..., 0) add kiya gaya hai
    ROUND(peak_orders * 100.0 / total_orders, 0) AS peak_hour_percentage,
    ROUND(avg_rating, 2) AS average_rating
FROM CustomerMetrics
WHERE 
    total_orders >= 3
    AND (peak_orders * 1.0 / total_orders) >= 0.6
    AND avg_rating >= 4.0
    AND (rated_orders * 1.0 / total_orders) >= 0.5
ORDER BY 
    average_rating DESC, 
    customer_id DESC;