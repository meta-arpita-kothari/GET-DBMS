USE StoreFront;
Show Tables;

# SQL Query to create a function to calculate number of orders in a month. Month and year will be input parameter to function.
DELIMITER $$
CREATE FUNCTION getNumberOfOrdersInMonth(
    month INT,
    year INT
) 
RETURNS INT
DETERMINISTIC

BEGIN
    DECLARE numbeOfOrders INT;
    SET numbeOfOrders = (SELECT COUNT(Order_Id) FROM Orders WHERE Month(Order_Date)=month AND Year(Order_Date)=year);
    RETURN numbeOfOrders;
END $$

DELIMITER ;

SELECT getNumberOfOrdersInMonth(02,2021);


DELIMITER $$

CREATE FUNCTION getMonthOfMaximumOrders(year INT)
    RETURNS VARCHAR(10)
    DETERMINISTIC

BEGIN
    DECLARE monthOfMaximumOrders VARCHAR(10);
    SET monthOfMaximumOrders =  ( SELECT IF(NULL,"No Orders",MONTHNAME(Order_Date)) FROM Orders WHERE Year(Order_Date)=year 
                GROUP BY MONTHNAME(Order_date) DESC LIMIT 1);
                
    RETURN monthOfMaximumOrders;
END $$

SELECT getMonthOfMaximumOrders(2021);