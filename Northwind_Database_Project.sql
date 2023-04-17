-- SALES REVENUE
-- YEARLY REVENUE 2016 - 2018

WITH yearly_rev AS (
  SELECT strftime('%Y', OrderDate) AS Year,
         SUM((UnitPrice * Quantity * (1 - Discount) / 100) * 100) AS ProductSales,
         SUM(Freight) AS FreightCost
  FROM Invoices
  GROUP BY Year
)
SELECT Year, ProductSales, FreightCost, (ProductSales - FreightCost) AS NetSales
FROM yearly_rev;



-- REVENUE COMPARISON FOR SIMILAR PERIODS OVER DIFFERENT YEARS

SELECT 
  'Jul-Dec 2016' AS Period,
  SUM((UnitPrice * Quantity * (1 - Discount) / 100) * 100) AS ProductSales,
  SUM(Freight) AS FreightCost,
  SUM((UnitPrice * Quantity * (1 - Discount) / 100) * 100) - SUM(Freight) AS NetSales
FROM Invoices
WHERE strftime('%Y-%m', OrderDate) BETWEEN '2016-07' AND '2016-12'
UNION
SELECT 
  'Jan-May 2017' AS Period,
  SUM((UnitPrice * Quantity * (1 - Discount) / 100) * 100) AS ProductSales,
  SUM(Freight) AS FreightCost,
  SUM((UnitPrice * Quantity * (1 - Discount) / 100) * 100) - SUM(Freight) AS NetSales
FROM Invoices
WHERE strftime('%Y-%m', OrderDate) BETWEEN '2017-01' AND '2017-05'
UNION
SELECT 
  'Jul-Dec 2017' AS Period,
  SUM((UnitPrice * Quantity * (1 - Discount) / 100) * 100) AS ProductSales,
  SUM(Freight) AS FreightCost,
  SUM((UnitPrice * Quantity * (1 - Discount) / 100) * 100) - SUM(Freight) AS NetSales
FROM Invoices
WHERE strftime('%Y-%m', OrderDate) BETWEEN '2017-07' AND '2017-12'
UNION
SELECT 
  'Jan-May 2018' AS Period,
  SUM((UnitPrice * Quantity * (1 - Discount) / 100) * 100) AS ProductSales,
  SUM(Freight) AS FreightCost,
  SUM((UnitPrice * Quantity * (1 - Discount) / 100) * 100) - SUM(Freight) AS NetSales
FROM Invoices
WHERE strftime('%Y-%m', OrderDate) BETWEEN '2018-01' AND '2018-05';



-- TOP 10 SELLING PRODUCTS BY NUMBER

Select od.ProductID as Product_ID, 
p.ProductName as Product_Name,
sum(od.Quantity) as Quantity_Sold
FROM "Order Details" od 
Join Products p on p.ProductID = od.ProductID 
GROUP BY Product_ID 
ORDER By Quantity_Sold DESC 
Limit 10 



-- EMPLOYEE SALES AND TERRITORY ANALYSIS

WITH tt AS (
    SELECT et.EmployeeID AS Employee_ID,
        e.FirstName || ' ' || e.LastName AS Employee_Name, 
        COUNT(et.TerritoryID) AS Num_of_Territories
    FROM EmployeeTerritories et 
    JOIN Employees e ON e.EmployeeID = et.EmployeeID
    GROUP BY Employee_ID
)
SELECT tt.*, 
count(od.OrderID) as Num_of_Orders,
sum(od.Quantity) as Quantity_Sold
FROM tt
JOIN Orders o ON o.EmployeeID = tt.Employee_ID 
JOIN "Order Details" od ON od.OrderID = o.OrderID
GROUP BY tt.Employee_ID;



-- EMPLOYEE REVENUE

WITH er AS(
SELECT e.EmployeeID, e.FirstName || ' ' || e.LastName as Emplyoyee_Name, 
SUM(round(od.UnitPrice * od.Quantity * (1 - od.Discount), 2)) AS Revenue,
SUM(o.Freight) AS FreightCost,sum(od.Quantity) as Quantity_Sold
FROM Employees e 
JOIN Orders o  ON e.EmployeeID = o.EmployeeID
JOIN "Order Details" od  ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID, Emplyoyee_Name
ORDER BY Revenue DESC)
Select er.*,(er.Revenue - er.FreightCost) as Net_Sales
From er ;



-- LOW ORDERING COUNTRIES
-- TOP 5 COUNTRIES WITH LEAST ORDERED ITEMS

SELECT o.ShipCountry, SUM(od.Quantity) AS Total_Ordered_Items
FROM  Orders o
JOIN "Order Details" od  ON o.OrderID = od.OrderID
GROUP BY o.ShipCountry
ORDER BY Total_Ordered_Items ASC
LIMIT 5;



-- TOP 3 PREVALENT CATEGORIES IN THE TOP 5 COUNTRIES WITH LEAST ORDERED ITEMS

SELECT  o.ShipCountry, c.CategoryName, SUM(od.Quantity) AS TotalOrderedItems
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN "Order Details" od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
JOIN (SELECT c.CategoryName, o.ShipCountry, SUM(od.Quantity) AS TotalOrderedItems,
ROW_NUMBER() OVER (PARTITION BY o.ShipCountry ORDER BY SUM(od.Quantity) DESC) AS CategoryRank
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN "Order Details" od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.ShipCountry IN (SELECT o.ShipCountry
FROM Orders o
JOIN "Order Details" od ON o.OrderID = od.OrderID
GROUP BY o.ShipCountry
ORDER BY SUM(od.Quantity) ASC
LIMIT 5)
GROUP BY c.CategoryName, o.ShipCountry) sub ON c.CategoryName = sub.CategoryName AND o.ShipCountry = sub.ShipCountry
WHERE sub.CategoryRank <= 3
GROUP BY c.CategoryName, o.ShipCountry
ORDER BY o.ShipCountry, TotalOrderedItems DESC;



-- EFFECT OF DISCOUNTS ON PURCHASING PATTERNS OF EACH COUNTRY

SELECT o.ShipCountry as Country, 
SUM(CASE WHEN od.Discount > 0 THEN od.Quantity ELSE 0 END) AS Discount_Count, 
SUM(CASE WHEN od.Discount = 0 THEN od.Quantity ELSE 0 END) AS No_Discount_Count,
SUM(od.Quantity) as Total_Count
FROM "Order Details" od 
JOIN Orders o ON o.OrderID = od.OrderID 
GROUP BY o.ShipCountry 
ORDER BY Discount_Count DESC;



-- TOP 10 PRODUCTS FROM EACH COUNTRY IN TERMS OF TOTAL ORDERED

SELECT Country, Product, OrdNo, Discount_Count
FROM (
    SELECT Country, Product, OrdNo, 
           ROW_NUMBER() OVER (PARTITION BY Country ORDER BY OrdNo DESC) AS Ranking, 
           Discount_Count
    FROM (
        SELECT c.Country, p.ProductName AS Product, SUM(od.Quantity) As OrdNo,
               SUM(CASE WHEN od.Discount > 0 THEN 1 ELSE 0 END) as Discount_Count
        FROM Customers c 
        JOIN Orders o ON c.CustomerID = o.CustomerID
        JOIN 'Order Details' od ON o.OrderID = od.OrderID
        JOIN Products p ON od.ProductID = p.ProductID
        GROUP BY c.Country, p.ProductName
    )
)
WHERE Ranking <= 10;



-- REVENUE GENERATED FROM EACH COUNTRY

WITH cr AS(
SELECT c.Country, SUM(o.Freight) AS FreightCost,
SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Revenue
FROM Orders o 
JOIN Customers c ON o.CustomerID = c.CustomerID 
JOIN "Order Details" od ON o.OrderID = od.OrderID 
GROUP BY c.Country 
ORDER BY Revenue DESC)
Select cr.*, (cr.Revenue - cr.FreightCost) as Net_Revenue
From cr ;



-- DELAYED ORDERS PER COUNTRY

SELECT 
ShipCountry as Country, count(distinct OrderID) as Total_Orders,
SUM(CASE WHEN julianday(RequiredDate) - julianday(ShippedDate) < 0 THEN 1 ELSE 0 END) as Delayed_Orders,
SUM(CASE WHEN julianday(RequiredDate) - julianday(ShippedDate) >= 0 THEN 1 ELSE 0 END) as On_Time_Orders
FROM Orders
GROUP BY Country
ORDER BY Delayed_Orders DESC;



--PROPOSALS TO IMPROVE SALES
--1. RE-INTRODUCTION OF DISCONTINUED PRODUCTS
--ALL PRODUCTS

SELECT p.ProductName AS All_Products, sum(od.Quantity)AS Quantity_Sold
FROM Products p
JOIN "Order Details" od ON od.ProductID = p.ProductID 
GROUP BY All_Products
ORDER BY Quantity_Sold DESC

--DISCONTINUED PRODUCTS

SELECT p.ProductName AS Discontinued_Products, sum(od.Quantity)AS Quantity_Sold
FROM Products p
JOIN "Order Details" od ON od.ProductID = p.ProductID 
WHERE p.Discontinued = 1 
GROUP BY Discontinued_Products
ORDER BY Quantity_Sold DESC



-- 2. TARGETED ADVERTISMENT

SELECT c.ContactTitle  ,SUM(i.UnitPrice*i.Quantity) AS Revenue_Made
from Invoices i 
JOIN Customers c ON i.CustomerID = c.CustomerID 
GROUP BY c.ContactTitle 
ORDER BY Revenue_Made DESC ;
