--Write a query to find the second highest salary from an employee table without using MAX in subquery

CREATE TABLE Employees1 (
    EmpID INT PRIMARY KEY IDENTITY(1,1),
    EmpName VARCHAR(50),
    Salary INT
);


INSERT INTO Employees1 (EmpName, Salary)
VALUES 
('Ali', 50000),
('Sara', 70000),
('Ahmed', 90000),
('Aisha', 90000),  -- same highest salary (to test duplicates)
('Usman', 60000),
('Zain', 80000),
('Fatima', 75000);


select * from Employees1


SELECT EmpID, EmpName, Salary
FROM employees1
WHERE Salary = (SELECT MAX(Salary) FROM employees1);







SELECT TOP 1 EmpID, EmpName, Salary
FROM employees1
ORDER BY Salary DESC;




SELECT EmpID, EmpName, Salary
FROM employees1
WHERE Salary = (SELECT TOP 1 Salary FROM employees1 ORDER BY Salary DESC);










SELECT Salary
FROM employees1
WHERE Salary >= ALL (SELECT Salary FROM employees1);






SELECT EmpID, EmpName, Salary
FROM employees1
WHERE Salary >= ALL (SELECT Salary FROM employees1);











SELECT TOP 1 salary
FROM Employees1
WHERE salary NOT IN (SELECT TOP 1 salary FROM Employees1 ORDER BY salary DESC)
ORDER BY salary DESC;








SELECT salary
FROM (
  SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
  FROM Employees1
) ranked
WHERE rnk = 1;



SELECT EmpID, EmpName, Salary
FROM (
  SELECT *,
         DENSE_RANK() OVER (ORDER BY Salary DESC) AS rnk
  FROM Employees1
) ranked
WHERE rnk = 1;



select * from Employees1


WITH cte AS (
  SELECT 
      EmpID,
      EmpName,
      Salary,
      DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
  FROM Employees1
)
SELECT EmpID,
      EmpName,
      Salary
FROM cte
WHERE SalaryRank = 1;



SELECT EmpID, EmpName, Salary
FROM (
  SELECT 
      EmpID, 
      EmpName, 
      Salary,
      DENSE_RANK() OVER (ORDER BY Salary DESC) AS RankSalary
  FROM Employees1
) AS ranked
WHERE RankSalary = 1;



select top 1 empID,EmpName,Salary
from 
Employees1
order by salary desc






SELECT EmpID, EmpName, Salary
FROM Employees1
WHERE Salary = (
    SELECT TOP 1 Salary
    FROM Employees1
    ORDER BY Salary DESC
);


-- Using ALL (your query)
SELECT * 
FROM employees1
WHERE Salary >= ALL (SELECT Salary FROM employees1);







SELECT * 
FROM Employees1
WHERE Salary >= ANY (SELECT Salary FROM Employees1);



SELECT * 
FROM Employees1
WHERE Salary > ANY (SELECT Salary FROM Employees1);