create temporary table temp_table
(
Agent_ID int ,
Frist_Name varchar(50),
Last_Name varchar(50),
Salary decimal(15,2),
Department varchar(50)
);

insert into temp_table 
select de.employee_id , de.first_name , de.last_name , sa.salary , dp.department_name
from employee_demographics de
join employee_salary sa
on de.employee_id = sa.employee_id 
join parks_departments dp
on dp.department_id = sa.dept_id 
where sa.salary >50000 ;

Select * from temp_table ;

drop table temp_table ;

#------------------------

Delimiter //
create procedure First_procedure() 
begin
	select de.first_name , de.last_name , sa.salary , dp.department_name
    from employee_demographics de
	join employee_salary sa
	on de.employee_id = sa.employee_id 
	join parks_departments dp
	on dp.department_id = sa.dept_id 
	where sa.salary >50000 ;
    select * from employee_demographics;
end //
Delimiter ;

call First_procedure()

#-------------------------------
Delimiter //
create procedure Second_procedure(EMP_ID int) 
begin
	select de.first_name , de.last_name , sa.salary , dp.department_name
    from employee_demographics de
	join employee_salary sa
	on de.employee_id = sa.employee_id 
	join parks_departments dp
	on dp.department_id = sa.dept_id 
	where sa.salary >50000 and de.employee_id = EMP_ID ;
end //
Delimiter ;

call Second_procedure(6) ;

#--------------------------------


Delimiter $$
create trigger first_trigger 
after insert on employee_salary
for each row 
begin
	insert into employee_demographics (employee_id ,first_name ,last_name)
	values (new.employee_id ,new.first_name ,new.last_name);
end $$
Delimiter ;

select * from employee_demographics ;
select * from employee_salary ;
select * from parks_departments ;


insert into employee_salary(employee_id , first_name ,last_name , occupation ,salary, dept_id)
values (13 ,'Ibrahim' , 'Ayman' , 'Data Analyst' , 100000 , 6) ;


#------------------------------
create table test (Agent_ID int , Agent_Name varchar(50) , Salary decimal(9,2)) ;
select * from test ;

insert into test (Agent_ID , Agent_Name , Salary )
    values (1,'Agent_1',1000);

Delimiter $$
drop event if exists first_event;
create event first_event 
on schedule every 5 second 
DO
begin
	insert into test (Agent_ID , Agent_Name , Salary )
    select max(Agent_ID)+ 1 , concat('Agent_' , max(Agent_ID) +1), max(Salary) + 1000 from test;
end $$
Delimiter ;

select * from test ;

drop table test ;