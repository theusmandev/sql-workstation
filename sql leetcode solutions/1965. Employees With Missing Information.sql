
-- Create Employees table
CREATE TABLE Employees_1965_Employees_With_Missing_Information (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Create Salaries table
CREATE TABLE Salaries_1965_Employees_With_Missing_Information (
    employee_id INT PRIMARY KEY,
    salary INT
);

-- Insert sample data into Employees
INSERT INTO Employees_1965_Employees_With_Missing_Information (employee_id, name) VALUES
(2, 'Crew'),
(4, 'Haven'),
(5, 'Kristian');

-- Insert sample data into Salaries
INSERT INTO Salaries_1965_Employees_With_Missing_Information (employee_id, salary) VALUES
(5, 76071),
(1, 22517),
(4, 63539);

-- View data
SELECT * FROM Employees_1965_Employees_With_Missing_Information;
SELECT * FROM Salaries_1965_Employees_With_Missing_Information;


select employee_id
from Employees_1965_Employees_With_Missing_Information
where employee_id not in(
select employee_id from Salaries_1965_Employees_With_Missing_Information
)

union
select employee_id
from Salaries_1965_Employees_With_Missing_Information
where employee_id not in(
select employee_id from Employees_1965_Employees_With_Missing_Information
)
order by 
employee_id