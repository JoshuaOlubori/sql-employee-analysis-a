-- 1. Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch. 
-- See if the output contains a manager with that name.  
-- ‘emp_no’, ‘first_name’, ‘last_name’, ‘dept_no’, ‘from_date’. Order by 'dept_no' descending, and then by 'emp_no'.
select e.emp_no, e.first_name, e.last_name, d.dept_no, d.from_date
from employees e left join dept_manager d
on e.emp_no = d.emp_no
where e.last_name = 'Markovitch'
order by d.dept_no desc, e.emp_no;

-- +--------+----------------+------------+---------+------------+
-- | emp_no | first_name     | last_name  | dept_no | from_date  |
-- +--------+----------------+------------+---------+------------+
-- | 110022 | Margareta      | Markovitch | d001    | 1985-01-01 |
-- |  10898 | Munenori       | Markovitch | NULL    | NULL       |
-- |  11817 | Niranjan       | Markovitch | NULL    | NULL       |
-- |  12419 | Srinidhi       | Markovitch | NULL    | NULL       |
-- |  12977 | Byong          | Markovitch | NULL    | NULL       |
-- |  15392 | Pradeep        | Markovitch | NULL    | NULL       |
-- ...

-- 2. Extract a list containing information about all managers’ employee number, first and last name, 
-- department number, and hire date. Use the old type of join syntax to obtain the result.

select e.emp_no, e.first_name manager_first_name, e.last_name manager_last_name , dm.dept_no, e.hire_date
from dept_manager dm inner join employees e
on dm.emp_no = e.emp_no
order by dm.dept_no, e.hire_date;
-- +--------+--------------------+-------------------+---------+------------+
-- | emp_no | manager_first_name | manager_last_name | dept_no | hire_date  |
-- +--------+--------------------+-------------------+---------+------------+
-- | 110022 | Margareta          | Markovitch        | d001    | 1985-01-01 |
-- | 110039 | Vishwani           | Minakawa          | d001    | 1986-04-12 |
-- | 110085 | Ebru               | Alpin             | d002    | 1985-01-01 |
-- | 110114 | Isamu              | Legleitner        | d002    | 1985-01-14 |
-- | 110183 | Shirish            | Ossenbruggen      | d003    | 1985-01-01 |
-- | 110228 | Karsten            | Sigstam           | d003    | 1985-08-04 |
-- | 110303 | Krassimir          | Wegerle           | d004    | 1985-01-01 |
-- | 110344 | Rosine             | Cools             | d004    | 1985-11-22 |
-- | 110386 | Shem               | Kieras            | d004    | 1988-10-14 |
-- | 110420 | Oscar              | Ghazalie          | d004    | 1992-02-05 |
-- | 110511 | DeForest           | Hagimont          | d005    | 1985-01-01 |
-- | 110567 | Leon               | DasSarma          | d005    | 1986-10-21 |
-- 			...			...			...
-- +--------+--------------------+-------------------+---------+------------+
-- 24 rows in set (0.04 sec)

-- 3. Select the first and last name, the hire date, 
-- and the job title of all employees whose first name is “Margareta” and have the last name “Markovitch”.
select e.first_name, e.last_name, t.title, e.hire_date
from employees e inner join titles t
on e.emp_no = t.emp_no
where e.last_name = 'Markovitch';

-- +----------------+------------+--------------------+------------+
-- | first_name     | last_name  | title              | hire_date  |
-- +----------------+------------+--------------------+------------+
-- | Munenori       | Markovitch | Senior Engineer    | 1986-04-10 |
-- | Niranjan       | Markovitch | Senior Staff       | 1986-04-12 |
-- | Niranjan       | Markovitch | Staff              | 1986-04-12 |
-- | Srinidhi       | Markovitch | Engineer           | 1985-08-19 |
-- | Srinidhi       | Markovitch | Senior Engineer    | 1985-08-19 |
-- | Byong          | Markovitch | Engineer           | 1987-08-24 |
-- | Byong          | Markovitch | Senior Engineer    | 1987-08-24 |
-- | Pradeep        | Markovitch | Assistant Engineer | 1985-12-17 |
-- | Boguslaw       | Markovitch | Staff              | 1988-05-14 |
-- | Ferdinand      | Markovitch | Engineer           | 1999-03-15 |
-- | Brendon        | Markovitch | Senior Engineer    | 1985-06-06 |
-- | Fatemeh        | Markovitch | Senior Staff       | 1986-07-29 |
-- | Fatemeh        | Markovitch | Staff              | 1986-07-29 |
-- | Fumiya         | Markovitch | Senior Staff       | 1990-05-23 |
-- | Gad            | Markovitch | Senior Staff       | 1994-01-31 |
-- ... 	...	...	...	...	...	...
-- +----------------+------------+--------------------+------------+
-- 274 rows in set (0.32 sec)

-- 4. Cross join with Department Manager and Departments to see possible combination;
select dm.emp_no, d.dept_name 
from dept_manager dm cross join departments d
order by 1,2;
-- +--------+--------------------+
-- | emp_no | dept_name          |
-- +--------+--------------------+
-- | 110022 | Customer Service   |
-- | 110022 | Development        |
-- | 110022 | Finance            |
-- | 110022 | Human Resources    |
-- | 110022 | Marketing          |
-- | 110022 | Production         |
-- | 110022 | Quality Management |
-- | 110022 | Research           |
-- | 110022 | Sales              |
-- | ...... | ...   |
-- +--------+--------------------+
-- 216 rows in set (0.00 sec)

-- 5. Cross join with Department Manager and Departments to see possible combination
-- but except for the department he/she already in
select dm.emp_no, d.dept_name
from dept_manager dm cross join departments d 
where dm.dept_no <> d.dept_no
order by 1,2;

-- 6. Use a CROSS JOIN to return a list with all possible combinations between managers 
-- from the dept_manager table and department number 9.
select dm.*, d.*
from dept_manager dm cross join departments d 
where d.dept_no = 'd009'
order by 1,2;
-- +--------+---------+------------+------------+---------+------------------+
-- | emp_no | dept_no | from_date  | to_date    | dept_no | dept_name        |
-- +--------+---------+------------+------------+---------+------------------+
-- | 110022 | d001    | 1985-01-01 | 1991-10-01 | d009    | Customer Service |
-- | 110039 | d001    | 1991-10-01 | 9999-01-01 | d009    | Customer Service |
-- | 110085 | d002    | 1985-01-01 | 1989-12-17 | d009    | Customer Service |
-- | 110114 | d002    | 1989-12-17 | 9999-01-01 | d009    | Customer Service |
-- | 110183 | d003    | 1985-01-01 | 1992-03-21 | d009    | Customer Service |
-- | 110228 | d003    | 1992-03-21 | 9999-01-01 | d009    | Customer Service |
-- | 110303 | d004    | 1985-01-01 | 1988-09-09 | d009    | Customer Service |
-- | 110344 | d004    | 1988-09-09 | 1992-08-02 | d009    | Customer Service |
-- | 110386 | d004    | 1992-08-02 | 1996-08-30 | d009    | Customer Service |
-- | 110420 | d004    | 1996-08-30 | 9999-01-01 | d009    | Customer Service |
-- | 110511 | d005    | 1985-01-01 | 1992-04-25 | d009    | Customer Service |
-- | 110567 | d005    | 1992-04-25 | 9999-01-01 | d009    | Customer Service |
-- | 110725 | d006    | 1985-01-01 | 1989-05-06 | d009    | Customer Service |
-- | 110765 | d006    | 1989-05-06 | 1991-09-12 | d009    | Customer Service |
-- | 110800 | d006    | 1991-09-12 | 1994-06-28 | d009    | Customer Service |
-- | 110854 | d006    | 1994-06-28 | 9999-01-01 | d009    | Customer Service |
-- | 111035 | d007    | 1985-01-01 | 1991-03-07 | d009    | Customer Service |
-- | 111133 | d007    | 1991-03-07 | 9999-01-01 | d009    | Customer Service |
-- | 111400 | d008    | 1985-01-01 | 1991-04-08 | d009    | Customer Service |
-- | 111534 | d008    | 1991-04-08 | 9999-01-01 | d009    | Customer Service |
-- | 111692 | d009    | 1985-01-01 | 1988-10-17 | d009    | Customer Service |
-- | 111784 | d009    | 1988-10-17 | 1992-09-08 | d009    | Customer Service |
-- | 111877 | d009    | 1992-09-08 | 1996-01-03 | d009    | Customer Service |
-- | 111939 | d009    | 1996-01-03 | 9999-01-01 | d009    | Customer Service |
-- +--------+---------+------------+------------+---------+------------------+
-- 24 rows in set (0.00 sec)

-- 7. Return a list with the first 10 employees with all the departments they can be assigned to.
select e.emp_no, e.first_name, e.last_name, d.dept_name
from employees e cross join departments d
where e.emp_no <= 10010;

-- +--------+------------+-----------+--------------------+
-- | emp_no | first_name | last_name | dept_name          |
-- +--------+------------+-----------+--------------------+
-- |  10001 | Georgi     | Facello   | Sales              |
-- |  10001 | Georgi     | Facello   | Research           |
-- |  10001 | Georgi     | Facello   | Quality Management |
-- |  10001 | Georgi     | Facello   | Production         |
-- |  10001 | Georgi     | Facello   | Marketing          |
-- |  10001 | Georgi     | Facello   | Human Resources    |
-- |  10001 | Georgi     | Facello   | Finance            |
-- |  10001 | Georgi     | Facello   | Development        |
-- |  10001 | Georgi     | Facello   | Customer Service   |
-- |  10002 | Bezalel    | Simmel    | Sales              |
-- |  10002 | Bezalel    | Simmel    | Research           |
-- |  10002 | Bezalel    | Simmel    | Quality Management |
-- |  10002 | Bezalel    | Simmel    | Production         |
-- |  10002 | Bezalel    | Simmel    | Marketing          |
-- |  ... | ...    | ...    | ...    |
-- +--------+------------+-----------+--------------------+
-- 90 rows in set (0.00 sec)

-- 8. Select all managers’ first and last name, hire date, job title, start date, and department name.
select e.first_name, e.last_name, e.hire_date, t.title, de.from_date, d.dept_name
from employees e inner join titles t on e.emp_no = t.emp_no 
inner join dept_emp de on de.emp_no = e.emp_no
inner join departments d on d.dept_no = de.dept_no
where t.title = 'Manager';

-- +-------------+--------------+------------+---------+------------+--------------------+
-- | first_name  | last_name    | hire_date  | title   | from_date  | dept_name          |
-- +-------------+--------------+------------+---------+------------+--------------------+
-- | Margareta   | Markovitch   | 1985-01-01 | Manager | 1985-01-01 | Marketing          |
-- | Vishwani    | Minakawa     | 1986-04-12 | Manager | 1986-04-12 | Marketing          |
-- | Ebru        | Alpin        | 1985-01-01 | Manager | 1985-01-01 | Finance            |
-- | Isamu       | Legleitner   | 1985-01-14 | Manager | 1985-01-14 | Finance            |
-- | Shirish     | Ossenbruggen | 1985-01-01 | Manager | 1985-01-01 | Human Resources    |
-- | Karsten     | Sigstam      | 1985-08-04 | Manager | 1985-08-04 | Human Resources    |
-- | Krassimir   | Wegerle      | 1985-01-01 | Manager | 1985-01-01 | Production         |
-- | Rosine      | Cools        | 1985-11-22 | Manager | 1985-11-22 | Production         |
-- | Shem        | Kieras       | 1988-10-14 | Manager | 1988-10-14 | Production         |
-- | Oscar       | Ghazalie     | 1992-02-05 | Manager | 1992-02-05 | Production         |
-- | DeForest    | Hagimont     | 1985-01-01 | Manager | 1985-01-01 | Development        |
-- | Leon        | DasSarma     | 1986-10-21 | Manager | 1986-10-21 | Development        |
-- | Peternela   | Onuegbe      | 1985-01-01 | Manager | 1985-01-01 | Quality Management |
-- | Rutger      | Hofmeyr      | 1989-01-07 | Manager | 1989-01-07 | Quality Management |
-- | Sanjoy      | Quadeer      | 1986-08-12 | Manager | 1986-08-12 | Quality Management |
-- | Dung        | Pesch        | 1989-06-09 | Manager | 1989-06-09 | Quality Management |
-- | Przemyslawa | Kaelbling    | 1985-01-01 | Manager | 1985-01-01 | Sales              |
-- | Hauke       | Zhang        | 1986-12-30 | Manager | 1986-12-30 | Sales              |
-- | Arie        | Staelin      | 1985-01-01 | Manager | 1985-01-01 | Research           |
-- | Hilary      | Kambil       | 1988-01-31 | Manager | 1988-01-31 | Research           |
-- | Tonny       | Butterworth  | 1985-01-01 | Manager | 1985-01-01 | Customer Service   |
-- | Marjo       | Giarratana   | 1988-02-12 | Manager | 1988-02-12 | Customer Service   |
-- | Xiaobin     | Spinelli     | 1991-08-17 | Manager | 1991-08-17 | Customer Service   |
-- | Yuchang     | Weedman      | 1989-07-10 | Manager | 1989-07-10 | Customer Service   |
-- +-------------+--------------+------------+---------+------------+--------------------+
-- 24 rows in set (0.39 sec)

-- 9. How many male and how many female managers do we have in the ‘employees’ database?
SELECT 
    e.gender, COUNT(e.emp_no) AS manager_gender_count
FROM
    employees e
        NATURAL JOIN
    dept_manager dm
GROUP BY gender;

-- +--------+----------------------+
-- | gender | manager_gender_count |
-- +--------+----------------------+
-- | M      |                   11 |
-- | F      |                   13 |
-- +--------+----------------------+
-- 2 rows in set (0.00 sec)

-- 10. Average salary of employees by each department
select d.dept_name, avg(s.salary)
from departments d inner join dept_emp de on d.dept_no = de.dept_no
inner join salaries s on s.emp_no = de.emp_no
group by 1;

-- +--------------------+--------------------+
-- | dept_name          | avg_salary_by_dept |
-- +--------------------+--------------------+
-- | Customer Service   |         58755.4406 |
-- | Development        |         59503.5750 |
-- | Finance            |         70159.4662 |
-- | Human Resources    |         55353.5203 |
-- | Marketing          |         71901.7237 |
-- | Production         |         59539.7899 |
-- | Quality Management |         57294.6570 |
-- | Research           |         59866.2435 |
-- | Sales              |         80776.6204 |
-- +--------------------+--------------------+
-- 9 rows in set (12.46 sec)