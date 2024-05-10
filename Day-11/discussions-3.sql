-- Q1 Write a query to display a list of customers who locate in the same city by joining the customers table to itself.
select c.city , c.customerName, m.customerName from customers c inner join customers m
on c.city = m.city where c.customerName<>m.customerName order by c.city;


-- Q2 Write a query to get: The productCode and productName from the products table, The textDescription of product lines from the productlines table.
select p.productCode , p.ProductName , l.textDescription from products p inner join productlines l
on p.productline = l.productline;

-- Q3 Write a query that returns order number, order status, and total sales from the orders and orderdetails tables 
select o.orderNumber , o.status , SUM(priceEach*quantityOrdered) from orders o inner join orderdetails od
on o.orderNumber=od.orderNumber group by od.orderNumber;

-- Q4 Write a query to fetch the complete details of orders from the orders, orderDetails, and products table, and sort them by orderNumber and orderLineNumbe 
select o.orderNumber,o.orderDate, od.orderLineNumber, p.productName, od.quantityOrdered,od.priceEach from orders o 
inner join orderdetails od on o.orderNumber=od.orderNumber
inner join products p on od.productCode=p.productCode
order by orderNumber,orderLineNumber;

-- Q5 Write a query to perform INNER JOIN of four tables 
select o.orderNumber,o.orderdate,c.customerName,od.orderLineNumber,p.productName, od.quantityOrdered,od.priceEach from orders o
inner join customers c on o.customerNumber=c.customerNumber inner join orderdetails od on o.orderNumber=od.orderNumber
inner join products p on od.productCode=p.productCode order by orderNumber,orderLineNumber;

-- Q6 Write a query to find the sales price of the product whose code is S10_1678 that is less than the manufacturer’s suggested retail price (MSRP) for that product 
select od.orderNumber, p.productName, msrp, priceEach from orderdetails od inner join products p on od.productCode=p.productCode
where p.productCode = 'S10_1678' and priceEach<msrp;

-- Q7 Each customer can have zero or more orders while each order must belong to one customer. Write a query to find all the customers and their orders
select c.customerNumber, c.customerName, o.ordernumber, o.status from customers c left join orders o on c.customerNumber=o.customerNumber;

-- Q8 Write a query that uses the LEFT JOIN to find customers who have no order
select c.customerNumber, c.customerName, o.ordernumber, o.status from customers c left join orders o on c.customerNumber=o.customerNumber and o.ordernumber is null;