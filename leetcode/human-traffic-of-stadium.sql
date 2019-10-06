SELECT id, visit_date, people
FROM
(
    SELECT
        id, visit_date, people,
        @isConsecutive := IF(consecutive >= 3, 1,
            IF(consecutive > 0, @isConsecutive, 0)) AS isConsecutive
    FROM
    (
        SELECT
            *,
            (@consecutive := IF(people >= 100, @consecutive + 1, 0)) AS consecutive
        FROM stadium, (SELECT @consecutive := 0) AS init
    ) AS C,
    (SELECT @isConsecutive := 0) AS updating
    ORDER BY id DESC
) AS T
WHERE isConsecutive
ORDER BY id
