 -- Department table

CREATE TABLE Department_184_Department_Highest_Salary (

    id INT PRIMARY KEY,

    name VARCHAR(50) NOT NULL

);



INSERT INTO Department_184_Department_Highest_Salary  (id, name) VALUES

(1, 'IT'),

(2, 'Sales');



-- Employee table

CREATE TABLE Employee_184_Department_Highest_Salary (

    id INT PRIMARY KEY,

    name VARCHAR(50),

    salary INT,

    departmentId INT,

    FOREIGN KEY (departmentId) REFERENCES Department_184_Department_Highest_Salary (id)

);



INSERT INTO Employee_184_Department_Highest_Salary (id, name, salary, departmentId) VALUES

(1, 'Joe', 70000, 1),

(2, 'Jim', 90000, 1),

(3, 'Henry', 80000, 2),

(4, 'Sam', 60000, 2),

(5, 'Max', 90000, 1);





select * from Employee_184_Department_Highest_Salary

select * from Department_184_Department_Highest_Salary 





SELECT d.name AS Department,

       e.name AS Employee,

       e.salary AS Salary

FROM Employee_184_Department_Highest_Salary e

JOIN Department_184_Department_Highest_Salary  d

    ON e.departmentId = d.id

WHERE e.salary = (

    SELECT MAX(salary)

    FROM Employee_184_Department_Highest_Salary

    WHERE departmentId = e.departmentId

);

