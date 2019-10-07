select cast(round(LAT_N, 4) as numeric(18, 4))
from
(
    select row_number() over (order by LAT_N) as rid, LAT_N
    from STATION
) as T
where rid = (((select count(1) from STATION) + 1) / 2)
