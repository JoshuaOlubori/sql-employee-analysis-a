-- Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch. 
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