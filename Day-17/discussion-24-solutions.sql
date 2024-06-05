--1 Create an updatable view that includes customerNumber, customerName, contactLastName, and contactFirstName from the customers table. Then, try to update the contactFirstName for a specific customerNumber.
create view customer_view as select customerNumber, customerName, contactLastName, contactFirstName from customers;

--2 Create a read-only view that joins the orderdetails table and the products table on productCode and includes orderNumber, productName, and quantityOrdered. Try to update the quantityOrdered for a specific orderNumber and see what happens.
create view order_product_view as select od.orderNumber, p.productName, od.quantityOrdered from orderdetails od join products p on od.productCode = p.productCode;

--3 Write a query that uses an inline view to get the total number of orders for each customer. The inline view should select customerNumber and orderNumber from the orders table. The main query should then group by customerNumber.
select iv.customerNumber, COUNT(iv.orderNumber) as total_orders from(select customerNumber, orderNumber from orders) as iv group by iv.customerNumber;

--4 create a stored procedure that creates a new table with productName and totalQuantityOrdered (this total should be aggregated from the orderdetails table). Then, create an AFTER INSERT trigger on the orderdetails table that calls this stored procedure to update the table (acting as a materialized view) whenever a new order detail is inserted.
create procedure refresh_materialized_view()
begin
  create table materialized_view as
  select p.productName, SUM(od.quantityOrdered) as totalQuantityOrdered
  from orderdetails od 
  join products p on od.productCode = p.productCode
  group by p.productName;
end;

create trigger orderdetails_after_insert after insert on orderdetails for EACH row call refresh_materialized_view();