Select * 
from parks_and_recreation.employee_demographics ;

Select * 
from parks_and_recreation.employee_salary;

Select * 
from parks_and_recreation.employee_demographics AS de
join parks_and_recreation.employee_salary AS sa
ON de.employee_id = sa.employee_id ;

Select sa.employee_id , de.first_name , gender 
from parks_and_recreation.employee_demographics AS de
Left join parks_and_recreation.employee_salary AS sa
ON de.employee_id = sa.employee_id;

Select sa.employee_id , de.first_name , gender 
from parks_and_recreation.employee_demographics AS de
right join parks_and_recreation.employee_salary AS sa
ON de.employee_id = sa.employee_id;

Select de.first_name , de.last_name , 'Old Man' As Label
from parks_and_recreation.employee_demographics AS de
where age > 40 and gender like 'Male'
union
Select de.first_name , de.last_name , 'Old Lady' As Label
from parks_and_recreation.employee_demographics AS de
where age > 40 and gender like 'Female'
union
Select sa.first_name , sa.last_name , 'Highly paid Employee' As Labeled
from parks_and_recreation.employee_salary AS sa
where salary > 70000 
order by first_name , last_name
;

Select de.first_name , length(de.first_name) len
from parks_and_recreation.employee_demographics AS de
order by 2
;

Select de.first_name ,
left(de.first_name,4) le ,
right(de.first_name,4) ri ,
substring(de.first_name,2,2) su ,
left(de.birth_date,4) Year,
replace(de.first_name , 'A' , 'Z'),
locate('A' , de.first_name),
concat(de.first_name,' ',de.last_name)
from parks_and_recreation.employee_demographics AS de
order by 2
;


Select de.first_name , de.last_name ,
CASE
When age > 30 then 'plapla'
END as bouns 
from parks_and_recreation.employee_demographics AS de
;


select sa.first_name , sa.last_name ,
CASE
when sa.salary < 50000 then sa.salary *1.05
when sa.salary > 50000 then sa.salary *1.07
END as salary_increes ,
CASE
when pa.department_name = 'Finance'  then sa.salary *0.10
END AS boums
from employee_salary sa
join parks_departments pa
on pa.department_id = sa.dept_id 
;

select sa.first_name , sa.last_name ,
CASE
when sa.salary < 50000 then sa.salary *1.05
when sa.salary > 50000 then sa.salary *1.07
END as salary_increes ,
CASE
when dept_id in (select department_id from parks_departments pa join employee_salary on department_name = 'Finance' )  then sa.salary *0.10
END AS boums
from employee_salary sa
;


