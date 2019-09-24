# Pitfalls:
#
# 1. Returns NULL if there is no second highest
# 2. DISTINCT
SELECT (SELECT DISTINCT Salary FROM Employee ORDER BY Salary DESC LIMIT 1 OFFSET 1)
AS SecondHighestSalary
