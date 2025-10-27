-- trick no. 9



create table tblpivot
(
store varchar(10),
category varchar(15),
sales int
)

insert into tblpivot
values
('store1','senior',10),
('store1','adult',11),
('store1','kids',7),
('store2','senior',20),
('store2','kids',5),
('store2','adult',10)


select * from tblpivot


select * from
tblpivot
pivot(
sum(sales)
for category in ([senior],[adult],[kids])

)as PVT


SELECT store, category, sales
FROM
(
    SELECT store, senior, adult, kids
    FROM tblpivot
    PIVOT (
        SUM(sales)
        FOR category IN ([senior],[adult],[kids])
    ) AS PVT
) AS src
UNPIVOT
(
    sales FOR category IN ([senior], [adult], [kids])
) AS unpvt;
