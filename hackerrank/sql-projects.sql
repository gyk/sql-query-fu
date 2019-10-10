# MySQL solution
select S, max(E)
from
(
    select
        @start_date := if(@end_date = Start_Date, @start_date, Start_Date) as S,
        @end_date := End_Date as E
    from Projects, (select @start_date := NULL, @end_date := NULL) as init
    order by Start_Date
) as T
group by S
order by datediff(max(E), S), S
