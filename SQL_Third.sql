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

Select de.first_name , de.last_name , sa.salary,
case
	when de.age > 50 and de.gender like 'male' then 'old_man'
	when de.age <= 50 and de.gender like 'male' then 'Youngest_man' 
	when de.age <= 50 and de.gender like 'female' then 'Youngest_woman'
	when de.age > 50 and de.gender like 'female' then 'old_woman' 
end as odest ,
case
	when sa.salary <= 50000 then sa.salary *0.05 
    when sa.salary > 50000 then sa.salary *0.07
end as increes ,
case
	when dept_id like (select distinct dp.department_id from parks_departments dp join employee_salary sa on dp.department_name  like 'finance')  then salary *.10
	else 'no bouns'
end  as pouns 
from parks_and_recreation.employee_salary sa
join parks_and_recreation.employee_demographics de
on sa.employee_id like de.employee_id
;

 

select  de.employee_id, de.first_name , de.last_name , gender ,salary , avg(salary) over(partition by gender) as avg_salary, 
sum(salary) over(partition by gender order by de.employee_id desc) as sum_salary,
row_number() over() as row_num_1 ,
row_number() over(partition by gender) as row_num_2 ,
rank() over(partition by gender order by sa.salary desc) as rank_1 ,
dense_rank() over(partition by gender order by sa.salary desc) as rank_2 
from parks_and_recreation.employee_salary sa
join parks_and_recreation.employee_demographics de
on sa.employee_id = de.employee_id	
;

select  de.employee_id, de.first_name , de.last_name , gender ,salary ,
sum(salary) over(partition by gender order by sa.employee_id desc) as sum_salary
from parks_and_recreation.employee_salary sa
join parks_and_recreation.employee_demographics de
on sa.employee_id = de.employee_id
;


with F_CTE (FIRST_NAME , LAST_NAME , SALARY_INCREES , PONUS) AS 
(
select sa.first_name , sa.last_name ,
CASE
when sa.salary < 50000 then sa.salary *1.05
when sa.salary > 50000 then sa.salary *1.07
END as salary_increes ,
CASE
when dept_id in (select department_id from parks_departments pa join employee_salary on department_name = 'Finance' )  then sa.salary *0.10
END AS boums
from employee_salary sa
)
select * from F_CTE 
;

With Table_1 AS 
(
Select de.first_name as fr , de.last_name as la , sa.salary as sa,
case
	when de.age > 50 and de.gender like 'male' then 'old_man'
	when de.age <= 50 and de.gender like 'male' then 'Youngest_man' 
	when de.age <= 50 and de.gender like 'female' then 'Youngest_woman'
	when de.age > 50 and de.gender like 'female' then 'old_woman' 
end as odest ,
case
	when sa.salary <= 50000 then sa.salary *0.05 
    when sa.salary > 50000 then sa.salary *0.07
    else 0
end as increes ,
case
	when dept_id like (select distinct dp.department_id from parks_departments dp join employee_salary sa on dp.department_name  like 'finance')  then salary *.10
	else 0
end  as pouns 
from parks_and_recreation.employee_salary sa
join parks_and_recreation.employee_demographics de
on sa.employee_id like de.employee_id
)
Select fr , la , sa, pouns ,increes , sa + pouns + increes as Total
from Table_1
;
