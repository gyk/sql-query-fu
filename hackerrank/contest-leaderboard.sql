# MySQL solution
select hacker_id, name, sum(max_score) as total_score
from
(
    select hacker_id, name, challenge_id, max(score) as max_score
    from Hackers
    join Submissions
    using (hacker_id)
    group by hacker_id, name, challenge_id
) as T
group by hacker_id, name
having total_score > 0
order by total_score desc, hacker_id
