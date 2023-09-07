# 1 Calculate average Unit Price for each CustomerId.

select customerID,unitPrice,
avg(Unitprice) OVER (partition by CUSTOMERID)AS average_unit_price
from orders o
inner join order_details od on o.OrderID=od.OrderID ;


# 2 Calculate average Unit Price for each group of CustomerId AND EmployeeId.
with average_unit_price as
(SELECT CustomerId, EmployeeId, 
AVG(UnitPrice) OVER (PARTITION BY CustomerId, EmployeeId) AS AvgUnitPrice
FROM Orders o
INNER JOIN order_details od ON o.OrderID = od.OrderId )
select * from average_unit_price ;

# 3 Rank Unit Price in descending order for each CustomerId.


SELECT CustomerId, OrderDate, UnitPrice, 
ROW_NUMBER() OVER (PARTITION BY CustomerId ORDER BY UnitPrice DESC) AS UnitRank
FROM orders o
INNER JOIN order_details od ON  o.OrderID = od.OrderId
group by CustomerID,unitPrice
order by UnitPrice desc ;

# 4 How can you pull the previous order date’s Quantity for each ProductId.

SELECT ProductId,OrderDate, Quantity, 
LAG(Quantity) OVER (PARTITION BY ProductId ORDER BY OrderDate) AS lag_quqntity
FROM Orders o
INNER JOIN order_details od ON o.orderId= Od.OrderId ;

# 5 How can you pull the following order date’s Quantity for each ProductId.

SELECT ProductId, OrderDate, Quantity, 
LEAD(Quantity) OVER (PARTITION BY ProductId ORDER BY OrderDate) AS LEAD_no
FROM orders o
INNER JOIN order_details od ON o.orderid = Od.OrderId ;

# 6 Pull out the very first Quantity ever ordered for each ProductId.

SELECT ProductId, OrderDate, Quantity, 
FIRST_VALUE(Quantity) OVER (PARTITION BY ProductId ORDER BY OrderDate) AS FirstValue
FROM Orders o
INNER JOIN Order_Details od ON o.orderID = Od.OrderId ;

# 7 Calculate a cumulative moving average UnitPrice for each CustomerId.
With cumulative_average as
(SELECT CustomerId, UnitPrice, 
AVG(UnitPrice) OVER (PARTITION BY CustomerId 
ORDER BY CustomerId 
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumAvg
FROM Orders o
INNER JOIN Order_details od ON o.orderid = Od.OrderId)
select * from cumulative_average  ;


     
