-- Drop if already exists (optional)
IF OBJECT_ID('Employees1', 'U') IS NOT NULL
    DROP TABLE Employees;
GO

-- Create table
CREATE TABLE Employees1 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT
);

-- Insert sample data
INSERT INTO Employees1 (emp_id, emp_name, salary) VALUES
(1, 'Ali', 70000),
(2, 'Sara', 85000),
(3, 'Usman', 65000),
(4, 'Bilal', 72000);



select * from Employees1


SELECT TOP 3 emp_name, salary
FROM Employees1 
ORDER BY (SELECT NULL);
