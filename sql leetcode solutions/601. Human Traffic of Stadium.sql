 -- Stadium table create karna

CREATE TABLE Stadium_601_Human_Traffic_of_Stadium (

    id INT PRIMARY KEY,

    visit_date DATE,

    people INT

);



-- Sample data insert karna

INSERT INTO Stadium_601_Human_Traffic_of_Stadium (id, visit_date, people) VALUES

(1, '2017-01-01', 10),

(2, '2017-01-02', 109),

(3, '2017-01-03', 150),

(4, '2017-01-04', 99),

(5, '2017-01-05', 145),

(6, '2017-01-06', 1455),

(7, '2017-01-07', 199),

(8, '2017-01-09', 188);





select * from Stadium_601_Human_Traffic_of_Stadium



WITH cte AS (

    SELECT s.*,

           id - ROW_NUMBER() OVER (ORDER BY id) AS grp

    FROM Stadium_601_Human_Traffic_of_Stadium s

    WHERE people >= 100

),

grp_counts AS (

    SELECT grp, COUNT(*) AS cnt

    FROM cte

    GROUP BY grp

    HAVING COUNT(*) >= 3

)

SELECT c.id, c.visit_date, c.people

FROM cte c

JOIN grp_counts g

  ON c.grp = g.grp

ORDER BY c.visit_date;

