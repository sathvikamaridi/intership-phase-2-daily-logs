--Task 1.1 Total Sales by Product Line
select p.productLine,sum(od.quantityOrdered * od.priceEach) as totalSales from orderdetails od join products p on od.productCode = p.productCode group by p.productLine;

--Task 1.2 Total Quantity Sold by Product Line
select p.productLine,sum(od.quantityOrdered) as totalQuantitySold from orderdetails od join products p on od.productCode = p.productCode group by p.productLine;

--Task 2.1 Average Sale Amount by Product Line with Filtering
select p.productLine,avg(od.quantityOrdered * od.priceEach) as avgSaleAmount from orderdetails od join products p on od.productCode = p.productCode group by p.productLine
having avgSaleAmount > 500;

--Task 3.1 Average Population and Total GDP by Continent
select c.Continent,avg(c.Population) as avgPopulation,sum(c.GNP) as totalGDP from country c group by c.Continent;

--Task 3.2 Countries with Multiple Official Languages
select c.Name as countryName,count(cl.Language) as numOfOfficialLanguages from country c join countrylanguage cl on c.Code = cl.CountryCode where cl.IsOfficial = 'T' group by c.Code
having numOfOfficialLanguages > 2;

--Task 4.1 Month-over-Month Sales Growth
select year(o.orderDate) as orderYear,month(o.orderDate) as orderMonth,p.productLine,(sum(od.quantityOrdered * od.priceEach) - lag(sum(od.quantityOrdered * od.priceEach), 1, 0) over (order by year(o.orderDate), month(o.orderDate))) / lag(sum(od.quantityOrdered * od.priceEach), 1, 0) 
OVER (order by year(o.orderDate),month(o.orderDate)) as salesGrowthPercentage from orders o
join orderdetails od on o.orderNumber = od.orderNumber
join products p on od.productCode = p.productCode
group by year(o.orderDate),month(o.orderDate), p.productLine;

--Task 4.2 Quarterly Sales Analysis
select year(o.orderDate) as orderYear,quarter(o.orderDate) as orderQuarter,o.officeCode,sum(od.quantityOrdered * od.priceEach) as totalQuarterlySales
from orders o join orderdetails od on o.orderNumber = od.orderNumber group by year(o.orderDate),quarter(o.orderDate), o.officeCode;