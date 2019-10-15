-- https://pgexercises.com/questions/recursive/

-- getupward
with recursive RecommendationChain (recommender)
as
(
    select 27
    union all
    select recommendedby
    from RecommendationChain
    join cd.members
    on recommender = memid
)
select recommender, firstname, surname
from RecommendationChain
join cd.members
on recommender = memid
where recommender <> 27
order by memid


-- getdownward
with recursive DownwardRecommendationChain (recommended)
as
(
    select 1
    union all
    select memid
    from cd.members
    join DownwardRecommendationChain
    on recommendedby = recommended
)
select memid, firstname, surname
from DownwardRecommendationChain
join cd.members
on recommended = memid
where recommended <> 1
order by memid


-- getupwardall
with recursive RecommendationChainAny (member, recommender)
as
(
    select member, recommendedby as recommender
    from
        (select 12 as member union select 22) as M
    join cd.members
    on member = memid

    union all

    select R.member, M.recommendedby
    from RecommendationChainAny R
    join cd.members M
    on R.recommender = M.memid  and M.recommendedby is not null 
)
select member, recommender, firstname, surname
from RecommendationChainAny
join cd.members
on recommender = memid
order by member, recommender desc
