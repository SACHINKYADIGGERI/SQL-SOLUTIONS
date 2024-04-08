CREATE TABLE Products(
    order_date date,
    Sales int)
	
	
INSERT INTO Products(order_date,Sales)
Values
('2021-01-01',20),('2021-01-02',32),('2021-02-08',45),('2021-02-04',31),
('2021-03-21',33),('2021-03-06',19),('2021-04-07',21),('2021-04-22',10)

SELECT * FROM PRODUCTS

Select 
   Extract('Year' from order_date) AS Years, To_char(order_date,'Mon') as Months,
   sum(sales) as TotalSales
from products
group by 1,2
order by TotalSales DESC

-- MySQL
-- SELECT 
--       YEAR(order_date) AS Years,
-- 	  MONTH(order_date) AS Months,
-- 	  SUM(sales) AS TotalSales
-- FROM Products
-- Group by Year(Order_date), Month(Order_date)
-- Order by TotalSales DESC;
      
