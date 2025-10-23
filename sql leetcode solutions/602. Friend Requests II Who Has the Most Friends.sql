 -- Table create karna

CREATE TABLE RequestAccepted_602_Friend_Requests (

    requester_id INT,

    accepter_id INT,

    accept_date DATE,

    CONSTRAINT PK_Request PRIMARY KEY (requester_id, accepter_id)

);



-- Example data insert karna (same jo problem me diya hai)

INSERT INTO RequestAccepted_602_Friend_Requests (requester_id, accepter_id, accept_date)

VALUES 

(1, 2, '2016-06-03'),

(1, 3, '2016-06-08'),

(2, 3, '2016-06-08'),

(3, 4, '2016-06-09');







select * from RequestAccepted_602_Friend_Requests





SELECT TOP 1 id, COUNT(DISTINCT friend) AS num

FROM (

    SELECT requester_id AS id, accepter_id AS friend

    FROM RequestAccepted_602_Friend_Requests

    UNION ALL

    SELECT accepter_id AS id, requester_id AS friend

    FROM RequestAccepted_602_Friend_Requests

) AS all_friends

GROUP BY id

ORDER BY num DESC;



