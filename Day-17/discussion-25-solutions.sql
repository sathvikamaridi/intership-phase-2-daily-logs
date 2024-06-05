--1 Scenario 1: Advanced Analytics Dashboard You're working as a data engineer for Classic Models and your task is to create an advanced analytics dashboard for the sales team. They are interested in a daily report showing the number of orders, total sales, and the most purchased product of each day. This is quite a complex query, so you decide to use views to break down the problem:
  --Create an inline view to calculate the daily total sales.
  --Create an updatable view to show the number of orders for each day. Also include a functionality to update the order status in the same view.
  --Create a view to identify the most purchased product of each day.
create view daily_sales as SELECT DATE(orderDate) as order_date, SUM(quantityOrdered * priceEach) AS total_sales 
FROM orders JOIN orderdetails USING (orderNumber) GROUP BY order_date;


create view daily_orders as select date(orderDate) AS order_date, COUNT(orderNumber) AS num_orders, status FROM orders GROUP BY order_date, status;

update daily_orders SET status = 'new_status' WHERE order_date = 'some_date';

create view daily_top_product AS select date(orderDate) as order_date, productCode, SUM(quantityOrdered) as total_quantity 
from orders join orderdetails USING (orderNumber) group by order_date, productCode order by total_quantity desc;

--2 Scenario 2: Sales Monitoring System
 --Classic Models has a system to monitor the performance of sales reps. The sales reps' performance is judged based on the number of customers handled, total payments received, and the total number of orders. The details of sales reps are in the employees table and the sales are recorded in the orders and payments tables.
 --Create a view that shows the total number of customers handled by each sales rep.
 --Create a view that displays the total payments received by each sales rep.
 --Create another view that shows the total number of orders handled by each sales rep.
create view rep_customers as
select employeeNumber, COUNT(DISTINCT customerNumber) as num_customers from customers group by employeeNumber;

create view rep_payments as select employeeNumber, SUM(amount) as total_payments
from customers join payments using (customerNumber) group by employeeNumber;

create view rep_orders as
select employeeNumber, COUNT(distinct orderNumber) as num_orders from customers join orders using (customerNumber) group by employeeNumber;

--3 Scenario 3: HR and Sales Data Analysis
   --Assume the Classic Models has recently acquired a company and you now also have access to the hr database. The management wants to know if there's a relationship between employee's department, age, and their sales performance.
   --Create a view in the hr database that shows the department and age of each employee.
   --Create a view in the classicmodels database that shows the sales performance of each employee.
   --As MySQL doesn't support cross-database queries in the form of database.schema.table, you may need to combine the data in one database or manually join the exported data from these views in a tool like Python or Excel to analyze the combined data.
create view emp_details as
select employee_id, department_id, TIMESTAMPDIFF(year, birth_date, CURDATE()) as age from employees;

create view emp_sales_performance as select employeeNumber, SUM(amount) as total_sales
from customers join payments using(customerNumber) group by employeeNumber;