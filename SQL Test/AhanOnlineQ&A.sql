--Q1: The whole sale amount of company
SELECT *
FROM SaleTable

SELECT SUM (Quantity * UnitPrice) AS total_Sale
FROM SaleTable
---------------------------------------------------

--Q2: Distinct Customers
SELECT COUNT( DISTINCT( Customer ) ) AS 'Number Of Distinct customer'
FROM SaleTable

---------------------------------------------------
--Q3: Total amount of Sale for each product

SELECT Product , SUM(Quantity) AS 'Total Sale of Product'
FROM SaleTable
GROUP BY  Product

---------------------------------------------------
--Q4: Customers who have bill more than at least 1500

SELECT Customer , SUM( Quantity * UnitPrice) as bill , COUNT (DISTINCT(OrderID)) as 'Number of bills',
COUNT(Product) as 'Number of Products'
FROM SaleTable 
GROUP BY Customer 
Having SUM( Quantity * UnitPrice)  >= 1500

--------------------------------------
with cte as
(
select Customer, OrderId, sum((Unitprice * Quantity)) as TotalPrice, count(product) as ProductN
from SaleTable
group by customer, OrderId
)
Select Customer, count(OrderId) as 'Number of a bill over 1500', sum(TotalPrice) as TotalPrice, count(ProductN) as 'Number of Product'
From cte
Where TotalPrice > 1500
group by customer;

---------------------------------------------------
--Q5: Profit

with cte as
(
SELECT  Distinct(SaleTable.Product) ,Quantity , (ProfitRatio/100) AS ProfitRatio , UnitPrice
FROM SaleTable
LEFT JOIN SaleProfit
ON  SaleTable.Product = SaleProfit.Product
)
SELECT Product, SUM(Quantity * ProfitRatio * UnitPrice) AS 'Profit Of each item',
 SUM(Quantity * UnitPrice * ProfitRatio) / SUM(quantity* UnitPrice) as TotalProfitRatio
FROM cte
GROUP BY Product

--------------------------------------------------
--Q6: 
--with cte as
--(
SELECT DISTINCT(Customer) , Date
FROM SaleTable
Group BY Customer , Date
Order by Date
--)
--SELCT COUNT(Customer)
--FROM cte

