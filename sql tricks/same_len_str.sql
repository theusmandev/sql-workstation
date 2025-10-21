--trick 53

declare @var varchar(10) = '4'
select right(('0000'+@var),4) as same_len_str



-- alternatives

declare @var varchar(10)= '40'
select right((replicate('0',4)+@var),4) as same_len_str



DECLARE @var INT = 40000000;
SELECT FORMAT(@var, '0000') AS same_len_str;



declare @var varchar(10) = 4
select (concat('0000',@var),4) as same_len_str





