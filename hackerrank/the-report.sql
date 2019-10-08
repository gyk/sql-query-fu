select if(G.Grade < 8, NULL, S.Name), G.Grade, S.Marks
from Students S
left join Grades G
on S.Marks >= G.Min_Mark and S.Marks <= G.Max_Mark
order by G.Grade desc, S.Name
