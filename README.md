
<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

![MySQL](https://img.shields.io/static/v1?style=for-the-badge&message=MySQL&color=4479A1&logo=MySQL&logoColor=FFFFFF&label=)
![Power BI](https://img.shields.io/static/v1?style=for-the-badge&message=Power+BI&color=222222&logo=Power+BI&logoColor=F2C811&label=)
[![MIT License][license-shield]][license-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">

  <h3 align="center"> HR Insights With MySQL and PowerBI</h3>

  <p align="center">
    Featuring dashboarding, DAX and SQL
    <br />
    <a href="https://joshuaolubori.my.canva.site/project-001"><strong>View project website »</strong></a>
    <br />


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#database">Database creation and querying</a></li>
      </ul>
    </li>
    <li>
      <a href="#dashboarding">Dashboarding</a>
      <ul>
        <li><a href="#data-transformation">Data transformation </a></li>
        <li><a href="#dax-measures">DAX Measures</a></li> 
<li><a href="#contact">Contact</a></li>
      </ul>
    </li>
  
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project 🍪 

![Dashboard](https://github.com/JoshuaOlubori/sql-employee-analysis-a/blob/ddfa9521399eadd8cea5f425101dffd880edaa39/dashboard.PNG)

Using SQL to help HR department and designing a PowerBI report to help the HR team search for employee details


### Database creation and querying

First, I created the database on MySQL using INSERT statements and the I queried the database based queries organized into 9 key SQL concepts, each in its own folder in this Github repo, to showcase my proficiences clearly.


<!-- -->
## Dashboarding 📊

For the dashboard design (as with all of my designs generally), I initially had decision paralysis in trying to decide what design pattern to use. I eventually stuck with a minimalist black and white design that I really like.

### Data transformation 🦋

I created a connection to the instance of MySQL on my machine by providing the server name and the database name as shown below .
Instead of connecting to the whole database and importing all tables, I only imported two views that I had created earlier, as best practice suggests to limit data access.
The views encompass joins that would otherwise have impacted the performance of the Power BI engine if the raw tables were imported.

Before loading the data, I used Power Query to check for errors in the data like nulls or misspellings. Later on while writing DAX, I figured I would need a `Age` column, so I went back to Power Query to use the Columns From Example feature to generate ages from the birthdate column in the employees table.

### DAX Measures ✨

As most Power BI experts preach, I avoided using implicit measures and stuck to writing all my measures in DAX.
Here’s a list of DAX measures I wrote can be found here:

   ```% Female = DIVIDE([Total Female Employees], [Head Count])
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
   ```


<!-- CONTACT  ☎️ -->
## Contact

Edun Joshua Olubori - [@your_linkedin](https://www.linkedin.com/in/joshua-edun) - joshuaolubori@gmail.com

Project Link: [https://github.com/your_username/repo_name](https://joshuaolubori.my.canva.site/project-001)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



