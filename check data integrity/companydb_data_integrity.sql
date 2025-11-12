CREATE DATABASE CompanyDB;
GO
USE CompanyDB;
GO


-- Table 1: Departments (Entity Integrity + Domain Integrity)
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,                      -- Entity integrity
    DeptName NVARCHAR(50) NOT NULL UNIQUE,       -- Unique department names
    Budget DECIMAL(12,2) CHECK (Budget >= 50000) -- Domain integrity
);

-- Table 2: Employees (Entity + Referential + Domain)
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,                             -- Entity integrity
    EmpName NVARCHAR(50) NOT NULL,
    HireDate DATE DEFAULT GETDATE(),                   -- Domain integrity
    DeptID INT FOREIGN KEY REFERENCES Departments(DeptID), -- Referential integrity
    Salary DECIMAL(10,2) CHECK (Salary >= 20000)       -- Domain integrity
);





INSERT INTO Departments VALUES (1, 'IT', 100000);
INSERT INTO Departments VALUES (2, 'HR', 60000);

INSERT INTO Employees VALUES (101, 'Ali', '2021-05-01', 1, 35000);
INSERT INTO Employees VALUES (102, 'Sara', '2022-02-15', 2, 40000);


select * from employees
select * from Departments


--Entity Integrity — Duplicate Primary Key

INSERT INTO Employees VALUES (101, 'John', '2023-03-01', 1, 30000);
-- Error: Cannot insert duplicate key in object 'Employees'



--Domain Integrity — Salary too low
INSERT INTO Employees VALUES (103, 'Hina', '2023-03-01', 1, 15000);
-- Error: CHECK constraint violated (Salary >= 20000)




--Referential Integrity — Invalid Department
INSERT INTO Employees VALUES (104, 'Rizwan', '2023-03-01', 99, 30000);
-- Error: FOREIGN KEY constraint violation (DeptID 99 not found)


--Domain Integrity — Budget too small
INSERT INTO Departments VALUES (3, 'Sales', 20000);
-- Error: CHECK constraint violated (Budget >= 50000)




--Add User-Defined Integrity Rule (Trigger)

CREATE TRIGGER trg_PreventSalaryDecrease
ON Employees
FOR UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN deleted d ON i.EmpID = d.EmpID
        WHERE i.Salary < d.Salary
    )
    BEGIN
        RAISERROR ('Salary cannot be decreased!', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;



UPDATE Employees SET Salary = 25000 WHERE EmpID = 101;
-- Error: Salary cannot be decreased!






SELECT 
    TABLE_NAME, 
    CONSTRAINT_NAME, 
    CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_CATALOG = 'CompanyDB'
ORDER BY TABLE_NAME, CONSTRAINT_TYPE;







USE CompanyDB;
GO

SELECT 
    t.TABLE_NAME,
    c.CONSTRAINT_NAME,
    cc.CHECK_CLAUSE
FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS AS cc
INNER JOIN INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE AS c
    ON cc.CONSTRAINT_NAME = c.CONSTRAINT_NAME
INNER JOIN INFORMATION_SCHEMA.TABLES AS t
    ON c.TABLE_NAME = t.TABLE_NAME
ORDER BY t.TABLE_NAME;










SELECT 
    fk.name AS FK_Name,
    OBJECT_NAME(fk.parent_object_id) AS Child_Table,
    c1.name AS Child_Column,
    OBJECT_NAME(fk.referenced_object_id) AS Parent_Table,
    c2.name AS Parent_Column
FROM sys.foreign_keys AS fk
INNER JOIN sys.foreign_key_columns AS fkc 
    ON fk.object_id = fkc.constraint_object_id
INNER JOIN sys.columns AS c1 
    ON fkc.parent_object_id = c1.object_id 
    AND fkc.parent_column_id = c1.column_id
INNER JOIN sys.columns AS c2 
    ON fkc.referenced_object_id = c2.object_id 
    AND fkc.referenced_column_id = c2.column_id
ORDER BY Child_Table;






SELECT 
    t.name AS Table_Name,
    c.name AS Column_Name,
    dc.name AS Default_Name,
    dc.definition AS Default_Value
FROM sys.default_constraints dc
JOIN sys.columns c ON dc.parent_object_id = c.object_id AND dc.parent_column_id = c.column_id
JOIN sys.tables t ON dc.parent_object_id = t.object_id
ORDER BY t.name;






USE CompanyDB;
GO

-- Check structure of Departments table
EXEC sp_columns @table_name = 'Departments';

-- Check structure of Employees table
EXEC sp_columns @table_name = 'Employees';

-- (Optional) If you later add a Salaries table or similar:
-- EXEC sp_columns @table_name = 'Salaries';





















USE CompanyDB;
GO
PRINT '====================================';
PRINT '🧠 DATA INTEGRITY AUDIT — CompanyDB';
PRINT '====================================';
PRINT '';

-------------------------------------------------------
-- 1️⃣ STRUCTURAL INTEGRITY CHECKS (SCHEMA LEVEL)
-------------------------------------------------------
PRINT '--- Structural Integrity Checks ---';

-- 1.1 List all constraints (PK, FK, UNIQUE)
SELECT 
    TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
ORDER BY TABLE_NAME, CONSTRAINT_TYPE;

-- 1.2 List all CHECK constraints
SELECT 
    t.TABLE_NAME,
    c.CONSTRAINT_NAME,
    cc.CHECK_CLAUSE
FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS AS cc
INNER JOIN INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE AS c
    ON cc.CONSTRAINT_NAME = c.CONSTRAINT_NAME
INNER JOIN INFORMATION_SCHEMA.TABLES AS t
    ON c.TABLE_NAME = t.TABLE_NAME
ORDER BY t.TABLE_NAME;

-- 1.3 List all FOREIGN KEYS
SELECT 
    fk.name AS FK_Name,
    OBJECT_NAME(fk.parent_object_id) AS Child_Table,
    c1.name AS Child_Column,
    OBJECT_NAME(fk.referenced_object_id) AS Parent_Table,
    c2.name AS Parent_Column
FROM sys.foreign_keys AS fk
INNER JOIN sys.foreign_key_columns AS fkc ON fk.object_id = fkc.constraint_object_id
INNER JOIN sys.columns AS c1 ON fkc.parent_object_id = c1.object_id AND fkc.parent_column_id = c1.column_id
INNER JOIN sys.columns AS c2 ON fkc.referenced_object_id = c2.object_id AND fkc.referenced_column_id = c2.column_id
ORDER BY Child_Table;

PRINT '';
PRINT '✅ Structural rules found — checking data consistency next...';
PRINT '';

-------------------------------------------------------
-- 2️⃣ DATA INTEGRITY CHECKS (DATA LEVEL)
-------------------------------------------------------
PRINT '--- Data Integrity Checks ---';

-- 2.1 Check for Orphan Foreign Keys (Employees without valid Dept)
PRINT 'Checking for orphan employees...';
SELECT e.EmpID, e.EmpName, e.DeptID
FROM Employees e
LEFT JOIN Departments d ON e.DeptID = d.DeptID
WHERE d.DeptID IS NULL;

-- 2.2 Check for Duplicate EmpID
PRINT 'Checking for duplicate EmpIDs...';
SELECT EmpID, COUNT(*) AS DuplicateCount
FROM Employees
GROUP BY EmpID
HAVING COUNT(*) > 1;

-- 2.3 Check for Nulls in Important Columns
PRINT 'Checking for NULLs in important columns...';
SELECT *
FROM Employees
WHERE EmpName IS NULL OR Salary IS NULL OR DeptID IS NULL;

-- 2.4 Check for Invalid Salaries (less than 20,000)
PRINT 'Checking for invalid salaries (< 20000)...';
SELECT *
FROM Employees
WHERE Salary < 20000;

-- 2.5 Check for Departments with Low Budget (less than 50,000)
PRINT 'Checking for invalid department budgets (< 50000)...';
SELECT *
FROM Departments
WHERE Budget < 50000;

-- 2.6 Check if each Department with Employees has a budget
PRINT 'Checking for departments with employees but no budget...';
SELECT DISTINCT d.DeptID, d.DeptName, d.Budget
FROM Departments d
JOIN Employees e ON d.DeptID = e.DeptID
WHERE d.Budget IS NULL OR d.Budget <= 0;

PRINT '';
PRINT '====================================';
PRINT '✅ Data Integrity Audit Completed';
PRINT '====================================';
GO
