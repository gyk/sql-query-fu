# The solutions basically use the same techniques from Problem `second-highest-salary` and
# `nth-highest-salary`.

# Solution 1
SELECT D.Name AS Department, E1.Name AS Employee, E1.Salary
FROM Employee E1
JOIN Department D
ON E1.DepartmentId = D.Id
WHERE 3 >=
(
    SELECT COUNT(DISTINCT(E2.Salary))
    FROM Employee E2
    WHERE E2.Salary >= E1.Salary AND
          E2.DepartmentId = E1.DepartmentId           
)


# Solution 2
SELECT D.Name AS Department, T.Name AS Employee, T.Salary
FROM
(
    SELECT
        DepartmentId,
        Name,
        Salary,
        @rank := IF(DepartmentId = @depId, IF(Salary < @prevSalary, @rank + 1, @rank), 1) AS Rank,
        @depId := DepartmentId,
        @prevSalary := Salary
    FROM Employee, (SELECT @depId := NULL, @prevSalary := NULL, @rank := NULL) AS init
    ORDER BY DepartmentId, Salary DESC
) AS T
JOIN Department D
ON T.DepartmentId = D.Id
WHERE T.Rank <= 3
