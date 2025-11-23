CREATE TABLE [3497_Analyze_Subscription_Conversion] 
(
    user_id INT,
    activity_date DATE,
    activity_type VARCHAR(20),
    activity_duration INT,
    CONSTRAINT PK_UserActivity PRIMARY KEY (user_id, activity_date, activity_type)
);



INSERT INTO [3497_Analyze_Subscription_Conversion]  (user_id, activity_date, activity_type, activity_duration) VALUES
(1, '2023-01-01', 'free_trial', 45),
(1, '2023-01-02', 'free_trial', 30),
(1, '2023-01-05', 'free_trial', 60),
(1, '2023-01-10', 'paid', 75),
(1, '2023-01-12', 'paid', 90),
(1, '2023-01-15', 'paid', 65),

(2, '2023-02-01', 'free_trial', 55),
(2, '2023-02-03', 'free_trial', 25),
(2, '2023-02-07', 'free_trial', 50),
(2, '2023-02-10', 'cancelled', 0),

(3, '2023-03-05', 'free_trial', 70),
(3, '2023-03-06', 'free_trial', 60),
(3, '2023-03-08', 'free_trial', 80),
(3, '2023-03-12', 'paid', 50),
(3, '2023-03-15', 'paid', 55),
(3, '2023-03-20', 'paid', 85),

(4, '2023-04-01', 'free_trial', 40),
(4, '2023-04-03', 'free_trial', 35),
(4, '2023-04-05', 'paid', 45),
(4, '2023-04-07', 'cancelled', 0);



select * from [3497_Analyze_Subscription_Conversion] 


with trial as(
select
user_id,
avg(cast(activity_duration as float)) as trial_avg
from [3497_Analyze_Subscription_Conversion] 
where activity_type = 'free_trial'
group by user_id
),
paid as(
select 
user_id,
avg(cast(activity_duration as float)) as paid_avg
from [3497_Analyze_Subscription_Conversion] 
where activity_type = 'paid'
group by user_id
),
converted as(
select distinct ua.user_id
from [3497_Analyze_Subscription_Conversion] ua
where ua.activity_type = 'paid'
and exists (
select 1 
from [3497_Analyze_Subscription_Conversion]  x
where x.user_id = ua.user_id
and x.activity_type = 'free_trial'
)
)
select 
c.user_id,
round(t.trial_avg,2) as trial_avg_duration,
round(p.paid_avg,2) as paid_avg_duration
from converted c
left join trial t on c.user_id=t.user_id
left join paid p on c.user_id=p.user_id
order by c.user_id






SELECT 
    user_id,
    ROUND(AVG(CASE WHEN activity_type = 'free_trial' THEN CAST(activity_duration AS FLOAT) END), 2) AS trial_avg_duration,
    ROUND(AVG(CASE WHEN activity_type = 'paid' THEN CAST(activity_duration AS FLOAT) END), 2) AS paid_avg_duration
FROM 
    [3497_Analyze_Subscription_Conversion]
WHERE 
    activity_type IN ('free_trial', 'paid')
GROUP BY 
    user_id
HAVING 
    COUNT(DISTINCT activity_type) = 2;