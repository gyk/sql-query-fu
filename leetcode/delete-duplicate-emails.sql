# Pitfalls
#
# - "You can't specify target table 'Person' for update in FROM clause" error
# - Avoid copying the entire table into a temporary one

# Solution 1
DELETE FROM Person
WHERE Id NOT IN
(
    SELECT MinId AS Id FROM
    (
        SELECT MIN(Id) AS MinId
        FROM Person
        GROUP BY Email
    ) AS DuplicateIDs
)


# Solution 2
DELETE FROM Person
WHERE NOT EXIST
(
    SELECT * FROM
    (
        SELECT MIN(Id) AS MinId
        FROM Person
        GROUP BY Email
    ) AS DuplicateIDs
    WHERE Id = MinId
)
