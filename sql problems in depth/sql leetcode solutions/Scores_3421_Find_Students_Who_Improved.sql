-- Drop table if it already exists
IF OBJECT_ID('Scores', 'U') IS NOT NULL
    DROP TABLE Scores_3421_Find_Students_Who_Improved;
GO

-- Create the Scores table
CREATE TABLE Scores_3421_Find_Students_Who_Improved (
    student_id INT,
    subject VARCHAR(50),
    score INT CHECK (score BETWEEN 0 AND 100),
    exam_date DATE,
    CONSTRAINT PK_Scores PRIMARY KEY (student_id, subject, exam_date)
);

-- Insert sample data
INSERT INTO Scores_3421_Find_Students_Who_Improved (student_id, subject, score, exam_date) VALUES
(101, 'Math', 70, '2023-01-15'),
(101, 'Math', 85, '2023-02-15'),
(101, 'Physics', 65, '2023-01-15'),
(101, 'Physics', 60, '2023-02-15'),
(102, 'Math', 80, '2023-01-15'),
(102, 'Math', 85, '2023-02-15'),
(103, 'Math', 90, '2023-01-15'),
(104, 'Physics', 75, '2023-01-15'),
(104, 'Physics', 85, '2023-02-15');


select * from  Scores_3421_Find_Students_Who_Improved



WITH ScoreOrder AS (
    SELECT
        student_id,
        subject,
        score,
        exam_date,
        ROW_NUMBER() OVER (PARTITION BY student_id, subject ORDER BY exam_date ASC) AS rn_asc,
        ROW_NUMBER() OVER (PARTITION BY student_id, subject ORDER BY exam_date DESC) AS rn_desc
    FROM Scores_3421_Find_Students_Who_Improved
)
SELECT
    s1.student_id,
    s1.subject,
    s1.score AS first_score,
    s2.score AS latest_score
FROM ScoreOrder s1
JOIN ScoreOrder s2
    ON s1.student_id = s2.student_id
    AND s1.subject = s2.subject
    AND s1.rn_asc = 1
    AND s2.rn_desc = 1
WHERE s2.score > s1.score
ORDER BY s1.student_id, s1.subject;







