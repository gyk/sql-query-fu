# Pitfalls
# 
# 1. "Weather" is not sorted on "RecordDate"
# 2. "RecordDate" is not necessarily consecutive

# Solution 1
SELECT W1.Id
FROM Weather W1
JOIN Weather W2
ON DATE_SUB(W1.RecordDate, INTERVAL 1 DAY) = W2.RecordDate AND
   W1.Temperature > W2.Temperature


# Solution 2
SELECT Id
FROM (
    SELECT
        Id,
        DATEDIFF(RecordDate, @yesterday) = 1 AS IsYesterday,
        Temperature > @prev AS IsRising,
        @yesterday := RecordDate,
        @prev := Temperature
    FROM Weather, (SELECT @yesterday := NULL, @prev := NULL) AS init
    ORDER BY RecordDate ASC
) AS updating
WHERE IsYesterday AND IsRising
