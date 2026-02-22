create database sql_tricks_ankit_bansal
use sql_tricks_ankit_bansal
go

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department_id INT,
    salary INT,
    manager_id INT
);

INSERT INTO Employees (emp_id, emp_name, department_id, salary, manager_id)
VALUES 
(1, 'Ankit', 100, 10000, 4),
(2, 'Mohit', 100, 15000, 5),
(3, 'Vikas', 100, 10000, 4),
(4, 'Rohit', 100, 5000, 2),
(5, 'Mudit', 200, 12000, 6),
(6, 'Agam', 200, 12000, 2),
(7, 'Sanjay', 200, 9000, 2),
(8, 'Ashish', 200, 5000, 2);


SELECT * FROM Employees;


select * from Employees
where salary > 10000



select department_id, avg(salary)
from Employees
group by department_id
having avg(salary) > 9500



select department_id, avg(salary) from Employees
where salary > 10000
group by department_id
having avg(salary) > 12000