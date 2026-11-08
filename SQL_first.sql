select *
from parks_and_recreation.employee_demographics
where gender != 'Male' 
and (birth_date > '1980-03-27'
or age > 30);



select gender ,avg(age)
from parks_and_recreation.employee_demographics
group by gender
having avg(age) > 40;


select *
from parks_and_recreation.employee_demographics
limit 3 ,1

