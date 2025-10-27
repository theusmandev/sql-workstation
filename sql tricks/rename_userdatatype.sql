-- trick no. 7


create table tblrename
(
Name varchar(20)
)

insert into tblrename
values
('usman'),
('hamza')


select * from  tblrename
select * from tablerename


execute sp_rename 'tblrename' , 'tablerename'



CREATE TYPE PhoneNumberType FROM VARCHAR(15) NOT NULL;

SELECT name, system_type_id, user_type_id, is_user_defined
FROM sys.types
WHERE is_user_defined = 1;

