 -- Users table (MS SQL Server version)

CREATE TABLE Users (

    users_id INT PRIMARY KEY,

    banned VARCHAR(3),   -- 'Yes' or 'No'

    role VARCHAR(10)     -- 'client', 'driver', 'partner'

);



INSERT INTO Users (users_id, banned, role) VALUES

(1, 'No', 'client'),

(2, 'Yes', 'client'),

(3, 'No', 'client'),

(4, 'No', 'client'),

(10, 'No', 'driver'),

(11, 'No', 'driver'),

(12, 'No', 'driver'),

(13, 'No', 'driver');





-- Trips table (MS SQL Server version)

CREATE TABLE Trips (

    id INT PRIMARY KEY,

    client_id INT,

    driver_id INT,

    city_id INT,

    status VARCHAR(25),   -- 'completed', 'cancelled_by_driver', 'cancelled_by_client'

    request_at DATE       -- store as DATE instead of VARCHAR

);



INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES

(1, 1, 10, 1, 'completed', '2013-10-01'),

(2, 2, 11, 1, 'cancelled_by_driver', '2013-10-01'),

(3, 3, 12, 6, 'completed', '2013-10-01'),

(4, 4, 13, 6, 'cancelled_by_client', '2013-10-01'),

(5, 1, 10, 1, 'completed', '2013-10-02'),

(6, 2, 11, 6, 'completed', '2013-10-02'),

(7, 3, 12, 6, 'completed', '2013-10-02'),

(8, 2, 12, 12, 'completed', '2013-10-03'),

(9, 3, 10, 12, 'completed', '2013-10-03'),

(10, 4, 13, 12, 'cancelled_by_driver', '2013-10-03');















SELECT 

    t.request_at AS Day,

    CAST(

        SUM(CASE WHEN t.status LIKE 'cancelled%' THEN 1 ELSE 0 END) * 1.0 

        / COUNT(*) 

        AS DECIMAL(10,2)

    ) AS CancellationRate

FROM Trips t

JOIN Users c ON t.client_id = c.users_id AND c.banned = 'No'

JOIN Users d ON t.driver_id = d.users_id AND d.banned = 'No'

WHERE t.request_at BETWEEN '2013-10-01' AND '2013-10-03'

GROUP BY t.request_at

ORDER BY t.request_at;

