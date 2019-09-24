# Pitfalls:
#
# - HAVING, not WHERE, COUNT (filtering after aggregation)
# - COUNT(*)/COUNT(1) vs COUNT(expression) (null included vs non-null only)

SELECT Email
FROM Person
GROUP BY Email
HAVING COUNT(*) > 1
