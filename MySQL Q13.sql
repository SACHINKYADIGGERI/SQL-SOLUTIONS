-- Find out the no of employees managed by each manager.

drop table if exists employee_managers;
create table employee_managers
(
	id			int,
	name		varchar(20),
	manager 	int
);
insert into employee_managers values (1, 'Sundar', null);
insert into employee_managers values (2, 'Kent', 1);
insert into employee_managers values (3, 'Ruth', 1);
insert into employee_managers values (4, 'Alison', 1);
insert into employee_managers values (5, 'Clay', 2);
insert into employee_managers values (6, 'Ana', 2);
insert into employee_managers values (7, 'Philipp', 3);
insert into employee_managers values (8, 'Prabhakar', 4);
insert into employee_managers values (9, 'Hiroshi', 4);
insert into employee_managers values (10, 'Jeff', 4);
insert into employee_managers values (11, 'Thomas', 1);
insert into employee_managers values (12, 'John', 15);
insert into employee_managers values (13, 'Susan', 15);
insert into employee_managers values (14, 'Lorraine', 15);
insert into employee_managers values (15, 'Larry', 1);

select * from employee_managers;


---STEP!
select 
       emp.name as emp_name, 
       mng.name as manager
from 
       employee_managers emp
join 
       employee_managers mng on emp.manager = mng.id


--STEP2
select 
       mng.name as manager,
       count(emp.name) as no_of_employees
from 
       employee_managers emp
join
       employee_managers mng on emp.manager = mng.id
group by
       mng.name
order by no_of_employees desc











