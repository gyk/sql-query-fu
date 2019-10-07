select [Doctor], [Professor], [Singer], [Actor]
from
(
    select Name, Occupation, row_number() over (partition by Occupation order by Name) as r
    from OCCUPATIONS
) as T
pivot (max(Name) for Occupation in ([Doctor], [Professor], [Singer], [Actor])) as P
