# MySQL solution
select
    company_code, founder,
    count(distinct lead_manager_code),
    count(distinct senior_manager_code),
    count(distinct manager_code),
    count(distinct employee_code)
from Company
left join Lead_Manager
using (company_code)
left join Senior_Manager
using (company_code, lead_manager_code)
left join Manager
using (company_code, lead_manager_code, senior_manager_code)
left join Employee
using (company_code, lead_manager_code, senior_manager_code, manager_code)
group by company_code
order by company_code
