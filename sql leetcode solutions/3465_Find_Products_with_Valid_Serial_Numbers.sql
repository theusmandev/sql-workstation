CREATE TABLE products_3465_Find_Products_with_Valid_Serial_Numbers (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    description VARCHAR(500)
);


INSERT INTO products_3465_Find_Products_with_Valid_Serial_Numbers (product_id, product_name, description) VALUES
(1, 'Widget A', 'This is a sample product with SN1234-5678'),
(2, 'Widget B', 'A product with serial SN9876-1234 in the description'),
(3, 'Widget C', 'Product SN1234-56789 is available now'),
(4, 'Widget D', 'No serial number here'),
(5, 'Widget E', 'Check out SN4321-8765 in this description');



-- Write your PostgreSQL query statement below
SELECT * 
FROM products_3465_Find_Products_with_Valid_Serial_Numbers
WHERE description LIKE '%SN____-____' 
   OR description LIKE '%SN____-____ %';
