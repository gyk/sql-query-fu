# If you use the ORDER BY clause and you don’t specify a ROWS or RANGE clause, then the default
# RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW is used.

# Q.0
select
    name,
    sum(weight) over (order by name rows unbounded preceding) as running_total_weight
from cats
order by name

# Q.1
select
    name,
    breed,
    sum(weight) over (partition by breed order by name rows unbounded preceding)
        as running_total_weight
from cats
order by breed, name

# Q.2
select
    name,
    weight,
    avg(weight) over (order by weight rows between 1 preceding and 1 following) as average_weight
from cats
order by weight

# Q.3
select
    name,
    sum(weight) over (order by weight desc rows unbounded preceding) as running_total_weight
from cats
order by weight desc
