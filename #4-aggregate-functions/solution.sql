-- 1. How many departments are there in the “employees” database?
select count(distinct(dept_no)) no_of_depts from dept_emp;
-- +-------------+
-- | no_of_depts |
-- +-------------+
-- |           9 |
-- +-------------+

-- 2. What is the total amount of money 
-- spent on salaries for all contracts starting after the 1st of January 1997?
select * from salaries limit 1;
-- +--------+--------+------------+------------+
-- | emp_no | salary | from_date  | to_date    |
-- +--------+--------+------------+------------+
-- |  10001 |  60117 | 1986-06-26 | 1987-06-26 |
-- +--------+--------+------------+------------+

SELECT 
    SUM(salary) AS total_amount_spent_on_salary
FROM
    salaries
WHERE
    from_date >= '1997-01-01';
--     +------------------------------+
-- | total_amount_spent_on_salary |
-- +------------------------------+
-- |                  31923192646 |
-- +------------------------------+

-- 3. Which is the lowest employee number in the database?
select min(emp_no) lowest_emp_no, first_name, last_name from employees;
-- +---------------+------------+-----------+
-- | lowest_emp_no | first_name | last_name |
-- +---------------+------------+-----------+
-- |         10001 | Georgi     | Facello   |
-- +---------------+------------+-----------+

-- 4. Which is the highest employee number in the database?
select max(emp_no) highest_emp_no, first_name, last_name from employees;
-- +----------------+------------+-----------+
-- | highest_emp_no | first_name | last_name |
-- +----------------+------------+-----------+
-- |         999903 | Georgi     | Facello   |
-- +----------------+------------+-----------+

-- 5. What is the average annual salary
-- paid to employees who started after the 1st of January 1997?
select avg(salary) avg_salary from salaries where from_date > '1997-01-01';
-- +------------+
-- | avg_salary |
-- +------------+
-- | 67717.7450 |
-- +------------+

-- 6. Round the average amount of money spent on salaries for all contracts that 
-- started after the 1st of January 1997 to a precision of cents.
select round(avg(salary), 2) avg_salary_cent_precision from salaries where from_date > '1997-01-01';

-- +---------------------------+
-- | avg_salary_cent_precision |
-- +---------------------------+
-- |                  67717.75 |
-- +---------------------------+
-- 7. Select the department number and name from the ‘departments_dup’ table and add a third column 
-- where you name the department number (‘dept_no’) as ‘dept_info’. 
-- If ‘dept_no’ does not have a value, use ‘dept_name’.
SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments;
    
-- +---------+--------------------+-----------+
-- | dept_no | dept_name          | dept_info |
-- +---------+--------------------+-----------+
-- | d009    | Customer Service   | d009      |
-- | d005    | Development        | d005      |
-- | d002    | Finance            | d002      |
-- | d003    | Human Resources    | d003      |
-- | d001    | Marketing          | d001      |
-- | d004    | Production         | d004      |
-- | d006    | Quality Management | d006      |
-- | d008    | Research           | d008      |
-- | d007    | Sales              | d007      |
-- +---------+--------------------+-----------+

-- 8. Modify the code obtained from the previous exercise in the following way. Apply the IFNULL() function 
-- to the values from the first and second column, so that ‘N/A’ is displayed whenever a department number has no value, 
-- and ‘Department name not provided’ is shown if there is no value for ‘dept_name’.
SELECT 
    IFNULL(dept_no, 'N/A') AS dept_no,
    IFNULL(dept_name, 'Department not provided') AS dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments
ORDER BY dept_no;


-- +---------+--------------------+-----------+
-- | dept_no | dept_name          | dept_info |
-- +---------+--------------------+-----------+
-- | d001    | Marketing          | d001      |
-- | d002    | Finance            | d002      |
-- | d003    | Human Resources    | d003      |
-- | d004    | Production         | d004      |
-- | d005    | Development        | d005      |
-- | d006    | Quality Management | d006      |
-- | d007    | Sales              | d007      |
-- | d008    | Research           | d008      |
-- | d009    | Customer Service   | d009      |
-- +---------+--------------------+-----------+