# Answer for MS SQL Server. Other DBMSs may not require calling `cast`.
select cast(
    round(sqrt(
        power(max(LAT_N) - min(LAT_N), 2) + power(max(LONG_W) - min(LONG_W), 2)), 4)
    as numeric(36, 4)
)
from STATION
