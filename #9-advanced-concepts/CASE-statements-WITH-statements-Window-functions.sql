-- Boss: I want a query that delivers employee no, names and then a third column that contains their gender, but not as 'm' or 'f' as it is in the database but as 'Male' or 'Female'
select emp_no, first_name, last_name,
case
when
gender = 'M' then 'Male'
else 'Female'
end as gender from employees limit 10;
 
--  +--------+------------+-----------+--------+
-- | emp_no | first_name | last_name | gender |
-- +--------+------------+-----------+--------+
-- |  10001 | Georgi     | Facello   | Male   |
-- |  10002 | Bezalel    | Simmel    | Female |
-- |  10003 | Parto      | Bamford   | Male   |
-- |  10004 | Chirstian  | Koblick   | Male   |
-- |  10005 | Kyoichi    | Maliniak  | Male   |
-- |  10006 | Anneke     | Preusig   | Female |
-- |  10007 | Tzvetan    | Zielinski | Female |
-- |  10008 | Saniya     | Kalloufi  | Male   |
-- |  10009 | Sumant     | Peac      | Female |
-- ...		...		...		...		...		
-- +--------+------------+-----------+--------+
-- 10 rows in set (0.00 sec)

 -- Similar result can be achieved with the if() function
 select emp_no, first_name, last_name, if(gender = 'M', 'Male', 'Female') as gender
 from employees;
 
-- 2. Similarly, obtain a result set containing the employee number, first name, and last name of all employees with a number higher than 109990. 
-- Create a fourth column in the query, indicating whether this employee is also a manager, 
-- according to the data provided in the dept_manager table, or a regular employee.

 select e.emp_no, e.first_name, e.last_name, case
when e.emp_no in (select emp_no from dept_manager) then 'manager'
else 'regular employee'
end as is_manager
from employees e left join dept_manager dm
on e.emp_no = dm.emp_no
where e. emp_no > 109990;

-- 3. Extract a dataset containing the following information about the managers: 
-- employee number, first name, and last name. Add two columns at the end – 
-- one showing the difference between the maximum and minimum salary of that employee, and another one saying 
-- whether this salary raise was higher than $30,000 or NOT.
-- sort the records by salary difference in descending order

select e.emp_no, e.first_name, e.last_name, max(s.salary) as max_salary, min(s.salary) as min_salary, max(s.salary) - min(s.salary) as sal_diff, case
when (max(s.salary) - min(s.salary)) > 30000 then 'Yes'
else 'No'
end as is_salary_difference_gt_30000
from employees e inner join salaries s
on e.emp_no = s.emp_no
group by 1,2,3
order by sal_diff;

-- +--------+----------------+------------------+------------+------------+----------+-------------------------------+
-- | emp_no | first_name     | last_name        | max_salary | min_salary | sal_diff | is_salary_difference_gt_30000 |
-- +--------+----------------+------------------+------------+------------+----------+-------------------------------+
-- |  43145 | Fumino         | Frijda           |      96389 |      42514 |    53875 | Yes                           |
-- |  13386 | Khosrow        | Sgarro           |     144434 |      91420 |    53014 | Yes                           |
-- | 102654 | Gregory        | Makinen          |     103166 |      50339 |    52827 | Yes                           |
-- |  74848 | Lucian         | Werthner         |     123732 |      71011 |    52721 | Yes                           |
-- |  65362 | Zsolt          | McAffer          |     129468 |      76953 |    52515 | Yes                           |
-- |  69209 | Pintsang       | Lubachevsky      |      91649 |      40000 |    51649 | Yes                           |
-- |  70082 | Xinglin        | Pauthner         |     110988 |      60072 |    50916 | Yes                           |
-- |  49501 | Yonghong       | Schmezko         |      90770 |      40000 |    50770 | Yes                           |
-- | 106592 | Dipayan        | Schade           |      90663 |      40000 |    50663 | Yes                           |
-- |  26317 | Valdiodio      | Weedman          |     135955 |      85740 |    50215 | Yes                           |
-- |  34977 | Mats           | Cronan           |      90137 |      40000 |    50137 | Yes                           |
-- |  22028 | Serif          | Manderick        |     103556 |      53583 |    49973 | Yes                           |
-- |  ...	...		....		...			...			...			...				...		...                      |
-- 

-- You can also use IF() to get the same result

 -- 4 . We've laid off quite a lot of employees over the years and some have retired. I am concerned about whether the database is too crowded
 -- I need a query to extract the employee number, first name, and last name of the first 100 employees, and add a fourth column,
--  called “current_employee” saying “Is still employed” if the employee is still working in the company, or 
--  “Not an employee anymore” if they aren’t.

select e.emp_no, e.first_name, e.last_name, 
case when max(de.to_date) > curdate() then 'Is still employed'
else 'Not an employee'
end as employed_or_not
from employees e inner join dept_emp de
on e.emp_no = de.emp_no
group by 1
order by e.emp_no
limit 100;

-- +--------+------------+--------------+------------------------+
-- | emp_no | first_name | last_name    | employed_or_not        |
-- +--------+------------+--------------+------------------------+
-- |  10001 | Georgi     | Facello      | Is still employed      |
-- |  10002 | Bezalel    | Simmel       | Is still employed      |
-- |  10003 | Parto      | Bamford      | Is still employed      |
-- |  10004 | Chirstian  | Koblick      | Is still employed      |
-- |  10005 | Kyoichi    | Maliniak     | Is still employed      |
-- |  10006 | Anneke     | Preusig      | Is still employed      |
-- |  10007 | Tzvetan    | Zielinski    | Is still employed      |
-- |  10008 | Saniya     | Kalloufi     | Not a current employee |
-- |  10009 | Sumant     | Peac         | Is still employed      |
-- |  ...	...	...	...	...		...				...			.... |

-- Okay. Brilliant. But can I get hard numbers?
with temp as (
select e.emp_no emp_no, e.first_name fname, e.last_name lname, 
case when max(de.to_date) > curdate() then 'Is still employed'
else 'Not a current employee'
end as employed_or_not
from employees e inner join dept_emp de
on e.emp_no = de.emp_no
group by 1
order by e.emp_no)

select emp_no, fname, lname,
sum(case when employed_or_not = 'Is still employed' then 1 else 0 end) over () as sum_of_employed
from temp;

-- +--------+----------------+------------------+-----------------+
-- | emp_no | fname          | lname            | sum_of_employed |
-- +--------+----------------+------------------+-----------------+
-- |  10001 | Georgi         | Facello          |          240125 |
-- |  10002 | Bezalel        | Simmel           |          240125 |
-- |  10003 | Parto          | Bamford          |          240125 |
-- |  10004 | Chirstian      | Koblick          |          240125 |
-- |  10005 | Kyoichi        | Maliniak         |          240125 |
-- |  10006 | Anneke         | Preusig          |          240125 |
-- |  10007 | Tzvetan        | Zielinski        |          240125 |
-- |  10008 | Saniya         | Kalloufi         |          240125 |
-- |  10009 | Sumant         | Peac             |          240125 |
-- |  10010 | Duangkaew      | Piveteau         |          240125 |
-- |  10010 | Duangkaew      | Piveteau         |          240125 |
-- |...	...				....			....			...		. |


-- This is just wonderful. Can we go a bit further and get me also the sum of unemployed
-- and then the percentage of employees in the database who are employed?


with temp1 as (
select e.emp_no emp_no, e.first_name fname, e.last_name lname, 
case when max(de.to_date) > curdate() then 'Is still employed'
else 'Not a current employee'
end as employed_or_not
from employees e inner join dept_emp de
on e.emp_no = de.emp_no
group by e.emp_no
order by e.emp_no),

temp2 as (
select emp_no, fname, lname, 
sum(case when employed_or_not = 'Is still employed' then 1 else 0 end) over() as sum_of_employed,
sum(case when employed_or_not = 'Not a current employee' then 1 else 0 end) over() as sum_of_unemployed,
count(*) over() as total_employees
from temp1
)

select emp_no, fname, lname, sum_of_employed, sum_of_unemployed, sum_of_employed / (total_employees) as pct_employed from temp2;

-- +--------+----------------+------------------+-----------------+-------------------+--------------+
-- | emp_no | fname          | lname            | sum_of_employed | sum_of_unemployed | pct_employed |
-- +--------+----------------+------------------+-----------------+-------------------+--------------+
-- |  10001 | Georgi         | Facello          |          240125 |             59900 |       0.8003 |
-- |  10002 | Bezalel        | Simmel           |          240125 |             59900 |       0.8003 |
-- |  10003 | Parto          | Bamford          |          240125 |             59900 |       0.8003 |
-- |  10004 | Chirstian      | Koblick          |          240125 |             59900 |       0.8003 |
-- |  10005 | Kyoichi        | Maliniak         |          240125 |             59900 |       0.8003 |
-- |  10006 | Anneke         | Preusig          |          240125 |             59900 |       0.8003 |
-- |  10007 | Tzvetan        | Zielinski        |          240125 |             59900 |       0.8003 |
-- |  10008 | Saniya         | Kalloufi         |          240125 |             59900 |       0.8003 |
-- |  10009 | Sumant         | Peac             |          240125 |             59900 |       0.8003 |
-- |  10010 | Duangkaew      | Piveteau         |          240125 |             59900 |       0.8003 |
-- |  10011 | Mary           | Sluis            |          240125 |             59900 |       0.8003 |
-- |  10012 | Patricio       | Bridgland        |          240125 |             59900 |       0.8003 |
-- |  ...			...				....			...			...				....			..... |
-- 300025 rows in set (28.67 sec)

-- "Okay. Its not so bad. 80% of the database contains current workers. We can put off removing past worker records for now"