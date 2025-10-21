declare @var varchar(40) ='fsd,,d,d,,,,,,df,,,fa,gt,ff,ef,,,'

select replace(replace(replace(@var,',','*,'),',*',''),'*,',',') as replace_char




--alternatives

DECLARE @var VARCHAR(40) ='fsd,,d,d,,,,,,df,,,fa,gt,ff,ef,,,';

SELECT STRING_AGG(value, ',') AS CleanedString
FROM STRING_SPLIT(@var, ',')
WHERE value <> '';




DECLARE @var VARCHAR(40) = 'fsd,,d,d,,,,,,df,,,fa,gt,ff,ef,,,';
SELECT value
FROM STRING_SPLIT(@var, ',');




DECLARE @var VARCHAR(100) = 'fsd,,d,d,,,,,,df,,,fa,gt,ff,ef,,,';

WITH CleanCTE AS (
    SELECT REPLACE(@var, ',,', ',') AS val
    UNION ALL
    SELECT REPLACE(val, ',,', ',')
    FROM CleanCTE
    WHERE val LIKE '%,,%'
)
SELECT TOP 1 val AS CleanedString
FROM CleanCTE
ORDER BY LEN(val);




DECLARE @var VARCHAR(100) = 'fsd,,d,d,,,,,,df,,,fa,gt,ff,ef,,,';

WHILE CHARINDEX(',,', @var) > 0
    SET @var = REPLACE(@var, ',,', ',');

SELECT @var AS CleanedString;














DECLARE @var VARCHAR(100) = 'fsd,,d,d,,,,,,df,,,fa,gt,ff,ef,,,';

WITH CleanCTE AS (
    SELECT REPLACE(@var, ',,', ',') AS val
    UNION ALL
    SELECT REPLACE(val, ',,', ',')
    FROM CleanCTE
    WHERE val LIKE '%,,%'
)
select * from CleanCTE


--SELECT TOP 1 val AS CleanedString
--FROM CleanCTE
--ORDER BY LEN(val);
