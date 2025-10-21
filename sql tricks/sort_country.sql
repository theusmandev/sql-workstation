--trick 55


create table country1
(
country varchar(40)
)

insert into country1
values
('Iran'),
('Pakistan'),
('Afghanistan'),
('India'),
('Bangladesh'),
('Saudia Arabia')


ALTER TABLE country1
ALTER COLUMN country VARCHAR(60);


select * from country1


SELECT * 
FROM country1
ORDER BY 
    CASE 
        WHEN country = 'Pakistan' THEN 0 
        ELSE 1 
    END;


select * from country1
order by 
case
when country='Pakistan' then 0
when country='Saudia Arabia' then 1
else 2
end




SELECT * 
FROM country1
ORDER BY 
    CHARINDEX(country, 'Pakistan,Saudia Arabia') desc

SELECT *
FROM country1
ORDER BY 
    IIF(country = 'Pakistan', 0, 
        IIF(country = 'Saudia Arabia', 1, 2));














-- Mapping table
CREATE TABLE country_order (
    country VARCHAR(50),
    sort_order INT
);

INSERT INTO country_order VALUES
('Pakistan', 0),
('Saudia Arabia', 1);

-- Join and sort
SELECT c.*
FROM country1 c
LEFT JOIN country_order o ON c.country = o.country
ORDER BY o.sort_order, c.country;
