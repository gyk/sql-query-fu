-- MS SQL Server solution
-- TODO: This can be made more concise.
with Agg as
(
    select submission_date, hacker_id, name, count(submission_id) as cnt
    from
    (
        select submission_date, Hackers.hacker_id, name, submission_id
        from Hackers
        join Submissions
        on Hackers.hacker_id = Submissions.hacker_id
    ) as T
    group by submission_date, hacker_id, name
    having count(submission_id) > 0
)
select T.submission_date, TEachDay.each_day, T.hacker_id, T.name
from
(
    select submission_date, hacker_id, name
    from
    (
        select
            A.submission_date,
            A.hacker_id,
            A.name,
            row_number() over (partition by A.submission_date order by A.submission_date, A.hacker_id) as rid
        from Agg A
        join
        (
            select submission_date, max(cnt) as max_cnt
            from Agg
            group by submission_date
        ) as T
        on A.submission_date = T.submission_date and A.cnt = T.max_cnt
    ) as T
    where rid = 1
) as T
join
(
    select submission_date, count(1) as each_day
    from
    (
        select
            submission_date,
            hacker_id,
            datediff(day, '2016-03-01', submission_date) + 1 as d1,
            row_number() over (partition by hacker_id order by submission_date, hacker_id) as d2
        from Agg
        group by submission_date, hacker_id
    ) as T
    where d1 = d2
    group by submission_date
) as TEachDay
on T.submission_date = TEachDay.submission_date
order by submission_date
