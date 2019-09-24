# Solution 1
SELECT Day, ROUND(AVG(Cancelled), 2) AS 'Cancellation Rate'
FROM
(
    SELECT Request_at AS Day, (Status <> "completed") AS Cancelled
    FROM Trips
    JOIN Users AS UC
    ON Trips.Client_Id = UC.Users_Id
    JOIN Users AS UD
    ON Trips.Client_Id = UD.Users_Id
    WHERE UC.Banned = 'No' AND UD.Banned = 'No' AND
          '2013-10-01' <= Request_at AND Request_at <= '2013-10-03'
) AS T
GROUP BY Day


# Solution 2
SELECT Day, ROUND(AVG(Cancelled), 2) AS 'Cancellation Rate'
FROM
(
    SELECT Request_at AS Day, (Status <> "completed") AS Cancelled
    FROM Trips
    WHERE '2013-10-01' <= Request_at AND Request_at <= '2013-10-03' AND
        Client_Id NOT IN (
            SELECT Users_Id FROM Users WHERE Role = 'client' AND Banned = 'Yes'
        ) AND
        Client_Id NOT IN (
            SELECT Users_Id FROM Users WHERE Role = 'driver' AND Banned = 'Yes'
        )
) AS T
GROUP BY Day
