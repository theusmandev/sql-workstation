CREATE TABLE user_content_3374_First_Letter_Capitalization_II (
    content_id INT PRIMARY KEY,
    content_text VARCHAR(255)
);


INSERT INTO user_content_3374_First_Letter_Capitalization_II (content_id, content_text)
VALUES
(1, 'hello world of SQL'),
(2, 'the QUICK-brown fox'),
(3, 'modern-day DATA science'),
(4, 'web-based FRONT-end development');


select * from user_content_3374_First_Letter_Capitalization_II










WITH SplitWords AS (
    SELECT 
        content_id,
        content_text,
        value AS word,
        ROW_NUMBER() OVER (PARTITION BY content_id ORDER BY (SELECT NULL)) AS word_order
    FROM user_content_3374_First_Letter_Capitalization_II
    CROSS APPLY STRING_SPLIT(content_text, ' ')
),
SplitHyphens AS (
    SELECT 
        content_id,
        word_order,
        word,
        CASE 
            WHEN word LIKE '%-%' THEN 1 ELSE 0
        END AS has_hyphen
    FROM SplitWords
),
WordParts AS (
    SELECT
        content_id,
        word_order,
        CASE 
            WHEN has_hyphen = 1 THEN part_order ELSE 1 END AS part_order,
        CASE 
            WHEN has_hyphen = 1 THEN value ELSE word END AS part
    FROM SplitHyphens
    OUTER APPLY (
        SELECT 
            value, 
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS part_order
        FROM STRING_SPLIT(word, '-')
    ) AS parts
),
Formatted AS (
    SELECT 
        content_id,
        word_order,
        STRING_AGG(
            CONCAT(
                UPPER(LEFT(part, 1)), 
                LOWER(SUBSTRING(part, 2, LEN(part)))
            ),
            '-'
        ) AS formatted_word
    FROM WordParts
    GROUP BY content_id, word_order
)
SELECT 
    u.content_id,
    u.content_text AS original_text,
    STRING_AGG(f.formatted_word, ' ') WITHIN GROUP (ORDER BY f.word_order) AS converted_text
FROM user_content_3374_First_Letter_Capitalization_II u
JOIN Formatted f 
    ON u.content_id = f.content_id
GROUP BY u.content_id, u.content_text
ORDER BY u.content_id;
