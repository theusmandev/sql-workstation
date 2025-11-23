-- Create Employees table
CREATE TABLE Employees_1731_The_Number_of_Employees_Which_Report_to_Each_Employee (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    reports_to INT,
    age INT
);


INSERT INTO Employees_1731_The_Number_of_Employees_Which_Report_to_Each_Employee (employee_id, name, reports_to, age) VALUES
(9, 'Hercy', NULL, 43),
(6, 'Alice', 9, 41),
(4, 'Bob', 9, 36),
(2, 'Winston', NULL, 37);



select * from Employees_1731_The_Number_of_Employees_Which_Report_to_Each_Employee

/* Write your T-SQL query statement below */

SELECT 
    m.employee_id,
    m.name,
    COUNT(e.employee_id) AS reports_count,
    ROUND(AVG(e.age), 0) AS average_age
FROM 
    Employees_1731_The_Number_of_Employees_Which_Report_to_Each_Employee e
JOIN 
    Employees_1731_The_Number_of_Employees_Which_Report_to_Each_Employee m
ON 
    e.reports_to = m.employee_id
GROUP BY 
    m.employee_id, m.name
ORDER BY 
    m.employee_id;
