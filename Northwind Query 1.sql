use Northwind;
SELECT 
    CategoryName, Description
FROM
    categories
ORDER BY CategoryName;
SELECT 
    ContactName, CompanyName, ContactTitle, Phone
FROM
    Customers
ORDER BY Phone;
SELECT 
    UPPER(FirstName) AS First_Name,
    UPPER(LastName) AS Last_Name,
    HireDate
FROM
    employees
ORDER BY HireDate;
SELECT 
    OrderID, OrderDate, ShippedDate, CustomerID, Freight
FROM
    Orders
ORDER BY Freight DESC
LIMIT 10;
SELECT 
    LOWER(CustomerID) AS ID
FROM
    customers;
SELECT 
    CompanyName, Fax, Phone, Country, HomePage
FROM
    suppliers
ORDER BY Country DESC , CompanyName ASC;
SELECT 
    CompanyName, ContactName, ContactName
FROM
    customers
WHERE
    city = 'Buenos Aires'

SELECT ProductName, UnitPrice, QuantityPerUnit
FROM
    products
WHERE
    discontinued = 'y';

SELECT 
    ContactName, Address, City
FROM
    customers
WHERE
    country NOT IN ('Germany' , 'Mexico', 'Spain');

SELECT 
    OrderDate, ShippedDate, CustomerID, Freight
FROM
    orders
WHERE
    OrderDate = 1996 - 05 - 21;
    
# Create a report showing FirstName, LastName, Country from the employees not from United States.
select FirstName, LastName, Country
from employees
where Country not in ("USA"); # try country <> "USA"


