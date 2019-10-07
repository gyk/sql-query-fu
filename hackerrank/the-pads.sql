select S
from
(
    (
        select
            concat(Name, '(', left(Occupation, 1), ')') as S,
            0 as O1, Name as O2
        from OCCUPATIONS
    )
    union all
    (
        select
            concat('There are a total of ', count(1), ' ', lower(Occupation), 's.') as S,
            count(1) as O1, Occupation as O2
        from OCCUPATIONS
        group by Occupation
    )
) as T
order by O1, O2

# WTH, you just need to write two SELECTs!
