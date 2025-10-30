
-- Create the Employees table
CREATE TABLE Employees_1978_Employees_Whose_Manager_Left_the_Company (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT NULL,
    salary INT
);

-- Insert sample data
INSERT INTO Employees_1978_Employees_Whose_Manager_Left_the_Company (employee_id, name, manager_id, salary) VALUES
(3,  'Mila',       9,   60301),
(12, 'Antonella',  NULL, 31000),
(13, 'Emery',      NULL, 67084),
(1,  'Kalel',      11,   21241),
(9,  'Mikaela',    NULL, 50937),
(11, 'Joziah',     6,    28485);

-- View the data
SELECT * FROM Employees_1978_Employees_Whose_Manager_Left_the_Company;


select employee_id
from Employees_1978_Employees_Whose_Manager_Left_the_Company
where salary < 30000
and
manager_id is not null
and
manager_id not in (select employee_id from Employees_1978_Employees_Whose_Manager_Left_the_Company)
order by 
employee_id


--alternative
SELECT e.employee_id
FROM Employees_1978_Employees_Whose_Manager_Left_the_Company e
LEFT JOIN Employees_1978_Employees_Whose_Manager_Left_the_Company m
    ON e.manager_id = m.employee_id
WHERE e.salary < 30000
  AND e.manager_id IS NOT NULL
  AND m.employee_id IS NULL
ORDER BY e.employee_id;
