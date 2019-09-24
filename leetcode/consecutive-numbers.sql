SELECT DISTINCT(Num) AS ConsecutiveNums
FROM (
    SELECT
        Num,
        @count := IF(@prev = Num, @count + 1, 1) AS ConsecutiveCount,
        @prev := Num
    FROM Logs, (SELECT @count := 0, @prev := NULL) AS init
) AS updating
WHERE ConsecutiveCount >= 3
