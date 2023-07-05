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
select p.categoryID, p.ProductName, p.UnitPrice,
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

select orderid , od.UnitPrice*od.Quantity*(1-od.discount) as 'sum of order',

select year(o.OrderDate) , o.CustomerID , 
cast(sum(UnitPrice*Quantity*(1-Discount)) as money) as sumTotal
from Orders o join [Order Details] od
on o.OrderID = od.OrderID
group by year(o.OrderDate) , o.CustomerID
order by 1,3 desc