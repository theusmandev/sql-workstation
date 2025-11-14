 CREATE TABLE Scores_178_Rank_Scores (

    id INT PRIMARY KEY,

    score DECIMAL(4,2)

);





INSERT INTO Scores_178_Rank_Scores (id, score) VALUES

(1, 3.50),

(2, 3.65),

(3, 4.00),

(4, 3.85),

(5, 4.00),

(6, 3.65);





select * from Scores_178_Rank_Scores







SELECT score,

       DENSE_RANK() OVER (ORDER BY score DESC) AS rank

FROM Scores_178_Rank_Scores

ORDER BY score DESC;













