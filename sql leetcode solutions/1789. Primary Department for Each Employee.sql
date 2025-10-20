CREATE TABLE Employee_1789_Primary_Department_for_Each_Employee (
    employee_id INT,
    department_id INT,
    primary_flag VARCHAR(1),
    CONSTRAINT PK_Employee PRIMARY KEY (employee_id, department_id)
);



INSERT INTO Employee_1789_Primary_Department_for_Each_Employee (employee_id, department_id, primary_flag) VALUES
(1, 1, 'N'),
(2, 1, 'Y'),
(2, 2, 'N'),
(3, 3, 'N'),
(4, 2, 'N'),
(4, 3, 'Y'),
(4, 4, 'N');


select * from Employee_1789_Primary_Department_for_Each_Employee


select employee_id,department_id
from Employee_1789_Primary_Department_for_Each_Employee
where primary_flag='Y'
OR
employee_id in(
select employee_id
from Employee_1789_Primary_Department_for_Each_Employee
group by employee_id
having count(*) = 1
)