# Q.0
select name, weight, ntile(4) over (order by weight) as weight_quartile
from cats
order by weight

# Q.1
select name, weight, coalesce(weight - lag(weight, 1) over (order by weight), 0) as weight_to_lose
from cats
order by weight

# Q.2
select
    name,
    breed,
    weight,
    coalesce(weight - lag(weight, 1) over (partition by breed order by weight), 0) as weight_to_lose
from cats
order by weight

# Q.3
#
# Or use `first_value(weight)`.
select name, color, min(weight) over (partition by color order by weight) as weight_by_color
from cats
order by color, name

# Q.4
select
    name,
    weight,
    breed,
    coalesce(cast(lead(weight, 1) over (partition by breed order by weight) as varchar), 'fattest cat') as next_heaviest
from cats
order by weight

# Q.5
select name, weight, coalesce(nth_value(weight, 4) over (order by weight), 99.9) as imagined_weight
from cats
order by weight

# Q.6
select
    distinct(breed),
    nth_value(weight, 2) over (partition by breed order by weight rows between unbounded preceding and 1 following)
        as imagined_weight
from cats
order by breed
