 CREATE TABLE Logs_180_Consecutive_Numbers (

    id INT IDENTITY(1,1) PRIMARY KEY,

    num VARCHAR(50)

);





INSERT INTO Logs_180_Consecutive_Numbers (num) VALUES

('1'),

('1'),

('1'),

('2'),

('1'),

('2'),

('2');





select * from Logs_180_Consecutive_Numbers





SELECT DISTINCT l1.num AS ConsecutiveNums

FROM Logs_180_Consecutive_Numbers l1

JOIN Logs_180_Consecutive_Numbers l2 ON l1.id = l2.id - 1

JOIN Logs_180_Consecutive_Numbers l3 ON l2.id = l3.id - 1

WHERE l1.num = l2.num

  AND l2.num = l3.num;

