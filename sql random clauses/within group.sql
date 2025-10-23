
create database sql_random_clauses


IF OBJECT_ID('Students1', 'U') IS NOT NULL
    DROP TABLE Students;
GO






-- Create table
CREATE TABLE Students1 (
    class CHAR(1),
    name VARCHAR(50),
    score INT
);

-- Insert sample data
INSERT INTO Students1 (class, name, score) VALUES
('A', 'Ali', 85),
('A', 'Sara', 95),
('A', 'Usman', 75),
('B', 'Ayesha', 88),
('B', 'Bilal', 90);

select * from Students1





select 
class,
STRING_AGG(name,',') 
within group (order by score desc) as names_by_scores
from students1
group by class











SELECT TOP 3 emp_name, salary
FROM Employees
ORDER BY (SELECT NULL);
