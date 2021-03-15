USE StoreFront;

# Query to get last 5 recent orders
SELECT o.ORDER_ID,u.User_Name as Placed_By,o.ORDER_DATE,o.ORDER_AMOUNT,o.Order_Status
FROM Orders o 
INNER JOIN User u ON o.User_Id = u.User_Id
ORDER BY ORDER_DATE DESC LIMIT 5;

# Query to get 5 Most expensive orders
SELECT o.ORDER_ID,u.User_Name as Placed_By,o.ORDER_DATE,o.ORDER_AMOUNT,o.Order_Status
FROM Orders o 
INNER JOIN User u ON o.User_Id = u.User_Id
ORDER BY ORDER_Amount DESC LIMIT 5;

# Query to get list of order which is placed 10 days before and one or more items 
#from those orders are still not shipped.
SELECT o.Order_Id,o.Order_Date,o.Order_Amount
FROM Orders o
INNER JOIN Order_Items oi
ON o.Order_Id = oi.Order_Id
WHERE oi.status LIKE "%placed%" AND DATEDIFF(NOW(),o.Order_Date) > 10;


# SQL Query to get list of shoppers who have not shopped from last 30 days
SELECT u.User_Name as Shopper,
IF(NULL,'NOT ORDERED YET',o.ORDER_DATE) as Last_Ordered
FROM Orders o 
RIGHT JOIN User u ON o.User_Id = u.User_Id
WHERE DATEDIFF(NOW(),o.Order_Date) > 30 and u.User_Role = "Shop";

# SQL Query to find list of shopper and their order from last 15 day
SELECT u.User_Name as Shopper,o.Order_Id as Orders, p.Product_Title as Product ,o.ORDER_DATE as Order_Date
FROM Orders o 
INNER JOIN User u ON o.User_Id = u.User_Id 
INNER JOIN Order_Items oi ON oi.Order_Id = o.Order_Id
INNER JOIN Product p ON p.Product_Id - oi.Product_Id
#WHERE o.Order_Date between CURRENT_DATE - INTERVAL '15' DAY AND CURRENT_DATE
WHERE DATEDIFF(NOW(),o.Order_Date) <=15
ORDER BY o.ORDER_DATE DESC ;

# SQL Query to get products under shipped state in particular order
SELECT p.Product_Title,p.Product_Id,oi.Order_Id,oi.Status 
FROM Product p
RIGHT JOIN Order_Items oi ON p.Product_Id=oi.Product_Id
WHERE oi.Status LIKE "%shipped%" AND oi.Order_Id=1103;

# SQL Query to get order items whose price is in between 500 to 1000 
SELECT p.Product_Id, p.Product_Title,p.Unit_Price,o.Order_Id,o.Order_Date 
FROM Product p
INNER JOIN Order_Items po
ON p.Product_Id = po.Product_Id
INNER JOIN Orders o
ON po.Order_Id = o.Order_Id
WHERE p.Unit_Price BETWEEN 500 AND 1000;
