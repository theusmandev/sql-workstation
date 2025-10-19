create database sql_tricks101


create table tblemployee1
(Name varchar(20),
Gender varchar(10)
)

insert into tblemployee1
values
('Usman','Male'),
('Hamza','Male')

select * from tblemployee1


WITH CTE AS (
    SELECT 
        Name,
        Gender,
        ROW_NUMBER() OVER (PARTITION BY Name, Gender ORDER BY (SELECT 0)) AS rownumber
    FROM tblemployee1
)

SELECT *
FROM CTE
WHERE rownumber > 1;
