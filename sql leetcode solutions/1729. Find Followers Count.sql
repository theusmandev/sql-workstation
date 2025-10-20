-- Create Followers table
CREATE TABLE Followers_1729_FollowerCount (
    user_id INT NOT NULL,
    follower_id INT NOT NULL,
    PRIMARY KEY (user_id, follower_id)
);

-- Insert sample data
INSERT INTO Followers_1729_FollowerCount (user_id, follower_id) VALUES
(0, 1),
(1, 0),
(2, 0),
(2, 1);


select * from Followers_1729_FollowerCount

select user_id, count(follower_id) as followers_count
from Followers_1729_FollowerCount
group by user_id
order by user_id


