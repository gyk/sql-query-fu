# MySQL solution
select H.hacker_id, H.name
from Hackers H
join Submissions S
using (hacker_id)
join Challenges
using (challenge_id)
join Difficulty D
using (difficulty_level)
where S.score = D.score
group by H.hacker_id, H.name
having count(1) > 1
order by count(1) desc, H.hacker_id
