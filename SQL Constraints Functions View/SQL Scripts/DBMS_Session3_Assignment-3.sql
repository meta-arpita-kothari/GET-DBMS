USE StoreFront;
SHOW Tables;

# SQL Query to display Shopper’s information along with number of orders he/she placed during last 30 days.
SELECT u.User_Id, u.User_Name, u.User_Mail, u.Birth_Date, u.Contact_No ,
    COUNT(o.Order_Id) AS No_Of_Orders
FROM User u 
LEFT JOIN
Orders o
ON u.User_Id = o.User_Id
WHERE (DATEDIFF(NOW(),o.Order_Date) <= 30)
GROUP BY u.User_Id;

    
#Query to display the top 10 Shoppers who generated maximum number of revenue in last 30 days.
SELECT u.User_Id, u.User_Name, u.User_Mail, SUM(o.Order_Amount) AS Total_Order_Amount
FROM User u 
LEFT JOIN
Orders o
ON u.User_Id = o.User_Id
WHERE (DATEDIFF(NOW(),o.Order_Date) <= 30)
GROUP BY u.User_Id
ORDER BY SUM(o.Order_Amount) DESC LIMIT 10;

# SQL Query to display top Products which are ordered most in last 10 days along with numbers.
SELECT oi.Product_Id, p.Product_Title, SUM(oi.Quantity) as Total_Units
FROM Orders o
INNER JOIN 
Order_Items oi
ON o.Order_Id = oi.Order_Id
LEFT JOIN 
Product p
ON oi.Product_Id = p.Product_Id
WHERE (DATEDIFF(NOW(),o.Order_Date) < 10)
GROUP BY oi.Product_Id 
ORDER BY Total_Units DESC;



#Query to display Monthly sales revenue of the StoreFront for last 6 months. 
SELECT MONTHNAME(o.Order_Date) As Month ,SUM(o.Order_Amount) as Total_Sales , o.Order_Date
FROM Orders o
LEFT JOIN Order_Items oi
ON o.Order_Id = oi.Order_id
WHERE oi.status like "%delivered%"
GROUP BY MONTHNAME(o.Order_Date)
HAVING o.Order_Date >= DATE_ADD(NOW(), INTERVAL -3 MONTH)
ORDER BY MONTH(o.Order_Date) DESC;


#Query to mark the products as Inactive which are not ordered in last 90 days
SET SQL_SAFE_UPDATES = 0;
UPDATE Product 
SET Status = "INACTIVE"
WHERE Product_Id NOT IN(
    SELECT oi.Product_Id FROM Orders o
    INNER JOIN Oirder_Items oi
    ON o.Order_Id = oi.Order_Id
    WHERE DATEDIFF(NOW(),o.Order_Date) BETWEEN 1 AND 90);
    
    
#Query for given a category search keyword, display all the Products present in this category/categories. 
#example "o"
SELECT p.Product_Id, p.Product_Title , c.Category_Name
FROM Product p , Product_Category pc, Category c
WHERE p.Product_Id = pc.Product_Id AND pc.Category_Id = c.Category_Id
    AND c.Category_Name like "%O%";

    
# Query to display top 10 Items which were cancelled most.
INSERT INTO Order_Items(Order_Id,Product_Id,Quantity,Status) values
    ('1102','2','1','cancelled'),
    ('1103','2','2','cancelled'),
    ('1104','3','1','cancelled'),
    ('1105','2','1','cancelled'),
    ('1106','4','1','cancelled'),
    ('1103','5','1','cancelled'),
    ('1102','1','1','cancelled'),
    ('1101','2','1','cancelled');
    
SELECT p.Product_Id,p.Product_Title,COUNT(oi.Product_Id) AS Status_Count_Cancelled
FROM Order_Items oi
LEFT JOIN Product p
ON oi.Product_Id = p.Product_Id
WHERE oi.status LIKE "%cancelled%" 
GROUP BY(oi.Product_Id)
ORDER BY Status_Count_Cancelled DESC LIMIT 10;
