 -- SalesPerson table

CREATE TABLE SalesPerson_607_No_Order_for_SalesPerson (

    sales_id INT PRIMARY KEY,

    name VARCHAR(50),

    salary INT,

    commission_rate INT,

    hire_date DATE

);



INSERT INTO SalesPerson_607_No_Order_for_SalesPerson (sales_id, name, salary, commission_rate, hire_date) VALUES

(1, 'John', 100000, 6, '2006-04-01'),

(2, 'Amy', 12000, 5, '2010-05-01'),

(3, 'Mark', 65000, 12, '2008-12-25'),

(4, 'Pam', 25000, 25, '2005-01-01'),

(5, 'Alex', 5000, 10, '2007-02-03');



-- Company table

CREATE TABLE Company_607_No_Order_for_SalesPerson (

    com_id INT PRIMARY KEY,

    name VARCHAR(50),

    city VARCHAR(50)

);



INSERT INTO Company_607_No_Order_for_SalesPerson (com_id, name, city) VALUES

(1, 'RED', 'Boston'),

(2, 'ORANGE', 'New York'),

(3, 'YELLOW', 'Boston'),

(4, 'GREEN', 'Austin');



-- Orders table

CREATE TABLE Orders_607_No_Order_for_SalesPerson (

    order_id INT PRIMARY KEY,

    order_date DATE,

    com_id INT,

    sales_id INT,

    amount INT,

    FOREIGN KEY (com_id) REFERENCES Company_607_No_Order_for_SalesPerson(com_id),

    FOREIGN KEY (sales_id) REFERENCES SalesPerson_607_No_Order_for_SalesPerson(sales_id)

);



INSERT INTO Orders_607_No_Order_for_SalesPerson (order_id, order_date, com_id, sales_id, amount) VALUES

(1, '2014-01-01', 3, 4, 10000),

(2, '2014-02-01', 4, 5, 5000),

(3, '2014-03-01', 1, 1, 50000),

(4, '2014-04-01', 1, 4, 25000);





select * from SalesPerson_607_No_Order_for_SalesPerson

select * from Company_607_No_Order_for_SalesPerson 

select * from Orders_607_No_Order_for_SalesPerson











SELECT s.name

FROM SalesPerson_607_No_Order_for_SalesPerson s

WHERE s.sales_id NOT IN (

    SELECT o.sales_id

    FROM Orders_607_No_Order_for_SalesPerson o

    JOIN Company_607_No_Order_for_SalesPerson c

        ON o.com_id = c.com_id

    WHERE c.name = 'RED'

);

