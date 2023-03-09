-- Creating views to be queried by Power BI

CREATE OR REPLACE VIEW v_employee_details AS
    SELECT 
        emp.*,
        sal.salary,
        sal.from_date AS salary_from_date,
        sal.to_date AS salary_to_date,
        titles.title,
        titles.from_date AS title_from_date,
        titles.to_date AS title_to_date,
        d.dept_name,
        de.dept_no,
        de.from_date AS dept_start_date,
        de.to_date AS dept_end_date
    FROM
        employees emp
            INNER JOIN
        salaries sal ON emp.emp_no = sal.emp_no
            LEFT JOIN
        titles ON emp.emp_no = titles.emp_no
            LEFT JOIN
        dept_emp de ON de.emp_no = emp.emp_no
            LEFT JOIN
        departments d ON d.dept_no = de.dept_no;
        
--

CREATE OR REPLACE VIEW v_manager_details AS
    SELECT 
        emp.*, d.dept_name, dm.from_date, dm.to_date
    FROM
        dept_manager dm
            INNER JOIN
        employees emp ON dm.emp_no = emp.emp_no
            INNER JOIN
        departments d ON d.dept_no = dm.dept_no


