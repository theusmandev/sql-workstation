--trick no. 4



create table cancateNull
(
firstName varchar(20),
lastName varchar(20)
)

insert into cancateNull
values
('usman','ashraf'),
('falak','shabbir'),
('hamza',null)


select * from cancateNull


select firstName,lastName, firstName+lastName as FullName
from cancateNull



SELECT firstName, lastName,
       CONCAT_WS(' ', firstName, lastName) AS FullName
FROM concateNull;


exec sp_rename 'cancateNull','concateNUll'


select firstName,lastName,
concat(firstName,' ',lastName) as FullName
from concateNull