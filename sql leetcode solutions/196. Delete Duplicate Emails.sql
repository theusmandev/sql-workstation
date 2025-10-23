 -- Person table

CREATE TABLE Person_196_Delete_Duplicate_Emails (

    id INT PRIMARY KEY,

    email VARCHAR(100) NOT NULL

);



-- Insert sample data

INSERT INTO Person_196_Delete_Duplicate_Emails  (id, email) VALUES

(1, 'john@example.com'),

(2, 'bob@example.com'),

(3, 'john@example.com');





select * from Person_196_Delete_Duplicate_Emails 



DELETE FROM Person_196_Delete_Duplicate_Emails

WHERE id NOT IN (

    SELECT MIN(id)

    FROM Person_196_Delete_Duplicate_Emails

    GROUP BY email

);

