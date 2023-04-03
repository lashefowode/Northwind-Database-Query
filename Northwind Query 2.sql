use northwind;
# Create a report that shows the EmployeeID, OrderID, CustomerID, RequiredDate, ShippedDate from all orders shipped later than the required date
select EmployeeID, OrderID, CustomerID, RequiredDate, ShippedDate
from orders
where ShippedDate > RequiredDate; #ShippedDate is above RequiredDate

# Create a report that shows the City, CompanyName, ContactName of customers from cities starting with A or B.
select City, CompanyName, ContactName
from customers
where city like ("A%") or city like ("B%");

# Create a report showing all the even numbers of OrderID from the orders table.
select OrderID
from orders
where mod(OrderID,2)=0;   # even number work

-- Create a report that shows all the orders where the freight cost more than $500.
select *
from orders
where freight> 500;

# Create a report that shows the ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel of all products that are up for reorder.
select ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel 
from products
where ReorderLevel = 0;# 0 means No products left

#Create a report that shows the CompanyName, ContactName number of all customer that have no fax number.
select CompanyName, ContactName, Fax
from customers
where Fax =" "
group by CustomerID;
# Top or Bottom,open to debate, I personally believe its the TOP
SELECT CompanyName,ContactName,Fax
FROM northwind.customers
WHERE Fax IS not NULL;


# Create a report that shows the FirstName, LastName of all employees that do not report to anybody.
select FirstName, LastName, ReportsTo
from employees
where ReportsTo is NULL;

# Create a report showing all the odd numbers of OrderID from the orders table.
select OrderID as odd_number_OrderID
from orders
where mod(OrderID,2)=1;

# Create a report that shows the CompanyName, ContactName, Fax of all customers that do not have Fax number and sorted by ContactName.
select CompanyName, ContactName, Fax
from customers
where fax =" "
order by ContactName; 

#Create a report that shows the City, CompanyName, ContactName of customers from cities that has letter L in the name sorted by ContactName.
select City, CompanyName, ContactName
from customers
where city like ("%L%")
order by ContactName;

# Create a report that shows the FirstName, LastName, BirthDate of employees born in the 1950s.
select FirstName, LastName, BirthDate
from employees
where BirthDate like("195%");
#   OR
SELECT FirstName, LastName,BirthDate
FROM employees
where BirthDate between "1950-01-01" and "1960-01-01";

# Create a report that shows the FirstName, LastName, the year of Birthdate as birth year from the employees table.
select FirstName, LastName, year(Birthdate) as birthyear # just like df['year'] = pd.DatetimeIndex(covid_df.date).year
from employees;

#Create a report showing OrderID, total number of Order ID as NumberofOrders 
#from the orderdetails table grouped by OrderID and sorted by NumberofOrders in descending order. 
#HINT: you will need to use a Groupby statement.

select OrderID, sum(OrderID) as NumberofOrders
from order_details
group by OrderID
order by NumberofOrders;

# Create a report that shows the SupplierID, ProductName, CompanyName from all product 
#Supplied by Exotic Liquids, Specialty Biscuits, Ltd., Escargots Nouveaux sorted by the supplier ID

SELECT 
    s.SupplierID, p.ProductName, s.CompanyName
FROM
    suppliers s
        LEFT JOIN
    products p ON p.SupplierID = s.SupplierID
WHERE
    s.CompanyName IN ("Exotic Liquids","Specialty Biscuits, Ltd.", "Escargots Nouveaux")
ORDER BY s.supplierID;

SELECT s.SupplierID, p.ProductName, s.CompanyName
FROM northwind.suppliers s
JOIN northwind.products p
ON s.SupplierID = p.SupplierID
WHERE s.CompanyName IN ('Exotic Liquids','Specialty Biscuits, Ltd.','Escargots Nouveaux')
ORDER BY s.SupplierID;

#Create a report that shows the 
#ShipPostalCode, OrderID, OrderDate, RequiredDate, ShippedDate, ShipAddress 
#of all orders with ShipPostalCode beginning with "98124".

select ShipPostalCode, OrderID, OrderDate, RequiredDate, ShippedDate, ShipAddress
from orders
where ShipPostalCode >= 98124;   # it may be just =98124
# Create a report that shows the ContactName, ContactTitle, CompanyName of customers that the has no "Sales" in their ContactTitle.
select ContactName, ContactTitle, ContactTitle, CompanyNAme
from customers
where ContactTitle not like "%Sales%";

# 28. Create a report that shows the LastName, FirstName, City of employees in cities other "Seattle";
select LastName, FirstName, City
from employees 
where cities not like "%Seattle%";

#Create a report that shows the CompanyName, ContactTitle, City, Country of all customers in any city in Mexico or other cities in Spain other than Madrid
select CompanyName, ContactTitle, City, Country
from customers
where country in ("Mexico", "Spain")
and city <> "Madrid";

SELECT CompanyName, ContactTitle, City, Country
FROM northwind.customers
WHERE Country IN ("Mexico","Spain")
AND City <> "Madrid";

select concat(FirstName," ",LastName," ","can be reached at x",Extension) as ContactInfo
from employees;

# 31. Create a report that shows the ContactName of all customers that do not have letter A as the second alphabet in their Contactname.
select ContactName
from customers
where ContactName not like "_a%";

# 32. Create a report that shows the average UnitPrice rounded to the next whole number,
# total price of UnitsInStock and maximum number of orders from the products table. All saved as AveragePrice, TotalStock and MaxOrder respectively.
select round(avg(UnitPrice),0) as AveragePrice, sum(unitsinstock) as TotalStock, max(UnitsOnOrder) as MaxOrder
from products;
# 33. Create a report that shows the SupplierID, CompanyName, CategoryName, ProductName and UnitPrice from the products, suppliers and categories table.
select s.SupplierID, s.CompanyName, c.CategoryName, p.ProductName, p.UnitPrice
from products p
join categories c on p.CategoryID= c.CategoryID
join suppliers s on  s.SupplierID= p.SupplierID;

# 34. Create a report that shows the CustomerID, sum of Freight, 
#from the orders table with sum of freight greater $200, grouped by CustomerID. HINT: you will need to use a Groupby and a Having statement.
select CustomerID, sum(Freight) as sum_of_Freight
from orders
group by CustomerID
having sum(freight)> 200;

# Create a report that shows the OrderID ContactName, UnitPrice, Quantity, Discount from the order details, orders and customers table with discount given on every purchase.
select o.OrderID, c.ContactName, od.UnitPrice, od.Quantity, od.Discount
from order_details od
join orders o on od.orderID=o.orderID
join customers c on o.customerID=c.customerID
where Discount != 0;

# 36. Create a report that shows the EmployeeID, the LastName and FirstName as employee, and the LastName and FirstName of who they report to as manager 
#from the employees table sorted by Employee ID. HINT: This is a SelfJoin.
SELECT e1.EmployeeID, 
concat (e1.LastName," " ,e1.FirstName) as employees,
 concat ( e2.FirstName," " ,e2.LastName) as manager 
from employees e1
join  employees e2 on e2.EmployeeID= e1.ReportsTo  # we can relate it like this because it's on the same table
group by EmployeeID
order by employees;

# Create a report that shows the average, minimum and maximum UnitPrice of all products as AveragePrice, MinimumPrice and MaximumPrice respectively.
select ProductName, avg(UnitPrice)as AveragePrice, min(UnitPrice) as MinimumPrice, max(UnitPrice) as MaximumPrice
from products
group by ProductName
order by ProductName;

# Create a view named CustomerInfo that shows the CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Country, Phone, OrderDate, RequiredDate, ShippedDate 
#from the customers and orders table. HINT: Create a View. 
CREATE OR REPLACE VIEW CustomerInfo as
select c.CustomerID, c.CompanyName, c.ContactNAme, c.ContactTitle,c.Address, c.City, c.Country, c.Phone, o.OrderDate,o.RequiredDate, o.ShippedDate
from customers c
join orders o ON c.customerID= o.customerID
Group By CustomerID;

#39. Change the name of the view you created from customerinfo to customer details.
RENAME TABLE CustomerInfo TO Customerdetails;

#40. Create a view named ProductDetails that shows the ProductID, CompanyName, ProductName, CategoryName, Description, 
#QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued 
#from the supplier, products and categories tables. HINT: Create a View
CREATE OR REPLACE VIEW ProductDetails as
select p.ProductID, s.CompanyName, p.ProductName, c.CategoryName, c.Description, p.QuantityPerUnit, p.UnitPrice, p.UnitsInStock, 
p.UnitsOnOrder, p.ReorderLevel, p.Discontinued

from suppliers s
join products p ON s.SupplierID=p.SupplierID
join categories c ON p.CategoryID=c.CategoryID
Group by ProductID
Order by ProductID;

# Drop the customer details view.
Drop View if exists ProductDetails;

# Create a report that fetch the first 5 character of categoryName from the category tables and renamed as ShortInfo
select substring(c.CategoryName,1,5) as Short_Info
from Categories c;

# 43. Create a copy of the shipper table as shippers_duplicate. Then insert a copy of shippers data into the new table 
#HINT: Create a Table, use the LIKE Statement and INSERT INTO statement.
drop table if exists shippers_duplicate;
CREATE TABLE IF NOT EXISTS shippers_duplicate (
    ShipperID INT(11) NOT NULL AUTO_INCREMENT,
    CompanyName VARCHAR(255) NULL,
    Phone VARCHAR(255) NOT NULL,
    PRIMARY KEY (ShipperID)
)  ENGINE=INNODB AUTO_INCREMENT=9 DEFAULT CHARSET=UTF8;
insert into shippers_duplicate
select * from shippers;
# OR
DROP table IF exists shippers_dup;
CREATE TABLE shippers_dup (LIKE shippers);
INSERT INTO shippers_dup SELECT * FROM shippers;

# Drop table if exists shippers_dup;
-- Create table shippers_dup(LIKE shippers);-- 
-- Insert into shippers_dup select * from shippers;

alter table shippers_duplicate
ADD Email Varchar(255) NULL;
UPDATE shippers_duplicate
SET Email ='speedyexpress@gmail.com'
WHERE ShipperID = '1';

UPDATE shippers_duplicate
SET Email= "unitedpackage@gmail.com"
WHERE ShipperID= "2";

UPDATE shippers_duplicate
SET Email="federalshipping@gmail.com"
WHERE ShipperID= "3";

# Create a report that shows the CompanyName and ProductName from all product in the Seafood category.
select  s.CompanyName, p.ProductName     # , p.CategoryID
from suppliers s
join products p ON s.SupplierID=p.SupplierID
join categories c ON p.CategoryID=c.CategoryID
 where c.categoryName="Seafood";
# where p.categoryID= 8;

# Create a report that shows the CategoryID, CompanyName and ProductName from all product in the categoryID 5.
select   p.CategoryID, s.CompanyName, p.ProductName
from suppliers s
join products p ON s.SupplierID=p.SupplierID
join categories c ON p.CategoryID=c.CategoryID
where p.categoryID= 5;

# Delete the shippers_duplicate table.
drop table if exists shippers_dup;  # or shippers_duplicate depending on how you saved it

# Create a select statement that ouputs the following from the employees table(It's in the PDF).
#LName, FNamve,title,age
select LastName, FirstName,title, date_format(FROM_DAYS(DATEDIFF(NOW(),BirthDate)),"%Y Years") as Age
from employees;

#Create a report that the CompanyName and total number of orders by customer renamed as number of orders since Decemeber 31, 1994. 
# Show number of Orders greater than 10.
select c.CompanyName, count(o.OrderID) as number_of_orders
from customers c
join orders o ON c.CustomerID=o.CustomerID
where o.orderDate >= "1994-12-31 00:00:00"
group by c.CompanyName
having count(o.OrderID) >10;
## OR
SELECT c.CompanyName, count(c.CustomerID) AS NumberofOrders
FROM northwind.customers c
JOIN northwind.orders o
ON o.CustomerID = c.CustomerID
WHERE o.OrderDate >= '1994-12-31'
GROUP BY c.CustomerID
having count(c.CustomerID) > 10;

select concat(ProductName, " weighs/is", QuantityPerUnit, "and cost ", "$",UnitPrice) as ProductInfo
from products;