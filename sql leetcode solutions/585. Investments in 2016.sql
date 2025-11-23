 -- Table create karna

CREATE TABLE Insurance_585_Investments_in_2016 (

    pid INT PRIMARY KEY,

    tiv_2015 FLOAT,

    tiv_2016 FLOAT,

    lat FLOAT NOT NULL,

    lon FLOAT NOT NULL

);



-- Example data insert karna

INSERT INTO Insurance_585_Investments_in_2016  (pid, tiv_2015, tiv_2016, lat, lon) VALUES

(1, 10, 5, 10, 10),

(2, 20, 20, 20, 20),

(3, 10, 30, 20, 20),

(4, 10, 40, 40, 40);





select * from Insurance_585_Investments_in_2016 







SELECT 

    ROUND(SUM(tiv_2016), 2) AS tiv_2016

FROM Insurance_585_Investments_in_2016

WHERE tiv_2015 IN (

        SELECT tiv_2015

        FROM Insurance_585_Investments_in_2016

        GROUP BY tiv_2015

        HAVING COUNT(*) > 1

    )

  AND EXISTS (

        SELECT 1

        FROM (

            SELECT lat, lon

            FROM Insurance_585_Investments_in_2016

            GROUP BY lat, lon

            HAVING COUNT(*) = 1

        ) AS UniqueCities

        WHERE Insurance_585_Investments_in_2016.lat = UniqueCities.lat

          AND Insurance_585_Investments_in_2016.lon = UniqueCities.lon

    );

