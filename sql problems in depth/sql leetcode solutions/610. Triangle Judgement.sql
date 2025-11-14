 -- Create Table

CREATE TABLE Triangle_610_Triangle (

    x INT,

    y INT,

    z INT,

    CONSTRAINT pk_Triangle PRIMARY KEY (x, y, z)

);



-- Insert Sample Data

INSERT INTO Triangle_610_Triangle (x, y, z) VALUES

(13, 15, 30),

(10, 20, 15);





select * from Triangle_610_Triangle



SELECT 

    x, 

    y, 

    z,

    CASE 

        WHEN x + y > z AND x + z > y AND y + z > x 

            THEN 'Yes'

        ELSE 'No'

    END AS triangle

FROM Triangle_610_Triangle







