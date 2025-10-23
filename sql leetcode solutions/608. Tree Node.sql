 -- Step 1: Create the table

CREATE TABLE Tree608_Tree_Node (

    id INT PRIMARY KEY,

    p_id INT

);



-- Step 2: Insert sample data

INSERT INTO Tree608_Tree_Node (id, p_id) VALUES

(1, NULL),

(2, 1),

(3, 1),

(4, 2),

(5, 2);



-- Step 3: View the data

SELECT * FROM Tree608_Tree_Node;





SELECT 

    id,

    CASE

        WHEN p_id IS NULL THEN 'Root'

        WHEN id IN (SELECT DISTINCT p_id FROM Tree608_Tree_Node WHERE p_id IS NOT NULL) THEN 'Inner'

        ELSE 'Leaf'


    END AS Type

FROM Tree608_Tree_Node

ORDER BY id;

