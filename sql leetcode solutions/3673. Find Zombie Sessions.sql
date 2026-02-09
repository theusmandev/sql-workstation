CREATE TABLE app_events_3673_Find_Zombie_Sessions (
    event_id INT PRIMARY KEY,
    user_id INT,
    event_timestamp DATETIME,
    event_type VARCHAR(50),
    session_id VARCHAR(50),
    event_value INT
);



INSERT INTO app_events_3673_Find_Zombie_Sessions (event_id, user_id, event_timestamp, event_type, session_id, event_value)
VALUES
-- Session S001 (Zombie candidate)
(1, 201, '2024-03-01 10:00:00', 'app_open',  'S001', NULL),
(2, 201, '2024-03-01 10:05:00', 'scroll',    'S001', 500),
(3, 201, '2024-03-01 10:10:00', 'scroll',    'S001', 750),
(4, 201, '2024-03-01 10:15:00', 'scroll',    'S001', 600),
(5, 201, '2024-03-01 10:20:00', 'scroll',    'S001', 800),
(6, 201, '2024-03-01 10:25:00', 'scroll',    'S001', 550),
(7, 201, '2024-03-01 10:30:00', 'scroll',    'S001', 900),
(8, 201, '2024-03-01 10:35:00', 'app_close', 'S001', NULL),

-- Session S002 (Has purchase)
(9, 202, '2024-03-01 11:00:00', 'app_open',  'S002', NULL),
(10,202, '2024-03-01 11:02:00', 'click',     'S002', NULL),
(11,202, '2024-03-01 11:05:00', 'scroll',    'S002', 400),
(12,202, '2024-03-01 11:08:00', 'click',     'S002', NULL),
(13,202, '2024-03-01 11:10:00', 'scroll',    'S002', 350),
(14,202, '2024-03-01 11:15:00', 'purchase',  'S002', 50),
(15,202, '2024-03-01 11:20:00', 'app_close', 'S002', NULL),

-- Session S003 (Click-to-scroll = 0.20)
(16,203, '2024-03-01 12:00:00', 'app_open',  'S003', NULL),
(17,203, '2024-03-01 12:10:00', 'scroll',    'S003', 1000),
(18,203, '2024-03-01 12:20:00', 'scroll',    'S003', 1200),
(19,203, '2024-03-01 12:25:00', 'click',     'S003', NULL),
(20,203, '2024-03-01 12:30:00', 'scroll',    'S003', 800),
(21,203, '2024-03-01 12:40:00', 'scroll',    'S003', 900),
(22,203, '2024-03-01 12:50:00', 'scroll',    'S003', 1100),
(23,203, '2024-03-01 13:00:00', 'app_close', 'S003', NULL),

-- Session S004 (Short & low scroll)
(24,204, '2024-03-01 14:00:00', 'app_open',  'S004', NULL),
(25,204, '2024-03-01 14:05:00', 'scroll',    'S004', 600),
(26,204, '2024-03-01 14:08:00', 'scroll',    'S004', 700),
(27,204, '2024-03-01 14:10:00', 'click',     'S004', NULL),
(28,204, '2024-03-01 14:12:00', 'app_close', 'S004', NULL);


select * from app_events_3673_Find_Zombie_Sessions





WITH SessionMetrics AS (
    SELECT 
        session_id,
        user_id,
        -- SQL Server mein DATEDIFF aise likhte hain: (unit, start, end)
        DATEDIFF(MINUTE, MIN(event_timestamp), MAX(event_timestamp)) AS session_duration_minutes,
        
        SUM(CASE WHEN event_type = 'scroll' THEN 1 ELSE 0 END) AS scroll_count,
        SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) AS click_count,
        SUM(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchase_count
    FROM app_events_3673_Find_Zombie_Sessions
    GROUP BY session_id, user_id
)

SELECT 
    session_id, 
    user_id, 
    session_duration_minutes, 
    scroll_count
FROM SessionMetrics
WHERE session_duration_minutes > 30
  AND scroll_count >= 5
  -- Click count ko 1.0 se multiply karne se wo automatic decimal/float ban jata hai
  AND (click_count * 1.0 / scroll_count) < 0.20
  AND purchase_count = 0
ORDER BY scroll_count DESC, session_id ASC;