CREATE TABLE Employees_1873_Calculate_Special_Bonus (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT
);


INSERT INTO Employees_1873_Calculate_Special_Bonus (employee_id, name, salary) VALUES
(2, 'Meir', 3000),
(3, 'Michael', 3800),
(7, 'Addilyn', 7400),
(8, 'Juan', 6100),
(9, 'Kannon', 7700);


select * from Employees_1873_Calculate_Special_Bonus


select employee_id,
case when employee_id %2=1
and name not like 'M%'
then salary
else  0
end
as bonus
from Employees_1873_Calculate_Special_Bonus
order by employee_id


with cte
as
(
select employee_id,
case when employee_id%2=1
and
name not like 'M%'
then salary
else 0
end
as bonus
from Employees_1873_Calculate_Special_Bonus
)

select * from cte
order by employee_id
