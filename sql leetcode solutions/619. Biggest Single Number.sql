 -- Drop table if already exists (optional)

DROP TABLE IF EXISTS MyNumbers_619_Biggest_Single_Number;



-- Create table

CREATE TABLE MyNumbers_619_Biggest_Single_Number (

    num INT

);



-- Insert sample data (example from problem)

INSERT INTO MyNumbers_619_Biggest_Single_Number (num) VALUES

(8),

(8),

(3),

(3),

(1),

(4),

(5),

(6);





select * from MyNumbers_619_Biggest_Single_Number 



SELECT MAX(num) AS num

FROM (

    SELECT num

    FROM MyNumbers_619_Biggest_Single_Number

    GROUP BY num

    HAVING COUNT(*) = 1

) AS single_numbers;

