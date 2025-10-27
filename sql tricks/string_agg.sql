--trick no. 6

CREATE TABLE stringAgg
(
    deptID INT,
    deptName VARCHAR(20)
);

INSERT INTO stringAgg
VALUES
(1, 'sales'),
(2, 'marketing'),
(3, 'it'),
(4, NULL);




select * from stringAgg


select STRING_AGG(deptName,',') as aggregation
from stringAgg




SELECT STRING_AGG(ISNULL(deptName, 'NULL'), ',') AS aggregation
FROM stringAgg;

