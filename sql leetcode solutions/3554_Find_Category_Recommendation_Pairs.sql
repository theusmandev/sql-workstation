CREATE TABLE ProductPurchases_3554_Find_Category_Recommendation_Pairs (
    user_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (user_id, product_id)
);



CREATE TABLE ProductInfo_3554_Find_Category_Recommendation_Pairs (
    product_id INT PRIMARY KEY,
    category VARCHAR(50),
    price DECIMAL(10,2)
);


INSERT INTO ProductPurchases_3554_Find_Category_Recommendation_Pairs (user_id, product_id, quantity)
VALUES
(1, 101, 2),
(1, 102, 1),
(1, 201, 3),
(1, 301, 1),

(2, 101, 1),
(2, 102, 2),
(2, 103, 1),
(2, 201, 5),

(3, 101, 2),
(3, 103, 1),
(3, 301, 4),
(3, 401, 2),

(4, 101, 1),
(4, 201, 3),
(4, 301, 1),
(4, 401, 2),

(5, 102, 2),
(5, 103, 1),
(5, 201, 2),
(5, 202, 3);



INSERT INTO ProductInfo_3554_Find_Category_Recommendation_Pairs (product_id, category, price)
VALUES
(101, 'Electronics', 100),
(102, 'Books', 20),
(103, 'Books', 35),
(201, 'Clothing', 45),
(202, 'Clothing', 60),
(301, 'Sports', 75),
(401, 'Kitchen', 50);




SELECT * FROM ProductPurchases_3554_Find_Category_Recommendation_Pairs;
SELECT * FROM ProductInfo_3554_Find_Category_Recommendation_Pairs;



WITH UserCategoryMap AS (
    SELECT DISTINCT
        p.user_id,
        i.category
    FROM ProductPurchases_3554_Find_Category_Recommendation_Pairs p
    JOIN ProductInfo_3554_Find_Category_Recommendation_Pairs i
        ON p.product_id = i.product_id
),

CategoryPairs AS (
    SELECT 
        c1.category AS category1,
        c2.category AS category2,
        c1.user_id
    FROM UserCategoryMap c1
    JOIN UserCategoryMap c2
        ON c1.user_id = c2.user_id
    WHERE c1.category < c2.category
)

SELECT
    category1,
    category2,
    COUNT(user_id) AS customer_count
FROM CategoryPairs
GROUP BY 
    category1,
    category2
HAVING 
    COUNT(user_id) >= 3
ORDER BY 
    customer_count DESC,
    category1 ASC,
    category2 ASC; 