# MS SQL solution
with CreatedChallenges (hacker_id, cnt)
as
(
    select hacker_id, count(1) as cnt
    from Challenges
    group by hacker_id
)
select H.hacker_id, name, cnt
from Hackers H
join CreatedChallenges
on H.hacker_id = CreatedChallenges.hacker_id
where (cnt = (select max(cnt) from CreatedChallenges)) or
    cnt not in
    (
        select cnt
        from CreatedChallenges
        group by cnt
        having count(cnt) > 1
    )
order by cnt desc
