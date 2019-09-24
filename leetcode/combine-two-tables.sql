# LEFT JOIN = LEFT OUTTER JOIN, keeps all records from the 1st table and insert NULL values for the
# 2nd table it doesn't match.
SELECT FirstName, LastName, City, State
FROM Person LEFT JOIN Address USING (PersonId)
