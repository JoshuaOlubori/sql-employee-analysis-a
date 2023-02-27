-- 1. Find employees who have belonged to more than 1 departments
-- select e.first_name, e.last_name
select de.emp_no, e.first_name, e.last_name, count(dept_no) total_dept_worked from employees e join dept_emp de on e.emp_no = de.emp_no group by emp_no
having total_dept_worked > 1;

-- 2. Get the latest department info of the employee using a view
create or replace view v_dept_emp_lastest_date as
select de.emp_no, e.first_name, e.last_name, max(de.from_date) from_date, max(de.to_date) to_date from dept_emp de
join employees e on de.emp_no = e.emp_no
group by emp_no;

select * from v_dept_emp_date;
-- +--------+------------+-----------+------------+
-- | emp_no | first_name | last_name | from_date  |
-- +--------+------------+-----------+------------+
-- |  10001 | Georgi     | Facello   | 1986-06-26 |
-- |  10002 | Bezalel    | Simmel    | 1996-08-03 |
-- |  10003 | Parto      | Bamford   | 1995-12-03 |
-- |  10004 | Chirstian  | Koblick   | 1986-12-01 |
-- |  10005 | Kyoichi    | Maliniak  | 1989-09-12 |
-- |  10006 | Anneke     | Preusig   | 1990-08-05 |
-- |  10007 | Tzvetan    | Zielinski | 1989-02-10 |
-- |  10008 | Saniya     | Kalloufi  | 1998-03-11 |
-- |  10009 | Sumant     | Peac      | 1985-02-18 |
-- ...			...		....		...
-- +--------+------------+-----------+------------+
-- 1000+ rows in set (9.17 sec)

-- 3. Create a view that will extract the average salary of all managers registered in the database. 
-- Round the aggregation to the nearest cent.

create or replace view v_avg_manager_salary as
select dm.emp_no, round(avg(s.salary),2) as avg_manager_salary from dept_manager dm
join salaries s on dm.emp_no = s.emp_no
group by 1;

select * from v_avg_manager_salary;

-- +--------+--------------------+
-- | emp_no | avg_manager_salary |
-- +--------+--------------------+
-- | 110022 |           89128.28 |
-- | 110039 |           87570.59 |
-- | 110085 |           72822.78 |
-- | 110114 |           68809.00 |
-- | 110183 |           62990.22 |
-- | 110228 |           53581.89 |
-- | 110303 |           57052.33 |
-- | 110344 |           63609.71 |
-- | 110386 |           53594.00 |
-- | 110420 |           46852.82 |
-- | 110511 |           62568.17 |
-- | 110567 |           56384.31 |
-- | 110725 |           81301.22 |
-- | 110765 |           55320.57 |
-- | 110800 |           67995.50 |
-- | 110854 |           59734.29 |
-- | 111035 |           84242.44 |
-- | 111133 |           87422.13 |
-- | 111400 |           87217.28 |
-- | 111534 |           65916.67 |
-- | 111692 |           58223.61 |
-- | 111784 |           50033.13 |
-- | 111877 |           62860.36 |
-- | 111939 |           49833.93 |
-- +--------+--------------------+
-- 24 rows in set (0.00 sec)

-- 4. Create a view to show only the current department for each employee
-- i.e create a view that  queries from a preexisting view and a table
create view current_dept_emp as
select v.emp_no, d.dept_no, v.from_date, v.to_date
from dept_emp d
inner join v_dept_emp_lastest_date v 
on d.emp_no = v.emp_no
and d.from_date = v.from_date
and d.to_date = v.to_date;

select * from current_dept_emp;

-- +--------+---------+------------+------------+
-- | emp_no | dept_no | from_date  | to_date    |
-- +--------+---------+------------+------------+
-- |  10001 | d005    | 1986-06-26 | 9999-01-01 |
-- |  10002 | d007    | 1996-08-03 | 9999-01-01 |
-- |  10003 | d004    | 1995-12-03 | 9999-01-01 |
-- |  10004 | d004    | 1986-12-01 | 9999-01-01 |
-- |  10005 | d003    | 1989-09-12 | 9999-01-01 |
-- |  10006 | d005    | 1990-08-05 | 9999-01-01 |
-- |  10007 | d008    | 1989-02-10 | 9999-01-01 |
-- |  10008 | d005    | 1998-03-11 | 2000-07-31 |
-- |  10009 | d006    | 1985-02-18 | 9999-01-01 |
-- ...	...	....	...			...		...
-- +--------+---------+------------+------------+
-- 1000+ rows in set (8.59 sec)