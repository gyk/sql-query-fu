select Name
from Students
join Packages
using (ID)
join
(
    select ID, Salary as Friend_Salary
    from Friends
    join Packages
    on Friends.Friend_ID = Packages.ID
) as T
using (ID)
where Friend_Salary > Salary
order by Friend_Salary
