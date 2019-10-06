# Q.0
select
    name, weight,
    ntile(2) over w as by_half,
    ntile(3) over w as thirds,
    ntile(4) over w as quartile
from cats
window w as (order by weight)
order by weight

# Q.1
select color, array_agg(name) as names
from cats
group by color
order by color desc

# Q.2
select
    breed,
    avg(weight) as average_weight,
    avg(weight) filter (where age > 1) as average_old_weight
from cats
group by breed
order by breed
