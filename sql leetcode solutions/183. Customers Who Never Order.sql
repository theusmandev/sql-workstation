 -- Customers table

CREATE TABLE Customers_183_Customers_Who_Never_Order (

    id INT PRIMARY KEY,

    name VARCHAR(50)

);



INSERT INTO Customers_183_Customers_Who_Never_Order (id, name) VALUES

(1, 'Joe'),

(2, 'Henry'),

(3, 'Sam'),

(4, 'Max');



-- Orders table

CREATE TABLE Orders_183_Customers_Who_Never_Order (

    id INT PRIMARY KEY,

    customerId INT,

    FOREIGN KEY (customerId) REFERENCES Customers_183_Customers_Who_Never_Order(id)

);



INSERT INTO Orders_183_Customers_Who_Never_Order (id, customerId) VALUES

(1, 3),

(2, 1);





select * from Orders_183_Customers_Who_Never_Order

select * from Customers_183_Customers_Who_Never_Order



SELECT c.name AS Customers

FROM Customers_183_Customers_Who_Never_Order c

LEFT JOIN Orders_183_Customers_Who_Never_Order o

    ON c.id = o.customerId

WHERE o.customerId IS NULL;







SELECT name AS Customers

FROM Customers

WHERE id NOT IN (SELECT customerId FROM Orders);

