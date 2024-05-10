-1 Write a query to find the addresses (location_id, street_address, city, state_province, country_name) of all the departments.
select department_name,LOCATION_ID,street_address,city,state_province,country_name from locations inner join countries using(COUNTRY_ID) inner join departments
using(LOCATION_ID) group by DEPARTMENT_ID;

--2 Write a query to find the name (first_name, last name), department ID, and department name of all the employees.
select CONCAT(first_name," ",last_name) as name,department_id,department_name from employees inner join departments using(DEPARTMENT_ID);

--3 Write a query to find the name (first_name, last_name), job, department ID, and name of the employees who work in London.
select concat(first_name, " ", last_name) as name,job_title,department_id from employees inner join jobs
using(JOB_ID) inner join departments
using(DEPARTMENT_ID) where location_id in
(select location_id from locations where city="London");

--4 Write a query to find the employee id, name (last_name) along with their manager_id, and name (last_name).
select e1.employee_id,e1.last_name,e1.manager_id,e2.last_name from employees e1 inner join employees e2 on e1.manager_id = e2.employee_id;

--5 Write a query to find the name (first_name, last_name) and hire date of the employees who were hired after 'Jones'.
select concat(first_name, " ", last_name) as name,hire_date from employees where hire_date > (select HIRE_DATE from employees 
where last_name="Jones");

--6 Write a query to get the department name and number of employees in the department.
select department_name,count(*) as noOfEmployees from employees inner join departments using(DEPARTMENT_ID) group by DEPARTMENT_ID;

--7 Write a query to find the employee ID, job title, number of days between the en ding date and the starting date for all jobs in department 90.
select employee_id,job_title,day(end_date)-day(start_date) as diff from job_history inner join jobs using(JOB_ID) where department_id=90;

--8 Write a query to display the department ID and name and first name of the manager.
select e1.department_id,CONCAT(e1.first_name, " ",e1.last_name) as name e2.first_name from employees e1 inner join
employees e2 on e1.manager_id=e2.employee_id;

--9 Write a query to display the department name, manager name, and city.
select department_name,CONCAT(first_name, " ",last_name) as manager,city from employees inner join departments d using(department_id) inner join locations
using(location_id) where employee_id=d.manager_id;

--10 Write a query to display the job title and average salary of employees.
select job_title,avg(salary) from jobs inner join employees using(job_id) group by job_id;

--11 Write a query to display job title, employee name, and the difference between the salary of the employee and minimum salary for the job.
select job_title,concat(first_name, " ", last_name) as emp_name, salary-min_salary as sal_diff from employees inner join jobs using(job_id);

--12 Write a query to display the job history of any employee who is currently drawing more than 10000 of salary.
select job_history.* from job_history INNER JOIN employees using(employee_id) where salary>10000;

--13 Write a query to display department name, name (first_name, last_name), hire date, the salary of the manager for all managers whose experience is more than 15 years.
select department_name,concat(first_name, " ",last_name) as name,hire_date, salary from employees inner join departments d using(DEPARTMENT_ID)
inner join job_history using(EMPLOYEE_ID) where employee_id=d.manager_id and end_date-start_date>15;