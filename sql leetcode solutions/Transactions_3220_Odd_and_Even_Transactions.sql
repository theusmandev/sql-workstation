CREATE TABLE Transactions_3220_Odd_and_Even_Transactions (
    transaction_id INT PRIMARY KEY,
    amount INT,
    transaction_date DATE
);


INSERT INTO Transactions_3220_Odd_and_Even_Transactions (transaction_id, amount, transaction_date)
VALUES 
(1, 150, '2024-07-01'),
(2, 200, '2024-07-01'),
(3, 75,  '2024-07-01'),
(4, 300, '2024-07-02'),
(5, 50,  '2024-07-02'),
(6, 120, '2024-07-03');


select * from Transactions_3220_Odd_and_Even_Transactions


with summed as (
select 
transaction_date,
sum(case when amount %2=1 then amount else 0 end)
as odd_sum,
sum(case when amount%2=0 then amount else 0 end)
as even_sum
from Transactions_3220_Odd_and_Even_Transactions
group by transaction_date


)
select 
transaction_date,
isnull(odd_sum,0) as odd_sum,
isnull(even_sum,0) as even_sum

from summed
order by transaction_date
