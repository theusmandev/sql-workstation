CREATE TABLE products_3564_Seasonal_Sales_Analysis (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL
);



INSERT INTO products_3564_Seasonal_Sales_Analysis (product_id, product_name, category) VALUES
(1, 'Warm Jacket', 'Apparel'),
(2, 'Designer Jeans', 'Apparel'),
(3, 'Cutting Board', 'Kitchen'),
(4, 'Smart Speaker', 'Tech'),
(5, 'Yoga Mat', 'Fitness');



CREATE TABLE sales_3564_Seasonal_Sales_Analysis (
    sale_id INT PRIMARY KEY,
    product_id INT NOT NULL,
    sale_date DATE NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_sales_products
        FOREIGN KEY (product_id) REFERENCES products_3564_Seasonal_Sales_Analysis(product_id)
);




INSERT INTO sales_3564_Seasonal_Sales_Analysis (sale_id, product_id, sale_date, quantity, price) VALUES
(1, 1, '2023-01-15', 5, 10.00),
(2, 2, '2023-01-20', 4, 15.00),
(3, 3, '2023-03-10', 3, 18.00),
(4, 4, '2023-04-05', 1, 20.00),
(5, 1, '2023-05-20', 2, 10.00),
(6, 2, '2023-06-12', 4, 15.00),
(7, 5, '2023-06-15', 5, 12.00),
(8, 3, '2023-07-24', 2, 18.00),
(9, 4, '2023-08-01', 5, 20.00),
(10, 5, '2023-09-03', 3, 12.00),
(11, 1, '2023-09-25', 6, 10.00),
(12, 2, '2023-11-10', 4, 15.00),
(13, 3, '2023-12-05', 6, 18.00),
(14, 4, '2023-12-22', 3, 20.00),
(15, 5, '2024-02-14', 2, 12.00);







WITH Sales_Data AS (

    SELECT 
        p.category,
        s.quantity,
        s.price,
        CASE 
            WHEN MONTH(s.sale_date) IN (12, 1, 2) THEN 'Winter'
            WHEN MONTH(s.sale_date) IN (3, 4, 5) THEN 'Spring'
            WHEN MONTH(s.sale_date) IN (6, 7, 8) THEN 'Summer'
            ELSE 'Fall'
        END AS season
    FROM sales_3564_Seasonal_Sales_Analysis s
    JOIN products_3564_Seasonal_Sales_Analysis p ON s.product_id = p.product_id
),
Category_Stats AS (

    SELECT 
        season,
        category,
        SUM(quantity) as total_quantity,
        SUM(quantity * price) as total_revenue
    FROM Sales_Data
    GROUP BY season, category
),
Ranked_Stats AS (
    -- Step 3: Ranking (ROW_NUMBER)
    SELECT 
        *,
        ROW_NUMBER() OVER (
            PARTITION BY season 
            ORDER BY total_quantity DESC, total_revenue DESC, category ASC
        ) as ranking
    FROM Category_Stats
)
-- Step 4: Final Selection
SELECT season, category, total_quantity, total_revenue
FROM Ranked_Stats
WHERE ranking = 1
ORDER BY season;