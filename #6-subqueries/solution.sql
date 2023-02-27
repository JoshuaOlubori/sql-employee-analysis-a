-- 1. Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995.

-- +--------+---------+------------+------------+
-- | emp_no | dept_no | from_date  | to_date    |
-- +--------+---------+------------+------------+
-- | 110420 | d004    | 1996-08-30 | 9999-01-01 |
-- | 111877 | d009    | 1992-09-08 | 1996-01-03 |
-- +--------+---------+------------+------------+
-- 2 rows in set (0.00 sec)

-- SAME RESULTS CAN BE ACHIEVED WITH JOINS AS SHOWN BELOW. GENERALLY, JOIN ARE PREFERRED
-- OVER SUBQUERIES FOR PERFORMANCE REASONS
select * from dept_manager 
where emp_no in (
select emp_no from employees where hire_date between '1990-01-01' and '1995-01-01');

-- TEST FOR EQUIVALENCE OF QUERIES (SUBQUERY VS. JOIN)
with subq as (
select * from dept_manager 
where emp_no in (
select emp_no from employees where hire_date between '1990-01-01' and '1995-01-01')),
join_q as (
select dm.* from dept_manager dm inner join employees e
on dm.emp_no = e.emp_no
where e.hire_date between '1990-01-01' and '1995-01-01'
)
(select * from subq except select * from join_q)
union all
(select * from join_q except select * from subq);

-- Empty set (0.06 sec)
-- No rows returned therefore queries are equivalent

-- 2. Select the entire information for all employees whose job title is “Assistant Engineer”.

select * from employees where emp_no in (
select emp_no from titles where title = 'Senior Engineer'));

-- +--------+------------+------------+-----------+--------+------------+
-- | emp_no | birth_date | first_name | last_name | gender | hire_date  |
-- +--------+------------+------------+-----------+--------+------------+
-- |  10008 | 1958-02-19 | Saniya     | Kalloufi  | M      | 1994-09-15 |
-- |  10009 | 1952-04-19 | Sumant     | Peac      | F      | 1985-02-18 |
-- |  10024 | 1958-09-05 | Suzette    | Pettey    | F      | 1997-05-19 |
-- |  10066 | 1952-11-13 | Kwee       | Schusler  | M      | 1986-02-26 |
-- |  10102 | 1959-11-04 | Paraskevi  | Luby      | F      | 1994-01-26 |
-- |  10123 | 1962-05-12 | Hinrich    | Randi     | M      | 1993-01-15 |
-- |  10135 | 1956-12-23 | Nathan     | Monkewich | M      | 1988-02-19 |
-- ...				...				...			...			...			
-- +--------+------------+------------+-----------+--------+------------+
-- 1000+ rows in set (0.00 sec)

-- 3. Starting your code with “DROP TABLE”, create a table called “emp_manager” 
-- (emp_no – integer of 11, not null; dept_no – CHAR of 4, null; manager_no – integer of 11, not null).
drop table if exists emp_manager;
create table emp_manager (
emp_no int(11) not null,
dept_no char(4) null,
manager_no int(11) not null
);

-- Fill emp_manager with data about employees, the number of the department they are working in, and their managers.
-- Your output must contain 42 rows.

insert into emp_manager 
SELECT 
    u.*
FROM
    (SELECT 
        a.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a UNION SELECT 
        b.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b UNION SELECT 
        c.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS c UNION SELECT 
        d.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS d) as u;

        a.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a UNION SELECT 
        b.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b UNION SELECT 
        c.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS c UNION SELECT 
        d.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS d) as u;
    
-- SELF-JOIN
-- 11. From emp_manager table, extract the record only for those employees who are manager as well
select e1.* from emp_manager e1 inner join emp_manager e2
on e1.emp_no = e2.manager_no
group by e1.emp_no;