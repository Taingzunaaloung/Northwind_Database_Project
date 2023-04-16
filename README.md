# Northwind_Database_Project

## About
This project analyses data from the Northwind Database, a free, open-source database created by Microsoft containing data from a fictional company, Northwind Traders which imports and exports food around the world. 
The project focuses on the use of SQL to query data from a database

## Aim of the Project
1. To obtain hands on experience on the use of SQL to query data from a database

## Database Schema
![Northwind Schema](Northwind_ERD.png)

## About Database
The Northwind Database is made up of eleven(11) tables containing data on all aspects of the company from customers to employees. The breakdown of the tables is as follows:

1. **_Categories_**: Contains data about the categories of products sold by Northwind Traders. Each category has a name and a description.

2. **_Customers_**: Contains data about the customers who have made purchases from the company. Each customer has a unique ID, as well as information such as company name, contact person, address, and phone number.

3. **_Employees_**: Contains data about the employees of Northwind Traders. Data on employees include a unique ID, name, title, birth date, hire date, address, phone number, and photo.

4. **_EmployeeTerritories_**: Contains employee ID and the ID of territories assigned to the employee.

5. **_Orders_**: Contains data about the orders made by customers. Each order has a unique ID, as well as information such as the customer who placed the order, the employee who processed the order, the order date, the required date, the shipped date, and the shipping address.

6. **_OrderDetails_**: Contains data of all products constituting a given order. The data include a unique order ID, IDs of product(s), quantity ordered, and the price per unit.

7. **_Products_**: Contains data on the products sold by Northwind Traders. Each product has a unique ID, as well as information such as the name, supplier, category, quantity in stock, unit price, and whether it is discontinued.

8. **_Region_**: Contains unique IDs assigned to the names of the regions in which Northwind Traders operates.

9. **_Shippers_**: Contains data about the companies that Northwind Traders uses to ship its products.The data inlcude a unique shipper ID, the company name, contact person, and phone number.

10. **_Suppliers_**: Contains data about the companies that supply Northwind Traders with its products. The data inlcude a unique supplier ID, the company name, contact person, address, phone number, and fax number.

11. **_Territories_**: Contains data about the territories in which Northwind Traders operates. Each territory has a unique ID, a name, and the ID of the region to which it belongs.


# Methodology
The project made use of DBeaver as the Database Management System and SQL was used to query the database. Visualizations were created from the queried data mainly using Microsof Excel
