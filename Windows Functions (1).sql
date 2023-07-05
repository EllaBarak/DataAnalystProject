-- ADVANCED SQL

--Windows Functions

-- AVG , SUM , Count from products

select avg(p.UnitPrice) as avg , SUM(p.UnitPrice) as sum , 
count(p.UnitPrice) as count
from Products p

-- 28.8663	2222.71	 77

select p.CategoryID, avg(p.UnitPrice) as avg , SUM(p.UnitPrice) as sum , 
count(p.UnitPrice) as count
from Products p
group by p.CategoryID


select p.CategoryID, avg(p.UnitPrice) as avg , SUM(p.UnitPrice) as sum , 
count(p.UnitPrice) as count , (select avg(UnitPrice) from Products) as avgTotal
from Products p
group by p.CategoryID


-- over()

select p.CategoryID, p.ProductName , p.UnitPrice,  
SUM(p.UnitPrice)  over() as sum , 
count(p.UnitPrice)over() as count ,
avg(p.UnitPrice) over() as avgTotal
from Products p

-- Partition by
select p.CategoryID, p.ProductName , p.UnitPrice,  
avg(p.UnitPrice) over(Partition by p.CategoryID) as avgbyCat , 
avg(p.UnitPrice) over() as avgTotal
from Products p
--where p.UnitPrice > avg(p.UnitPrice) over() 


select (UnitPrice /2222.71 * 100) from Products
where ProductID = 38


select p.CategoryID, p.ProductName , p.UnitPrice,  
sum(p.UnitPrice) over() as sumTotal ,
concat( p.UnitPrice /sum(p.UnitPrice) over() * 100 , '%') as pct
from Products p

--

select p.categoryID, p.ProductName, p.UnitPrice,
sum(p.UnitPrice) over() as sumTotal,
sum(p.UnitPrice) over(partition by p.categoryID) as sumCat, 
concat (p.UnitPrice / sum(p.UnitPrice) over() *100, '%') as pct,
concat (p.UnitPrice / sum(p.UnitPrice) over(partition by p.categoryID) *100, '%') as pctcat
from Products as p

--28.8663
select p.categoryID, p.ProductName, p.UnitPrice,sum(p.UnitPrice) over() as sumTotal,sum(p.UnitPrice) over(partition by p.categoryID) as sumCat, concat (p.UnitPrice / sum(p.UnitPrice) over() *100, '%') as pct,concat (p.UnitPrice / sum(p.UnitPrice) over(partition by p.categoryID) *100, '%') as pctcat,p.UnitPrice-avg (p.unitprice)over() as subFromAvg, p.UnitPrice-avg (p.unitprice)over(partition by p.categoryID) as subFromAvgCat
from Products as p

select p.CategoryID, p.ProductName , p.UnitPrice,  
avg(p.UnitPrice) over(Partition by p.CategoryID) as avgbyCat , 
avg(p.UnitPrice) over() as avgTotal
from Products p
where p.UnitPrice > (select avg(p.UnitPrice)over() from Products)


select * from
(select p.CategoryID, p.ProductName , p.UnitPrice,  
avg(p.UnitPrice) over(Partition by p.CategoryID) as avgbyCat , 
avg(p.UnitPrice) over() as avgTotal
from Products p) as xx
where xx.UnitPrice > xx.avgTotal


-- order by
select p.CategoryID, p.ProductName , p.UnitPrice,  
SUM(UnitPrice) over(order by p.UnitPrice) sumTotal
from Products p
where CategoryID = 1

--Rows between
select p.CategoryID, p.ProductName , p.UnitPrice,  
SUM(UnitPrice) over(order by p.UnitPrice
ROWS BETWEEN  CURRENT ROW and UNBOUNDED FOLLOWING)  sumTotal
from Products p
where CategoryID = 1


select p.CategoryID, p.ProductID , p.ProductName , p.UnitPrice,  
SUM(UnitPrice) over(order by p.UnitPrice
ROWS BETWEEN UNBOUNDED PRECEDING and  CURRENT ROW )  sumTotal,
SUM(UnitPrice) over(order by p.UnitPrice
ROWS BETWEEN 0 PRECEDING and  CURRENT ROW )  NsumTotal
from Products p
where CategoryID = 1
and p.ProductID > 3


select od.OrderID , od.UnitPrice * od.Quantity * (1-od.Discount) as sumTotal
,cast( sum(od.UnitPrice * od.Quantity * (1-od.Discount)) 
over(order by od.UnitPrice * od.Quantity * (1-od.Discount)
ROWS BETWEEN UNBOUNDED PRECEDING and  CURRENT ROW) as money)
from [Order Details] od

-- Row Number
select p.CategoryID, p.ProductID , p.ProductName , p.UnitPrice,
ROW_NUMBER()over(order by unitprice desc) as rowNum
from Products p


--

select p.CategoryID, p.ProductID , p.ProductName , p.UnitPrice,
ROW_NUMBER()over(order by unitprice ) as rowNum,
ROW_NUMBER()over(Partition by p.CategoryID order by unitprice ) as rowNum
from Products p

-- RANK
select p.CategoryID, p.ProductID , p.ProductName , p.UnitPrice,
RANK()over(order by unitprice ) as rank
from Products p
where CategoryID = 1

-- DENSE_RANK
select p.CategoryID, p.ProductID , p.ProductName , p.UnitPrice,
ROW_NUMBER()over(Partition by p.CategoryID order by unitprice ) as rowNum,
RANK()over(Partition by p.CategoryID order by unitprice ) as rank,
DENSE_RANK()over(Partition by p.CategoryID order by unitprice ) as DENSE_RANK
from Products p


-- Ntile
select p.CategoryID, p.ProductID , p.ProductName , p.UnitPrice,
NTILE(5) over(Partition by p.CategoryID  order by unitprice ) as Ntile
from Products p


-- LAG
-- LEAD

select p.CategoryID, p.ProductID , p.ProductName , p.UnitPrice,
LAG(unitprice , 1) over(order by unitprice ) as lag,
LEAD(unitprice , 1) over(order by unitprice ) as LEAD
from Products p


-- ORDER DETAILS - SUM of order 
-- (od.UnitPrice * od.Quantity * (1-od.Discount))
-- Rank
-- order by sum of order 

select orderid , od.UnitPrice*od.Quantity*(1-od.discount) as 'sum of order',rank() over (order by od.UnitPrice*od.Quantity*(1-od.discount) ) as rankfrom [Order Details] as odselect distinct * from(select orderid, UnitPrice*Quantity*(1-Discount) as PricePaid,rank()over(partition by (orderid) order by UnitPrice*Quantity*(1-Discount) desc) as "OrderSumRank"from "order details") as swhere s.OrderSumRank = 1--select * from Orderswhere CustomerID =  'CENTC'order by OrderDate desc--order id , customer id , last order dat , pervios order dateselect * from (select o.OrderID ,o.CustomerID , o.OrderDate, RANK()over(partition by o.CustomerID order by o.orderdate desc) as rank,lead(o.Orderdate,1) over(partition by o.CustomerID order by Orderdate desc) as lastOrderDatefrom Orders as o) as oowhere   rank =1 and CustomerID =  'ALFKI'-- 1998-04-09 00:00:00.000 -- 1998-03-16 00:00:00.000select  * from (select o.orderid, o.CustomerID, o.Orderdate,rank()over(partition by (o.Customerid) order by o.orderdate desc) as LastOrderdates,lag(Orderdate,1) over(partition by o.CustomerID order by Orderdate  ) as BeforeLastOrderfrom orders as o) as xwhere x.LastOrderDates = 1and customerID = 'ALFKI'-- select distinct * from(select orderid, UnitPrice*Quantity*(1-Discount) as PricePaid,rank()over(partition by (orderid) order by UnitPrice*Quantity*(1-Discount) desc) as "OrderSumRank"from "order details") as swhere OrderID = 10248select * from (select orderid, UnitPrice*Quantity*(1-Discount) as PricePaid,rank()over(partition by (orderid) order by UnitPrice*Quantity*(1-Discount)desc) as "OrderSumRank",lead(UnitPrice*Quantity*(1-Discount),1) over(partition by (orderid) order by UnitPrice*Quantity*(1-Discount)desc) as "second highest"from "order details") as S where s.ordersumrank=1and OrderID = 10248--- get top 5 customers that did the highiest number of orders-- on each yearselect * from (select year(o.OrderDate) as year, o.CustomerID , count(*) as count, DENSE_RANK() over(partition by year(o.OrderDate) order by count(*) desc) as rnkfrom Orders ogroup by year(o.OrderDate) , o.CustomerID) as swhere s.rnk <=5select * from(select year(o.OrderDate) as year, o.CustomerID , count(*) as count, Row_number() over(partition by year(o.OrderDate) order by count(*) desc) as RowNfrom Orders ogroup by year(o.OrderDate) , o.CustomerID) as xwhere x.RowN <= 5

select year(o.OrderDate) , o.CustomerID , 
cast(sum(UnitPrice*Quantity*(1-Discount)) as money) as sumTotal
from Orders o join [Order Details] od
on o.OrderID = od.OrderID
group by year(o.OrderDate) , o.CustomerID
order by 1,3 descselect * from(select year(o.OrderDate), o.CustomerID,sum(od.UnitPrice * od.Quantity * (1-od.Discount)) as sumtotal,rank () over (partition by YEAR(o.OrderDate) order by sum(od.UnitPrice * od.Quantity * (1-od.Discount))desc) as rankfrom [Order Details] as od join Orders as oon o.OrderID=od.OrderIDgroup by  year(o.OrderDate), o.CustomerIDorder by 1,3 desc) as oowhere oo.rank = 1-- 1996	ERNSH	15568.0648-- 1997	QUICK	61109.91-- 1998	ERNSH	41210.65select * from(select year(o.OrderDate) as year, o.CustomerID ,sum(od.UnitPrice * od.Quantity * (1-od.Discount)) as sumtotal,rank () over (partition by YEAR(o.OrderDate) order by sum(od.UnitPrice * od.Quantity * (1-od.Discount))desc) as rankfrom [Order Details] as od join Orders as oon o.OrderID=od.OrderIDgroup by  year(o.OrderDate), o.CustomerID) as oowhere oo.rank = 1select * from (select o.CustomerID,    YEAR(o.OrderDate) as Year,    format(CAST(sum(od.UnitPrice*od.Quantity*(1-od.Discount))as money) , '#,#.00')  as SumTotal,ROW_NUMBER() OVER(partition by YEAR(o.orderdate) order by CAST(sum(od.UnitPrice*od.Quantity*(1-od.Discount))as money) DESC) as RowNumfrom Orders as oJOIN [Order Details] as odon o.OrderID = od.OrderIDGROUP BY o.CustomerID, YEAR(o.OrderDate)) as Xwhere x.RowNum = 1select format(15568.0648 , '#,#.00') as f-- Divid the emploies to 3 groups-- get all emploies in group 2-- employee id, title + last name + first nameselect * from Employeesorder by LastNameselect * from (select e.EmployeeID , CONCAT(e.TitleOfCourtesy , ' ' , e.LastName , ' ' , e.FirstName) as name, NTILE(3)over(order by e.EmployeeID) as groupsfrom Employees as e ) as xwhere x.groups = 2select e.EmployeeID, CONCAT (e.Title, e.FirstName,e.LastName),NTILE (3) OVER ( ORDER BY e.EmployeeID) AS NTILEfrom Employees eselect * from (select e.EmployeeID, CONCAT (e.Title, e.FirstName,e.LastName) as name,	NTILE (3) OVER ( ORDER BY e.EmployeeID) AS NTILE	from Employees e) as xwhere x.NTILE =2-- -- get  sum of orders for year  QQ, privios QQ , Next QQselect year(o.OrderDate) as year , DATEPART(QQ , o.OrderDate) as CurrentQ , sum(od.UnitPrice*od.Quantity*(1-od.Discount)) as sumTotal, lead(sum(od.UnitPrice*od.Quantity*(1-od.Discount)) , 1) over(partition by year(o.OrderDate) order by DATEPART(QQ , o.OrderDate)) lead,lag(sum(od.UnitPrice*od.Quantity*(1-od.Discount)) , 1) over(partition by year(o.OrderDate) order by DATEPART(QQ , o.OrderDate)) lagfrom Orders o join [Order Details] odon o.OrderID = od.OrderIDgroup by year(o.OrderDate) , DATEPART(QQ , o.OrderDate)