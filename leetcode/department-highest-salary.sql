# Pitfalls
#
# - Use INNER JOIN rather than OUTER JOIN because "Department" can be empty
# - Don't accidentally select "Name" in the inner query
SELECT D.Name AS Department, E.Name AS Employee, E.Salary
FROM Employee E
JOIN Department D
ON E.DepartmentId = D.Id
JOIN
(
    SELECT DepartmentId, MAX(Salary) AS Salary
    FROM Employee
    GROUP BY DepartmentId
) AS MaxSalaries
ON E.Salary = MaxSalaries.Salary AND
   E.DepartmentId = MaxSalaries.DepartmentId
