# LeetCode's MySQL doesn't support window functions
SELECT Score, Rank FROM
(
    SELECT Score, (@row := @row + 1) AS Rank
    FROM (SELECT DISTINCT Score FROM Scores ORDER BY Score DESC) AS S,
         (SELECT @row := 0) AS R
) AS SR
LEFT JOIN Scores
USING (Score)
ORDER BY Rank ASC
