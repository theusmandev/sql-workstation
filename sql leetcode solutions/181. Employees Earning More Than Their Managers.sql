 CREATE TABLE Employee_181_Employees_Earning_More_Than_Their_Managers (

    id INT PRIMARY KEY,

    name VARCHAR(100),

    salary INT,

    managerId INT NULL

);





INSERT INTO Employee_181_Employees_Earning_More_Than_Their_Managers  (id, name, salary, managerId) VALUES

(1, 'Joe', 70000, 3),

(2, 'Henry', 80000, 4),

(3, 'Sam', 60000, NULL),

(4, 'Max', 90000, NULL);







select * from Employee_181_Employees_Earning_More_Than_Their_Managers 





SELECT e.name AS Employee

FROM Employee_181_Employees_Earning_More_Than_Their_Managers e

JOIN Employee_181_Employees_Earning_More_Than_Their_Managers m

    ON e.managerId = m.id

WHERE e.salary > m.salary;

