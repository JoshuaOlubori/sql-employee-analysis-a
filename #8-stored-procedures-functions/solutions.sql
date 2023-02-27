-- 1. create a stored procedure that select 100 employees
delimiter $$
create procedure select_employee()
begin
select * from employees limit 100;
end 
$$ 
delimiter ;

call select_employee();

-- +--------+------------+-------------+--------------+--------+------------+
-- | emp_no | birth_date | first_name  | last_name    | gender | hire_date  |
-- +--------+------------+-------------+--------------+--------+------------+
-- |  10001 | 1953-09-02 | Georgi      | Facello      | M      | 1986-06-26 |
-- |  10002 | 1964-06-02 | Bezalel     | Simmel       | F      | 1985-11-21 |
-- |  10003 | 1959-12-03 | Parto       | Bamford      | M      | 1986-08-28 |
-- |  10004 | 1954-05-01 | Chirstian   | Koblick      | M      | 1986-12-01 |
-- | ...		....		...			...		
-- 100 rows in set (0.00 sec)

-- 2. create a stored procedure that select the average salary of all employees
drop procedure if exists select_avg_sal_all_employees;
delimiter $$
create procedure avg_sal_all_employees()
begin
select avg(salary) from salaries;
end
$$
delimiter ;

call avg_sal_all_employees();

-- +-------------+
-- | avg(salary) |
-- +-------------+
-- |  63761.2043 |
-- +-------------+
-- 1 row in set (1.15 sec)

-- Store Procedure with INPUT parameter
-- Create a stored procedure to select employee salary by specific employee number
use employees;
drop procedure if exists emp_salary;
delimiter $$
create procedure emp_salary(in p_emp_no integer)
begin
select e.emp_no, e.first_name, e.last_name, s.salary, s.from_date, s.to_date
from employees e join salaries s 
on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;
end $$
delimiter ;

call emp_salary(10004);

-- +--------+------------+-----------+--------+------------+------------+
-- | emp_no | first_name | last_name | salary | from_date  | to_date    |
-- +--------+------------+-----------+--------+------------+------------+
-- |  10004 | Chirstian  | Koblick   |  40054 | 1986-12-01 | 1987-12-01 |
-- |  10004 | Chirstian  | Koblick   |  42283 | 1987-12-01 | 1988-11-30 |
-- |  10004 | Chirstian  | Koblick   |  42542 | 1988-11-30 | 1989-11-30 |
-- |  10004 | Chirstian  | Koblick   |  46065 | 1989-11-30 | 1990-11-30 |
-- |  10004 | Chirstian  | Koblick   |  48271 | 1990-11-30 | 1991-11-30 |
-- |  10004 | Chirstian  | Koblick   |  50594 | 1991-11-30 | 1992-11-29 |
-- |  10004 | Chirstian  | Koblick   |  52119 | 1992-11-29 | 1993-11-29 |
-- |  10004 | Chirstian  | Koblick   |  54693 | 1993-11-29 | 1994-11-29 |
-- |  10004 | Chirstian  | Koblick   |  58326 | 1994-11-29 | 1995-11-29 |
-- |  10004 | Chirstian  | Koblick   |  60770 | 1995-11-29 | 1996-11-28 |
-- |  10004 | Chirstian  | Koblick   |  62566 | 1996-11-28 | 1997-11-28 |
-- |  10004 | Chirstian  | Koblick   |  64340 | 1997-11-28 | 1998-11-28 |
-- |  10004 | Chirstian  | Koblick   |  67096 | 1998-11-28 | 1999-11-28 |
-- |  10004 | Chirstian  | Koblick   |  69722 | 1999-11-28 | 2000-11-27 |
-- |  10004 | Chirstian  | Koblick   |  70698 | 2000-11-27 | 2001-11-27 |
-- |  10004 | Chirstian  | Koblick   |  74057 | 2001-11-27 | 9999-01-01 |
-- +--------+------------+-----------+--------+------------+------------+
-- 16 rows in set (0.00 sec)

-- Query OK, 0 rows affected (0.19 sec)

-- Stored Procedure with INPUT parameter
-- Create a stored procedure to generate the average salary of an employee by emp_no
drop procedure if exists select_emp_avg_salary;
delimiter $$
create procedure select_emp_avg_salary(in p_emp_no integer)
begin
select e.emp_no, e.first_name, e.last_name, avg(s.salary) as avg_salary
from employees e join salaries s
on e.emp_no = s.emp_no
where e.emp_no = p_emp_no
group by e.emp_no;
end $$
delimiter ;

call select_emp_avg_salary(10004);
-- +--------+------------+-----------+------------+
-- | emp_no | first_name | last_name | avg_salary |
-- +--------+------------+-----------+------------+
-- |  10004 | Chirstian  | Koblick   | 56512.2500 |
-- +--------+------------+-----------+------------+
-- 1 row in set (0.00 sec)

-- Stored Procedure with INPUT parameter and OUTPUT parameters
-- Create a stored procedure to generate the average salary of an employee by emp_no
drop procedure if exists select_emp_avg_salary_out;
delimiter $$
create procedure select_emp_avg_salary_out(in p_emp_no integer, out avg_sal decimal(10,2))
begin
select avg(salary)
into avg_sal
from salaries s join employees e
on e.emp_no = s.emp_no
where e.emp_no = p_emp_no
group by e.emp_no;
end $$
delimiter ;

call select_emp_avg_salary_out(10004, @avg_sal);
select @avg_sal;

-- +----------+
-- | @avg_sal |
-- +----------+
-- | 56512.25 |
-- +----------+
-- 1 row in set (0.00 sec



USE employees;
DROP PROCEDURE IF EXISTS emp_info;

DELIMITER $$
CREATE PROCEDURE emp_info(IN p_first_name VARCHAR(255), p_last_name VARCHAR(255), OUT p_emp_no INTEGER)
BEGIN
	SELECT e.emp_no
		INTO p_emp_no
    FROM employees e
    WHERE e.first_name = p_first_name AND e.last_name = p_last_name
    LIMIT 1;
END $$
DELIMITER ;

SET @v_emp_no = 0;
CALL employees.emp_info('Chirstian','Koblick',@v_emp_no);
SELECT @v_emp_no;

-- I need a function to return the average salary of an employee by emp_no
drop function if exists f_avg_salary;
delimiter $$
create function f_avg_salary(p_emp_no integer)
returns decimal(10,2) reads sql data
begin
declare avg_salary decimal(10,2);
select avg(salary) into avg_salary
from salaries where emp_no = p_emp_no;
return avg_salary;
end $$
delimiter ;

SELECT F_AVG_SALARY(10001);
-- +---------------------+
-- | F_AVG_SALARY(10001) |
-- +---------------------+
-- |            75388.94 |
-- +---------------------+
-- 1 row in set (0.01 sec)

-- Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee,  */
-- and returns the salary from the newest contract of that employee.   

drop function if exists f_emp_info;
delimiter $$
create function f_emp_info(fname varchar(255), lname varchar(255))
returns decimal(10,2) reads sql data
begin
declare newest_sal decimal(10,2);
select s.salary into newest_sal
from salaries s join employees e
on e.emp_no = e.emp_no
where e.first_name = fname
and e.last_name = lname
order by s.from_date desc
limit 1;
return newest_sal;
end $$
delimiter ;

-- calling function
select f_emp_info('Bezalel', 'Simmel');
