 CREATE TABLE Employee_177_Nth_Highest_Salary (

    id INT PRIMARY KEY,

    salary INT

);



INSERT INTO Employee_177_Nth_Highest_Salary (id, salary) VALUES

(1, 100),

(2, 200),

(3, 300);





select * from Employee_177_Nth_Highest_Salary









CREATE FUNCTION getNthHighestSalary(@N INT)

RETURNS INT

AS

BEGIN

    RETURN (

        SELECT MIN(salary)

        FROM (

            SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk

            FROM Employee_177_Nth_Highest_Salary

        ) AS ranked

        WHERE rnk = @N

    );

END;



SELECT dbo.getNthHighestSalary(1);