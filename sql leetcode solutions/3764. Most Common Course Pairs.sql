CREATE TABLE course_completions_3764_Most_Common_Course_Pairs (
    user_id INT,
    course_id INT,
    course_name VARCHAR(255),
    completion_date DATE,
    course_rating INT,
    CONSTRAINT PK_course_completions
        PRIMARY KEY (user_id, course_id)
);



INSERT INTO course_completions_3764_Most_Common_Course_Pairs
(user_id, course_id, course_name, completion_date, course_rating)
VALUES
-- User 1 (Top Performer)
(1, 101, 'Python Basics',    '2024-01-05', 5),
(1, 102, 'SQL Fundamentals', '2024-02-10', 4),
(1, 103, 'JavaScript',       '2024-03-15', 5),
(1, 104, 'React Basics',     '2024-04-20', 4),
(1, 105, 'Node.js',          '2024-05-25', 5),
(1, 106, 'Docker',           '2024-06-30', 4),

-- User 2 (Top Performer)
(2, 101, 'Python Basics',    '2024-01-08', 4),
(2, 104, 'React Basics',     '2024-02-14', 5),
(2, 105, 'Node.js',          '2024-03-20', 4),
(2, 106, 'Docker',           '2024-04-25', 5),
(2, 107, 'AWS Fundamentals', '2024-05-30', 4),

-- User 3 (Not top performer – low avg rating)
(3, 101, 'Python Basics',    '2024-01-10', 3),
(3, 102, 'SQL Fundamentals', '2024-02-12', 3),
(3, 103, 'JavaScript',       '2024-03-18', 3),
(3, 104, 'React Basics',     '2024-04-22', 2),
(3, 105, 'Node.js',          '2024-05-28', 3),

-- User 4 (Not top performer – less courses)
(4, 101, 'Python Basics',    '2024-01-12', 5),
(4, 108, 'Data Science',     '2024-02-16', 5),
(4, 109, 'Machine Learning', '2024-03-22', 5);




select * from course_completions_3764_Most_Common_Course_Pairs






WITH TopPerformers AS (
    -- Step 1: High achievers
    SELECT user_id
    FROM course_completions_3764_Most_Common_Course_Pairs
    GROUP BY user_id
    HAVING COUNT(course_id) >= 5
       AND AVG(CAST(course_rating AS FLOAT)) >= 4
),

CourseTransitions AS (
    -- Step 2: Course sequence pairs
    SELECT 
        user_id,
        course_name AS first_course,
        LEAD(course_name) OVER (
            PARTITION BY user_id 
            ORDER BY completion_date
        ) AS second_course
    FROM course_completions_3764_Most_Common_Course_Pairs
    WHERE user_id IN (SELECT user_id FROM TopPerformers)
)

-- Step 3: Count most common transitions
SELECT 
    first_course,
    second_course,
    COUNT(*) AS transition_count
FROM CourseTransitions
WHERE second_course IS NOT NULL
GROUP BY first_course, second_course
ORDER BY transition_count DESC, first_course, second_course;
