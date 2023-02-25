-- 1. Select ten records from the “titles” table to get a better idea about its content. Then, in the same table, insert information about employee number 999903. State that he/she is a “Senior Engineer”, 
-- 999903,'1977-09-14','Johnathan','Creek','M','1999-01-01'
-- who has started working in this position on October 1st, 1997.
SELECT 
    *
FROM
    titles
LIMIT 10;
insert into employees values (999903, '1977-09-14', 'Johnathan', 'Creek', 'M', '1999-01-01');
SELECT 
    *
FROM
    employees
WHERE
    emp_no = 999903; -- successful insert confirmed
    
insert into titles values(999903, 'Senior Engineer','1977-10-01', '9999-01-01');
SELECT 
    *
FROM
    titles
ORDER BY 1 DESC; -- successful insert confirmed
    
-- 2. Insert information about the individual with employee number 999903 into the “dept_emp” table. 
-- He/She is working for department number 5, and has started work on  October 1st, 1997; 
-- her/his contract is for an indefinite period of time.
insert into dept_emp 
values(999903, 'd005', '1997-10-01', '9999-01-01');
SELECT 
    *
FROM
    dept_emp
WHERE
    emp_no = 999903; -- successful insert confirmed