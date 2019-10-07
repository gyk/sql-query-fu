select
    N,
    if(P is null,
        'Root',
        if(not exists
            (
                select *
                from BST T2
                where T2.P = T1.N
            ),
            'Leaf',
            'Inner'))
from BST T1
order by N
