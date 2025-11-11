

-- Create logs table
CREATE TABLE logs_3451_Find_Invalid_IP_Addresses (
    log_id INT PRIMARY KEY,
    ip VARCHAR(50),
    status_code INT
);

-- Insert sample data
INSERT INTO logs_3451_Find_Invalid_IP_Addresses (log_id, ip, status_code) VALUES
(1, '192.168.1.1',   200),
(2, '256.1.2.3',     404),
(3, '192.168.001.1', 200),
(4, '192.168.1.1',   200),
(5, '192.168.1',     500),
(6, '256.1.2.3',     404),
(7, '192.168.001.1', 200);

-- View data
SELECT * FROM logs_3451_Find_Invalid_IP_Addresses;




select 
ip,
count(*) as invalid_count
from logs_3451_Find_Invalid_IP_Addresses
where
len(ip) - len(replace(ip,'.',''))+1<>4
or
ip like '%.0%' or ip like '0%.%' or ip like '%.00%' or ip like '%.000%'
or
   ip LIKE '%.256%' OR ip LIKE '256.%' OR ip LIKE '%.257%' OR ip LIKE '%.258%' OR ip LIKE '%.259%'
    OR ip LIKE '%.300%' OR ip LIKE '300.%'  -- just covering likely invalids
group by ip
order by invalid_count desc,ip desc





SELECT  ip, COUNT(*) AS 'invalid_count'
FROM logs_3451_Find_Invalid_IP_Addresses
WHERE 
    CONCAT(' .', ip) LIKE '%.0%'
    OR
    LEN(ip) - LEN(REPLACE(ip, '.', '')) != 3
    OR
    (SELECT COUNT(*) FROM STRING_SPLIT(ip, '.') WHERE  value < 0 OR value > 255) > 0
GROUP BY ip
ORDER BY COUNT(*) DESC, ip DESC











SELECT  
    ip, 
    COUNT(*) AS invalid_count
FROM logs_3451_Find_Invalid_IP_Addresses
WHERE 
    -- 1️⃣ Invalid if any octet has leading zeros
    CONCAT('.', ip) LIKE '%.0%' 

    OR
    -- 2️⃣ Invalid if not exactly 4 octets (3 dots)
    LEN(ip) - LEN(REPLACE(ip, '.', '')) != 3 

    OR
    -- 3️⃣ Invalid if any octet < 0 or > 255
    (
        SELECT COUNT(*) 
        FROM STRING_SPLIT(ip, '.') 
        WHERE TRY_CAST(value AS INT) < 0 
           OR TRY_CAST(value AS INT) > 255
           OR TRY_CAST(value AS INT) IS NULL
    ) > 0
GROUP BY ip
ORDER BY invalid_count DESC, ip DESC;















SELECT TRY_CAST('123' AS INT) AS Result1,    
       TRY_CAST('abc' AS INT) AS Result2;    
