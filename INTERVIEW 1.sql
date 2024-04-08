select * from Employee;

select * from EmployeeDetail;


-- Q1(a) Find the list of employees whose salary ranges between 2Lakhs to 3Lakhs.

select EmpName, Salary
from Employee
Where Salary > 200000 and Salary < 300000

-- OR

select EmpName, Salary 
from Employee
Where Salary between 200000 and 300000


-- Q1(b) Write a query to retrieve the list of employees from the same city.

select E1.EmpID, E1.EmpName, E1.City 
from Employee E1, Employee E2
Where E1.City = E2.City AND E1.EmpID != E2.EmpID


-- Q1(c) Query to find the null values in the Employee Table.

select * from Employee
where EmpID IS NULL


-- Q2(a) Query to find the Cumulative sum of employee's salary

select 
	EmpID, Salary, SUM(salary) over (order by EmpID) AS CumulativeSum
from Employee

-- Q2(b) What's the male and female employees ratio.

select 
	round(count(*) filter (where gender = 'M') * 100.0 / count(*),2) AS MaleRatio,
	round(count(*) filter (where gender = 'F') * 100.0 / count(*),2) AS FemaleRatio
from Employee

-- Q2(c) write a query to fetch 50% records from the Employee table.

select * from employee
where EmpID <= (select (count(EmpID)/2) from Employee)

-- or
-- This ROW NUMBER is used when their is no sequence number in table to count 
select * from
    (select *, ROW_NUMBER() OVER(order by empID) AS RowNumber
	from Employee) AS Emp
WHERE Emp.RowNumber <= (select count(EmpID)/2 from Employee)


-- Q3 Query to fetch the employee's salary but replace the last 2 digits with 'XX'
-- i.e 12345 will be 123XX

select 
	salary,
	CONCAT(SUBSTRING(Salary::text,1,LENGTH(Salary::text)-2), 'XX') 
	AS Masked_Number
from employee

-- or

SELECT 
	salary, 
	CONCAT(LEFT(CAST(salary AS text), LENGTH(CAST(Salary AS text))-2), 'XX') 
	AS masked_Number
FROM employee


-- Q4 Write a query to fetch even and odd rows from Employee table 

-- FETCH FOR EVEN ROWS
select * from 
		(select *, ROW_NUMBER() OVER(Order by EmpID) AS RN
		from Employee) AS emp
WHERE emp.RN % 2 = 0

-- FETCH FOR ODD ROWS
select * from 
		(select *, ROW_NUMBER() OVER(Order by EmpID) AS RN
		from Employee) AS emp
WHERE emp.RN % 2 = 1

-- If you have an auto-increment field like EmpID then we can use the 
-- MOD() Function
-- FETCH FOR EVEN ROWS
select * from employee
where MOD(EmpID,2)=0;

-- FETCH FOR ODD ROWS
select * from employee
where MOD(EmpID,2)=1;


-- Q5(a) Write a query to find all the employee names whose name 
--    * Begin with 'A'
-- 	  * Contains 'A' alphabet at second place
-- 	  * Contains 'Y' alphabet at second last place
-- 	  * Ends with 'L' and contains 4 alphabets
-- 	  * Begins with 'V' and ends with 'A'

select * from employee

select * from employee where empname like 'A%'

select * from employee where empname like '_a%'

select * from employee where empname like '%y_'

select * from employee where empname like '____l'

select * from employee where empname like 'V%a'


-- Q5(b) Write a Query to find the list of employee names which is:
--   *Starting with vowels (a,e,i,o,u), without duplicates
-- 	 *Ending with vowels (a,e,i,o,u), without duplicates
-- 	 *Starting & ending with vowels (a,e,i,o,u), wihtout duplicates
--   BUT in MySQL REGEXP is used instead of SIMILAR TO

select distinct empname 
from employee
where lower(empname) similar to '[a,e,i,o,u]%'


select distinct empname 
from employee
where lower(empname) similar to '%[a,e,i,o,u]'


select distinct empname 
from employee
where lower(empname) similar to '[a,e,i,o,u]%[a,e,i,o,u]'


-- Q6 Find Nth highest salary from employee table with and without using the 
--    TOP/LIMIT keywords.

select * from employee
order by salary desc

select E1.Salary from employee E1
where 1 = (
    select count(distinct(E2.salary))
	from Employee E2
	where E2.salary > E1.salary);


-- Q7(a) Write a query to find and remove duplicate records from a table

select EmpID, EmpName, Gender, Salary, City,
count(*) AS Duplicate_count
from employee
Group by  EmpID, EmpName, Gender, Salary, City
having count(*) > 1

-- OR

delete 
from  employee
where empid IN
      (select empid 
	  from employee
	  group by empid
	  having count(*) > 1)
 

-- Q7(b) Query to retrieve the list of employee working in same project

with cte AS
		(select e.empid, e.empname, ed.project
		from employee e
		inner join employeedetail ed
		on e.empid = ed.empid)
select c1.empid, c1.empname, c1.project
from   cte c1, cte c2
where  c1.project = c2.project AND c1.empid != c2.empid AND c1.empid < c2.empid


-- Q8(a) Show the employee with highest salary for each project

select Max(e.salary)AS HS, ed.project
from employee e
inner join employeedetail ed
on e.empid = ed.empid
group by project
order by HS desc


-- Alternative, more dynamic solution: here you can fetch empname, 2^nd/3^rd highest value, etc

with cte as
		(select project, Empname, salary,
		row_number() over(partition by project order by salary desc) AS row_rank
		from employee AS e
		inner join employeedetail AS ed
		on e.empid = ed.empid)
select project, empname, salary, row_rank
from cte
where row_rank = 1;

select * from employee
select * from employeedetail

-- Q9) Query to find the total count of employees joined each year

select EXTRACT('year' from date_of_joining) AS JoinYear, count(*) AS Empcount
from employee e
inner join employeedetail AS ed 
on e.empid = ed.empid
group by JoinYear
Order by JoinYear ASC


-- Q10 Create 3 group based on salary col, salary less than 1L is low, between
--     1 - 2L is medium and above 2L is high

select empname, salary,
   case 
       when salary > 200000 then 'High'
	   when salary >= 100000 AND salary <= 200000 then 'Medium'
	   else 'low'
   end AS SalaryStatus
from Employee


-- Q11 Query to pivot the data in the Employee table and retrieve the total salary for each city.
--     The result should display the empid , empname, and separate columns for each city
-- 	   (Mathura, Pune, Delhi), containing the corresponding total salary

Select
  Empid, Empname,
  Sum(case when city = 'Mathura' then salary end) AS "Mathura",
  Sum(case when city = 'Pune' then salary end) AS "Pune",
  Sum(case when city = 'Delhi' then salary end) AS "Delhi"
From Employee
Group by EmpID, EmpName



