# Generates 2 to 1000
-- with numbers(i) as
-- (
--     select 2
--     union all
--     select i + 1
--     from numbers
--     where i < 1000
-- )

# Oracle solution
with numbers as
(
    select level + 1 as i from dual
    connect by level < 1000
)
select listagg(i, '&')
within group(order by i)
from numbers N
where not exists (
    select i from numbers
    where i < N.i and mod(N.i, i) = 0
);
