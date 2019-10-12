# MySQL solution
select
    contest_id,
    hacker_id,
    name,
    sum(total_submissions) as sum_total_submissions,
    sum(total_accepted_submissions) as sum_total_accepted_submissions,
    sum(total_views) as sum_total_views,
    sum(total_unique_views) as sum_total_unique_views
from Contests
left join Colleges
using (contest_id)
left join Challenges
using (college_id)
left join (
    select
        challenge_id,
        sum(total_views) as total_views,
        sum(total_unique_views) as total_unique_views
    from View_Stats
    group by challenge_id
) as T1
using (challenge_id)
left join (
    select
        challenge_id,
        sum(total_submissions) as total_submissions,
        sum(total_accepted_submissions) as total_accepted_submissions
    from Submission_Stats
    group by challenge_id
) as T2
using (challenge_id)
group by contest_id, hacker_id, name
having not (
    sum_total_submissions = 0 and
    sum_total_accepted_submissions = 0 and
    sum_total_views = 0 and
    sum_total_unique_views = 0)
order by contest_id
