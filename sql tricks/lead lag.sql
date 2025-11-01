--trick no. 10

CREATE TABLE Employees10 (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Salary INT,
    JoiningDate DATE
);

INSERT INTO Employees10 (EmployeeID, Name, Salary, JoiningDate)
VALUES
(1, 'Ali', 50000, '2023-01-10'),
(2, 'Sara', 60000, '2023-02-15'),
(3, 'Ahmed', 55000, '2023-03-20'),
(4, 'Zara', 70000, '2023-04-25'),
(5, 'Bilal', 65000, '2023-05-30');


select * from Employees10


SELECT 
    EmployeeID,
    Name,
    Salary,
    JoiningDate,
    LAG(JoiningDate, 1, Null) OVER (ORDER BY JoiningDate) AS InterviewDay,
    lead(JoiningDate,1,null) over (order by joiningDate) as SecondDay
FROM Employees10
ORDER BY JoiningDate;

