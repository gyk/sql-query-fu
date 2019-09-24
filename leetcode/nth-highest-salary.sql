# Solution 1
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    DECLARE M INT;
    SET M = N - 1;
    RETURN (
        SELECT (
            SELECT DISTINCT Salary FROM Employee ORDER BY Salary DESC LIMIT 1 OFFSET M
        ) AS NthHighest
    );
END


# Solution 2
#
# The time complexity of Solution 1 seems to be `O(log(numRecords))` (being proportional to tree
# height). This solution is slower, with a complexity of `O(N * log(numRecords))` (is it?).
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    RETURN (
        SELECT Salary FROM Employee E1
        WHERE N = (
            SELECT COUNT(DISTINCT(E2.Salary)) FROM Employee E2
            WHERE E2.Salary >= E1.Salary
        )
        LIMIT 1
    );
END
