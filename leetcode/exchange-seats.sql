# Solution 1
SELECT S.id, IF(SS.student IS NOT NULL, SS.student, S.student) AS student
FROM seat S
LEFT JOIN
(
    SELECT IF(id % 2 = 1, id + 1, id - 1) AS id, student
    FROM seat
) AS SS
ON S.id = SS.id
ORDER BY id


# Solution 2
SELECT
    CASE WHEN id % 2 = 0 THEN id - 1
         WHEN id = (SELECT COUNT(1) FROM seat) THEN ID
         ELSE id + 1
    END as id,
    student
FROM seat
ORDER BY id
