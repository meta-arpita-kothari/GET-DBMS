USE StoreFront;

# SQL Query to retreive list of products which falls in more than one category
SELECT p.Product_Id, p.Product_Title , COUNT(pc.Category_Id) as Number_Of_Category
FROM Product p
Right JOIN Product_Category pc
ON p.Product_Id = pc.Product_Id
GROUP BY p.Product_Id
HAVING COUNT(pc.Category_Id) > 1;


# SQL Query to display Count of products as per range.
SELECT 
   case when Unit_Price between 500 and 1000 then '500-1000'
        when Unit_Price between 1000 and 2000 then '1000-2000'
        when Unit_Price > 2000 then 'Above 2000'
   end as Range_in_price ,
   COUNT(Product_Id) as COUNT
FROM Product
GROUP BY Range_in_price;


# SQL Query to display Number of Products in each category
SELECT c.Category_Name, COUNT(pc.Product_Id) as No_Of_Products
FROM Category c
LEFT JOIN Product_Category pc
ON pc.Category_Id = c.Category_Id
GROUP BY c.Category_Name;

    
