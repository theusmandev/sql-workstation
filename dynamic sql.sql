create database sql_concepts



-- Drop table if it already exists
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;
GO

-- Create table
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

-- Insert sample data
INSERT INTO Employees (emp_id, emp_name, department, salary) VALUES
(1, 'Ali', 'HR', 60000),
(2, 'Bilal', 'HR', 50000),
(3, 'Hina', 'IT', 80000),
(4, 'Sara', 'IT', 90000),
(5, 'Usman', 'Finance', 70000),
(6, 'Tariq', 'Finance', 65000);



select * from Employees



DECLARE @SortColumn NVARCHAR(50) = 'salary';  
DECLARE @SQL NVARCHAR(MAX);

IF @SortColumn IS NULL
BEGIN
    SET @SQL = '
        SELECT 
            department,
            STRING_AGG(emp_name, '','') AS employee_names
        FROM Employees
        GROUP BY department;';
END
ELSE
BEGIN
    SET @SQL = '
        SELECT 
            department,
            STRING_AGG(emp_name, '','') 
                WITHIN GROUP (ORDER BY ' + @SortColumn + ') AS employee_names
        FROM Employees
        GROUP BY department;';
END

PRINT @SQL;  
EXEC (@SQL);




DECLARE @SortColumn NVARCHAR(50) = null;  
DECLARE @SQL NVARCHAR(MAX);

IF @SortColumn IS NULL
BEGIN
    SET @SQL = '
        SELECT 
            department,
            STRING_AGG(emp_name, '','') AS employee_names
        FROM Employees
        GROUP BY department;';
END
ELSE
BEGIN
    SET @SQL = '
        SELECT 
            department,
            STRING_AGG(emp_name, '','') 
                WITHIN GROUP (ORDER BY ' + @SortColumn + ') AS employee_names
        FROM Employees
        GROUP BY department;';
END

PRINT @SQL;  
EXEC (@SQL);



DECLARE @department VARCHAR(50) = 'HR';
DECLARE @sql VARCHAR(MAX);

SET @sql = 'SELECT * FROM employees WHERE department = ''' + @department + '''';
EXEC(@sql);









DECLARE @department NVARCHAR(50) = 'HR';
DECLARE @sql NVARCHAR(MAX);

SET @sql = N'SELECT * FROM employees WHERE department = @dept';
EXEC sp_executesql @sql, N'@dept NVARCHAR(50)', @dept = @department;





DECLARE @Dept NVARCHAR(50) = 'HR';
DECLARE @MinSalary INT = 50000;
DECLARE @SQL NVARCHAR(MAX);

SET @SQL = N'
    SELECT emp_name, department, salary
    FROM Employees
    WHERE department = @Department AND salary > @MinSalary;
';

EXEC sp_executesql 
    @SQL,
    N'@Department NVARCHAR(50), @MinSalary INT',
    @Department = @Dept,
    @MinSalary = @MinSalary;
