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


## Results

### Sales Revenue
<div style="display:flex; justify-content:space-between;">
    <img src=https://user-images.githubusercontent.com/119953557/232344862-f48f0ba4-83ce-4294-bef1-64f9b783adde.png width="500" height="300"/>
    <img src=https://user-images.githubusercontent.com/119953557/232344895-89c7cde4-90a8-407c-a8cb-3623a4ce3d08.png width="500" height="300"/>
</div>

The yearly revenue chart on its own shows an increase in revenue in 2017 as compared to 2016 and a dip in revenue compared to 2018. The revenue comparison chart provides more context in that, the company operated from July which is the onset to December of 2016(6 months), all of 2017(12 months) and January to May(5 months). The chart therefore indicates a gradual increase in revenue for the same time period in the  subsequent year. Revenue for the second half of 2017 saw an increase as compared to the same period in 2016. the same trend is observed for the first 5 months of 2017 compared to 2018. Although the time period of Jan-Dec is 5 months, there is still an increase in sales as compared to the previous 6 months, clearly indicating growth in revenue.
An exact profit or loss statement cannot be made since there is no data for other expenditure such as employee compensation, tax obligation and costs associated with storage

### Top 10 Selling Products by Number
![Top 10](https://user-images.githubusercontent.com/119953557/232346381-d5d548a7-c869-48c3-a2dd-31b920739890.png)

###Employee Sales and Territory Analysis
<div style="display:flex; justify-content:space-between;">
<img src=https://user-images.githubusercontent.com/119953557/232346588-cded1aad-7167-4d32-a517-8dec3de4b489.png width="500" height="300"/>
<img src=https://user-images.githubusercontent.com/119953557/232346581-232f0f82-776d-4cdc-8b8e-4af01e323ba8.png width="500" height="300"/>
</div>
In terms of sales, the first chart suggests that there is no link between the number of sales and the number of territories assigned to an employee. This is seen in Margaret, Janet and Nancy, despite having the lowest number of territories assigned to them have the highest number of sales while Robert, Steven and Anne, with more territories assigned have some of the lowest sales in terms of product number. One hypothesis is that, employees with higher sales numbers are have, territories with much higher populations and as such are given a small number of territories to enable them handle the demands of the higher population while those with lower sales have numerous territories with small populations. Since the database has no data on the populations of the territories, this hypothesis could not be tested

The second chart suggests a direct correlation between the number of orders and the number of products sales, with increasing orders resulting in increasing product sales

### Employee Revenue
![Employee Revenue](https://user-images.githubusercontent.com/119953557/232353697-b90e015c-351a-4979-ba85-7d8c97d69b64.png)
This chart shows that, for the most part, the higher the number of products sold, the higher the revenue generated with the exception of Anne Dodworth who had a higher revenue than Michael and Steven despite having lower product sales

### Low Ordering Countries
<div style="display:flex; justify-content:space-between;">
    <img src=https://user-images.githubusercontent.com/119953557/232347971-42dd6cea-9431-4035-9cfd-50d4f220211b.png width="500" height="300"/>
    <img src=https://user-images.githubusercontent.com/119953557/232347969-f3a3d17e-405c-415a-8a0f-3dd9e9a7aa8c.png width="500" height="300"/>
</div>


### Effect of Discounts on Purchasing Patterns of each Country
![Effect of Discounts](https://user-images.githubusercontent.com/119953557/232348524-d0514512-4b31-4e10-acc6-359e026e6586.png)
With the exception of Ireland, Canada, Italy and Portugal, non discount purchases for the most part are slightly higher than discount purchases. Poland, Norway and Argentina, 3 of the 5 countries with the least ordered items have no discount purchases probably due to no discount campaigns, an opportunity which can be utilized to achieve about 20-50% increase in sales. To arrive at a much better conclusion on the effect of discounts, data on the duration of the discount period is needed, which unfortunately is lacking 


### Revenue Generated from Each Country
![Revenue Generated from Each Country](https://user-images.githubusercontent.com/119953557/232352617-61507898-4695-4d28-97fc-e7764131bd4c.png)
This chart also follows the thought that, with higher product sales comes higher revenue generation 


### Delayed Orders per Country
![Delayed Orders per Country](https://user-images.githubusercontent.com/119953557/232348585-f0071632-b5d0-4588-aa47-3725e8c5e06c.png)
Relative to number of orders, Mexico, Italy, Finland, Poland and Norway have high incidence of delayed orders. Poland and Norway have the worst record of 85% and 100% delays respectively, although this can be attributed to their significantly small number of orders of 7 and 6, which also makes them the countries with the least  amount of orders
   
 
### Proposals to Improve Sales

#### 1. Re-Introduction of Discontinued Products
![Discontinued](https://user-images.githubusercontent.com/119953557/232359374-e46defee-3c33-4daf-9c26-914940666987.png)
The company since inception has sold a total of 77 products, out of which 8 have been discontinued.
6 out of the 8 products have pretty decent demand based on the total quantity sold, with the 6th product occupying the 40th position out of 77 products.
It is recommended that, the top six discontinued products with high sales record be reintroduced into the market to improve sales for the company


#### 2. Targeted Advertisement
![Revenue Generated from Specific Contact Titles](https://user-images.githubusercontent.com/119953557/232360305-38f7b6a7-0828-4064-8bc4-bc9b0d6647a8.png)
Analyzing the revenue made, it can be realized that revenue made is higher when our contact person in a buyer company holds a specific title or position, while other positions produce lower revenue for the company.
It is recommended that the company’s marketing and advertisement campaigns be primarily directed towards individuals who hold positions corresponding to high revenue as per the data

