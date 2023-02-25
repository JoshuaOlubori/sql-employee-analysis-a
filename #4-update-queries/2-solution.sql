SET AUTOCOMMIT = 0; -- turning off autocommit
UPDATE departments set dept_name = 'Data Analysis' where dept_no = 'd010'; -- updating the table
select * from departments;
ROLLBACK; -- reverse the change

select * from departments; -- confirm that the change has been rolled back
UPDATE departments set dept_name = 'Data Analysis' where dept_no = 'd010'; -- repeat the change
COMMIT; -- persist the change to the database
select * from departments; -- confirm the change has been committed
SET AUTOCOMMIT = 1; -- turn autocommit back on
