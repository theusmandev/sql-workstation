CREATE TABLE ProductPurchases_3521_Find_Product_Recommendation_Pairs (
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT PK_ProductPurchases PRIMARY KEY (user_id, product_id)
);


INSERT INTO ProductPurchases_3521_Find_Product_Recommendation_Pairs (user_id, product_id, quantity) VALUES
(1, 101, 2),
(1, 102, 1),
(1, 103, 3),
(2, 101, 1),
(2, 102, 5),
(2, 104, 1),
(3, 101, 2),
(3, 103, 1),
(3, 105, 4),
(4, 101, 1),
(4, 102, 1),
(4, 103, 2),
(4, 104, 3),
(5, 102, 2),
(5, 104, 1);




CREATE TABLE ProductInfo_3521_Find_Product_Recommendation_Pairs (
    product_id INT PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);




INSERT INTO ProductInfo_3521_Find_Product_Recommendation_Pairs (product_id, category, price) VALUES
(101, 'Electronics', 100),
(102, 'Books', 20),
(103, 'Clothing', 35),
(104, 'Kitchen', 50),
(105, 'Sports', 75);



select * from ProductPurchases_3521_Find_Product_Recommendation_Pairs
select * from ProductInfo_3521_Find_Product_Recommendation_Pairs


SELECT 
    p1.product_id AS product1_id,
    p2.product_id AS product2_id,
    i1.category AS product1_category,
    i2.category AS product2_category,
    COUNT(p1.user_id) AS customer_count
FROM ProductPurchases_3521_Find_Product_Recommendation_Pairs p1
-- 1. Self Join: Same user, different products (avoid duplicates)
JOIN ProductPurchases_3521_Find_Product_Recommendation_Pairs p2 
    ON p1.user_id = p2.user_id 
    AND p1.product_id < p2.product_id
-- 2. Join Info table twice: Get details for both products
JOIN ProductInfo_3521_Find_Product_Recommendation_Pairs i1 
    ON p1.product_id = i1.product_id
JOIN ProductInfo_3521_Find_Product_Recommendation_Pairs i2 
    ON p2.product_id = i2.product_id
-- 3. Grouping: Combine rows into unique pairs
GROUP BY 
    p1.product_id, 
    p2.product_id,
    i1.category,
    i2.category
-- 4. Filtering: Keep only popular pairs (3+ customers)
HAVING 
    COUNT(p1.user_id) >= 3
-- 5. Sorting: As per requirements
ORDER BY 
    customer_count DESC, 
    product1_id ASC, 
    product2_id ASC;
