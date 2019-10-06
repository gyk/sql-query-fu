# Q.0
select row_number() over (order by color, name) as unique_number, name, color
from cats
order by unique_number

# Q.1
#
# Pitfall: Do not put `order by name` inside the `over` clause.
select rank() over (order by weight desc) as ranking, weight, name
from cats
order by ranking, name

# Q.2
select dense_rank() over (order by age desc) as r, name, age
from cats
order by r, name

# Q.3
select name, weight, 100 * percent_rank() over (order by weight) as percent
from cats
order by weight

# Q.4
select name, weight, cast(100 * cume_dist() over (order by weight) as int) as percent
from cats
order by weight
