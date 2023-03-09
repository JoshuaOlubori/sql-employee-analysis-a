-- how many people have been hired after the 1st Jan of 2000?
select count(emp_no) from employees where hire_date > '2000-01-01';

-- now create index on hire_date assuming that we use that field a lot in our queries
create index i_hire_date
on employees (hire_date);

-- now create a composite Index, that is one that encompasses multiple columns
SELECT * FROM employees
WHERE first_name = "Georgi" AND last_name = "Facello";

CREATE INDEX i_composite
ON employees(first_name,last_name);

-- Drop the ‘i_hire_date’ index.
ALTER TABLE employees
DROP INDEX i_hire_date;

-- Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum.
-- Then, create an index on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement.*/
SELECT salary FROM salaries
WHERE salary > 89000;

CREATE INDEX i_salary
ON salaries(salary);

SELECT salary FROM salaries
WHERE salary > 89000;
