# MySQL solution

# Solution 1
select id, age, coins_needed, `power`
from
(
    select id, age, coins_needed, `power`
    from Wands
    left join Wands_Property
    using (code)
    where not is_evil
) as T
where not exists (
    select 1
    from Wands
    left join Wands_Property
    using (code)
    where T.power = `power` and T.age = age and coins_needed < T.coins_needed
)
order by `power` desc, age desc


# Solution 2
select T1.id, T2.age, T2.coins_needed, T2.power
from
(
    select id, age, coins_needed, power
    from Wands
    left join Wands_Property
    using (code)
) as T1
right join
(
    select age, min(coins_needed) as coins_needed, `power`
    from
    (
        select age, coins_needed, `power`
        from Wands
        left join Wands_Property
        using (code)
        where not is_evil
    ) as Temp
    group by `power`, age
) as T2
using (power, age, coins_needed)
order by T1.power desc, T1.age desc
