create table gender
(
genderid int,
gendername nvarchar(20)
)

go
insert into gender
values
(1,'Male'),
(3,'Nor Specified'),
(2,'Female')


select * from gender






SELECT * FROM Gender
GO
SELECT * FROM Gender
order by genderid


alter table gender
add constraint pk_gender_genderid primary key(genderid)



alter table gender
alter column genderid int not null



UPDATE STATISTICS gender;



with cte as( select * ,
ROW_NUMBER() over(partition by genderid order by genderid) as rn
from gender

)
delete from cte
where rn>1