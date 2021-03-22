USE StoreFront;

#SQL Query to create a Stored procedure to retrieve average sales of each product in a month.
DELIMITER $$
CREATE PROCEDURE getAverageSale (IN month INT,IN year INT)

BEGIN
    SELECT oi.Product_Id,p.Product_Title,AVG(oi.Quantity) AS AVERAGE_No_of_Sales
    FROM Order_Items oi
    LEFT JOIN Product p
    ON oi.Product_Id = p.Product_Id
    INNER JOIN Orders o
    ON o.Order_Id = o.Order_Id
    WHERE Year(o.Order_Date) = year AND Month(o.Order_Date)=month
    GROUP BY p.Product_Id
    ORDER BY p.Product_Id;
END $$

CALL getAverageSale(03,2021);




#SQL query to create a stored procedure to retrieve table having order detail with status for a given period.
DELIMITER $$
CREATE PROCEDURE getOrderDetails(IN start_date DATE,IN end_date DATE)

BEGIN
    SET start_date = IF(start_date < end_date, start_date, DATE_SUB(start_date, INTERVAL DAY(start_date)-1 DAY));
    
    SELECT o.Order_Id,o.User_Id,o.Order_Date,o.Order_Amount,
        CONCAT(a.Area,',',a.City,',',a.State,',',a.Zipcode) AS Shipping_Address,o.Order_Status 
    FROM Orders o
    LEFT JOIN Order_Address oa
    ON oa.Order_Id = o.Order_Id
    INNER JOIN Addresses a
    ON oa.Address_Id = a.Address_Id
    WHERE o.Order_Date 
    BETWEEN start_date AND end_date;
END $$

CALL getOrderDetails('2021-02-19','2021-02-17');

