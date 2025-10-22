--trick no. 56


create table rivers
(
riverNames varchar(20)
)

insert into rivers
values
('Nile'),
('Blue Nile'),
('White Nile'),
('Rivi')

select * from rivers


select riverNames, len(riverNames)-len('Nile')
from rivers
where riverNames like '%Nile%'
order by len(riverNames)-len('Nile')


--alternatives

select  riverNames, soundex(riverNames),SOUNDEX('Nile')
from rivers

select  riverNames, difference(soundex(riverNames),SOUNDEX('Nile'))
from rivers
where riverNames like '%Nile%'
order by difference(soundex(riverNames),SOUNDEX('Nile')) desc



SELECT 
    riverNames,
    LEN(riverNames) - LEN(REPLACE(riverNames, 'Nile', '')) AS Diff
FROM rivers
WHERE riverNames LIKE '%Nile%'
ORDER BY Diff;





SELECT 
    riverNames,
    CHARINDEX('Nile', riverNames) AS FirstPos
FROM rivers
WHERE riverNames LIKE '%Nile%'
ORDER BY FirstPos;



SELECT 
    riverNames,
    PATINDEX('%Nile%', riverNames) AS MatchPosition
FROM rivers
WHERE riverNames LIKE '%Nile%'
ORDER BY MatchPosition;







WITH RiverDiffs AS (
    SELECT 
        riverNames,
        LEN(riverNames) - LEN(REPLACE(riverNames, 'Nile', '')) AS NileChars
    FROM rivers
    WHERE riverNames LIKE '%Nile%'
)
SELECT riverNames, NileChars
FROM RiverDiffs
ORDER BY NileChars;









SELECT 
    riverNames,
    DIFFERENCE(riverNames, 'Nile') AS Similarity
FROM rivers
ORDER BY Similarity DESC;







SELECT 
    riverNames,
    DIFFERENCE(riverNames, 'Nile') AS SoundSimilarity,
    CHARINDEX('Nile', riverNames) AS TextPosition
FROM rivers
WHERE DIFFERENCE(riverNames, 'Nile') >= 3
ORDER BY SoundSimilarity DESC, TextPosition;









SELECT riverNames
FROM rivers
WHERE CONTAINS(riverNames, 'FORMSOF(INFLECTIONAL, Nile)');




