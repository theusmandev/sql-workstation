 CREATE TABLE Person_182_Duplicate_Emails (

    id INT PRIMARY KEY,

    email VARCHAR(255) NOT NULL

);



-- Sample Data Insert

INSERT INTO Person_182_Duplicate_Emails (id, email) VALUES

(1, 'a@b.com'),

(2, 'c@d.com'),

(3, 'a@b.com');





select * from Person_182_Duplicate_Emails



SELECT email AS Email

FROM Person_182_Duplicate_Emails

GROUP BY email

HAVING COUNT(email) > 1;

