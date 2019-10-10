select distinct F1.X, F1.Y
from Functions F1
join Functions F2
on F1.X = F2.Y and F1.Y = F2.X 
group by F1.X, F1.Y
having F1.X < F1.Y or count(1) > 1
