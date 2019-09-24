SELECT E1.Name AS Employee
FROM (
    Employee E1 INNER JOIN Employee E2
    ON E1.ManagerId = E2.Id
)
WHERE E1.Salary > E2.Salary
