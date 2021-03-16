USE StoreFront;
SHOW Tables;

#Create a view displaying the order information 
#(Id, Title, Price, Shopper’s name, Email, Orderdate, Status) 
#with latest ordered items should be displayed first for last 60 days.

CREATE VIEW Orders_Information
    AS
    SELECT oi.Order_Id, p.Product_Title, p.Unit_Price, u.User_Name, u.User_Mail, o.Order_Date, oi.Status
    FROM Orders o
    LEFT JOIN
    Order_Items oi
    ON o.Order_Id = oi.Order_Id
    INNER JOIN
    Product p
    ON oi.Product_Id = p.Product_Id
    LEFT JOIN 
    User u
    ON o.User_Id = u.User_Id
    WHERE DATEDIFF(NOW(),o.Order_Date) <= 60
    ORDER BY o.ORDER_DATE DESC;
    
SELECT * FROM Orders_Information;

# SQL Query to use the above view to display the Products(Items) which are in ‘shipped’ state.
SELECT * FROM Orders_Information
WHERE Status LIKE "%shipped%";

# SQL Query to use the above view to display the top 5 most selling products.
SELECT Product_Title, COUNT(Product_Title) AS Number_Of_Product_Sold
FROM Orders_Information
GROUP BY Product_Title 
ORDER BY Number_Of_Product_Sold DESC LIMIT 5;


