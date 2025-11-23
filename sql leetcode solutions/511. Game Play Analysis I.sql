 -- Activity table create karo

CREATE TABLE Activity_511_Game_Play_Analysis(

    player_id INT,

    device_id INT,

    event_date DATE,

    games_played INT,

    CONSTRAINT PK_Activity PRIMARY KEY (player_id, event_date)

);



-- Sample data insert karo

INSERT INTO Activity_511_Game_Play_Analysis(player_id, device_id, event_date, games_played) VALUES

(1, 2, '2016-03-01', 5),

(1, 2, '2016-05-02', 6),

(2, 3, '2017-06-25', 1),

(3, 1, '2016-03-02', 0),

(3, 4, '2018-07-03', 5);



select * from Activity_511_Game_Play_Analysis







SELECT 

    player_id,

    MIN(event_date) AS first_login

FROM Activity_511_Game_Play_Analysis

GROUP BY player_id;

