Title: HR Insights with MySQL and Power BI

Industry focus: HR

Problem statement: Deep dive into company's HR database to answer internal questions about the workforce.

Business use case: 1. Finding managers information
2. Creating views as limit data access
3. Persisting stored procedures in the database to automate queries
4. and lots more.

Goals/Metrics: Query the organization's database to answer questions from the HR department and create a Power BI dashboard to visualize (i) Overall metrics (Headcount, number of employees per department etc) and (ii)specific details for each employee.

Deliverables: A Power BI dashboard illustrating your findings

I created the following measures in Power BI by writing DAX:

% Female = DIVIDE([Total Female Employees], [Head Count])
% Male = DIVIDE([Total Male Employees],[Head Count])

Age = 
    IFERROR(
    VALUES('employees v_employee_details'[Age]),
    "select an employee")

Avg Salary = AVERAGE('employees v_employee_details'[salary])

Current Department = CALCULATE(VALUES('employees v_employee_details'[dept_name]),'employees v_employee_details'[dept_start_date] = MAX('employees v_employee_details'[dept_start_date]))

Current Salary = 
    IFERROR(
    CALCULATE(VALUES('employees v_employee_details'[salary]),
    'employees v_employee_details'[salary_from_date] = MAX('employees v_employee_details'[salary_from_date])),
    "select an employee")

Current Title = 
    IFERROR(
    CALCULATE(VALUES('employees v_employee_details'[title]),
    'employees v_employee_details'[title_from_date] = MAX('employees v_employee_details'[title_from_date])),
    "select an employee")

Employee Full Name = SELECTEDVALUE('employees v_employee_details'[first_name]) & " " & SELECTEDVALUE('employees v_employee_details'[last_name])

Gender = 
    IFERROR(
    VALUES(('employees v_employee_details'[gender])),
    "select an employee")

Head Count = DISTINCTCOUNT('employees v_employee_details'[emp_no])

Max Employee Age = MAX('employees v_employee_details'[Age])

Total Amount Spent on Salary = SUM('employees v_employee_details'[salary])

Total Female Employees = CALCULATE([Head Count],'employees v_employee_details'[gender] = "F")

Total Male Employees = calculate([Head Count], 'employees v_employee_details'[gender] = "M")

Welcome Text = 
VAR Hour = HOUR(NOW())
VAR Greeting =
SWITCH(
	TRUE(),
	Hour >= 0 && Hour < 5, "Good Night",
	Hour >= 5 && Hour < 12, "Good Morning",
	Hour >= 12 && Hour < 18, "Good Afternoon",
	Hour >= 18 && Hour < 24, "Good Afternoon"
)
RETURN
Greeting & ", Boss!"