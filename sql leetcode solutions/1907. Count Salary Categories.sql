CREATE TABLE Accounts_1907_Count_Salary_Categories (
    account_id INT PRIMARY KEY,
    income INT
);


INSERT INTO Accounts_1907_Count_Salary_Categories (account_id, income) VALUES
(3, 108939),
(2, 12747),
(8, 87709),
(6, 91796);


select * from Accounts_1907_Count_Salary_Categories


WITH categorized AS (
    SELECT 
        CASE 
            WHEN income < 20000 THEN 'Low Salary'
            WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
            ELSE 'High Salary'
        END AS category
    FROM Accounts_1907_Count_Salary_Categories
)


SELECT 
    c.category,
    COUNT(a.category) AS accounts_count
FROM 
    (VALUES ('Low Salary'), ('Average Salary'), ('High Salary')) AS c(category)
LEFT JOIN categorized a
ON c.category = a.category
GROUP BY c.category;


