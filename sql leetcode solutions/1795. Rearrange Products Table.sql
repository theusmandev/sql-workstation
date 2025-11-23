CREATE TABLE Products_1795_Rearrange_Products_Table (
    product_id INT PRIMARY KEY,
    store1 INT,
    store2 INT,
    store3 INT
);



INSERT INTO Products_1795_Rearrange_Products_Table (product_id, store1, store2, store3) VALUES
(0, 95, 100, 105),
(1, 70, NULL, 80);


select * from Products_1795_Rearrange_Products_Table

select product_id, store, price
from Products_1795_Rearrange_Products_Table
unpivot(
price for store in (store1,store2, store3)
)as up