 -- Table Create

CREATE TABLE Courses_596_Classes_With_at_Least_5_Students (

    student VARCHAR(50),

    class   VARCHAR(50),

    PRIMARY KEY (student, class) -- har student ek class me unique hoga

);



-- Sample Data Insert

INSERT INTO Courses_596_Classes_With_at_Least_5_Students (student, class) VALUES

('A', 'Math'),

('B', 'English'),

('C', 'Math'),

('D', 'Biology'),

('E', 'Math'),

('F', 'Computer'),

('G', 'Math'),

('H', 'Math'),

('I', 'Math');





select * from Courses_596_Classes_With_at_Least_5_Students 









SELECT class

FROM Courses_596_Classes_With_at_Least_5_Students 

GROUP BY class

HAVING COUNT(student) >= 5;



























