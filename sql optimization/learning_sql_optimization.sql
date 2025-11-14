create database learn_sql_optimization

ALTER DATABASE sql_optimization
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

DROP DATABASE sql_optimization;


Create Table Employees
(
    Id int primary key identity,
    [Name] nvarchar(50),
    Email nvarchar(50),
    Department nvarchar(50)
)
Go

SET NOCOUNT ON
Declare @counter int = 1

While(@counter <= 100)
Begin
    Declare @Name nvarchar(50) = 'ABC ' + RTRIM(@counter)
    Declare @Email nvarchar(50) = 'abc' + RTRIM(@counter) + '@pragimtech.com'
    Declare @Dept nvarchar(10) = 'Dept ' + RTRIM(@counter)

    Insert into Employees (Name, Email, Department)
    values (@Name, @Email, @Dept)

    Set @counter = @counter + 1

    If(@Counter % 10 = 0)
        Print RTRIM(@Counter) + ' rows inserted'
End


select * from Employees

drop table Employees

truncate table employees






;WITH N AS
(
    SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM learn_sql_optimization..spt_values
)
SELECT TOP 1000000 n
INTO Numbers
FROM N;



INSERT INTO Employees(Name, Email, Department)
SELECT 
    'ABC ' + CAST(n AS NVARCHAR(50)),
    'abc' + CAST(n AS NVARCHAR(50)) + '@pragimtech.com',
    'Dept ' + CAST(n AS NVARCHAR(10))
FROM Numbers
WHERE n BETWEEN 1 AND 1000000;
