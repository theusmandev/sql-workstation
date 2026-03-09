CREATE TABLE employees_3580_Find_Consistently_Improving_Employees
 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100)
);


CREATE TABLE performance_reviews (
    review_id INT PRIMARY KEY,
    employee_id INT,
    review_date DATE,
    rating INT,
    
    FOREIGN KEY (employee_id) REFERENCES employees_3580_Find_Consistently_Improving_Employees(employee_id)
);



INSERT INTO employees_3580_Find_Consistently_Improving_Employees (employee_id, name)
VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Carol Davis'),
(4, 'David Wilson'),
(5, 'Emma Brown');



INSERT INTO performance_reviews (review_id, employee_id, review_date, rating)
VALUES
(1, 1, '2023-01-15', 2),
(2, 1, '2023-04-15', 3),
(3, 1, '2023-07-15', 4),
(4, 1, '2023-10-15', 5),

(5, 2, '2023-02-01', 3),
(6, 2, '2023-05-01', 2),
(7, 2, '2023-08-01', 4),
(8, 2, '2023-11-01', 5),

(9, 3, '2023-03-10', 1),
(10, 3, '2023-06-10', 2),
(11, 3, '2023-09-10', 3),
(12, 3, '2023-12-10', 4),

(13, 4, '2023-01-20', 4),
(14, 4, '2023-04-20', 4),
(15, 4, '2023-07-20', 4),

(16, 5, '2023-02-15', 3),
(17, 5, '2023-05-15', 2);


SELECT * FROM employees_3580_Find_Consistently_Improving_Employees;
SELECT * FROM performance_reviews;


WITH RankedReviews AS (
    SELECT
        employee_id,
        rating,
        ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS rn
    FROM performance_reviews
),

LastThree AS (
    SELECT 
        employee_id,
        MAX(CASE WHEN rn = 1 THEN rating END) AS latest_rating,
        MAX(CASE WHEN rn = 2 THEN rating END) AS middle_rating,
        MAX(CASE WHEN rn = 3 THEN rating END) AS earliest_rating,
        COUNT(*) AS total_reviews_in_window
    FROM RankedReviews
    WHERE rn <= 3
    GROUP BY employee_id
)

SELECT 
    e.employee_id,
    e.name,
    (l.latest_rating - l.earliest_rating) AS improvement_score
FROM LastThree l
JOIN employees_3580_Find_Consistently_Improving_Employees e
ON l.employee_id = e.employee_id
WHERE 
    l.total_reviews_in_window = 3
    AND l.latest_rating > l.middle_rating
    AND l.middle_rating > l.earliest_rating
ORDER BY 
    improvement_score DESC,
    e.name ASC;
