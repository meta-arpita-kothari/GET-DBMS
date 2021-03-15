USE StoreFront;

LOAD DATA INFILE 'D:/GET2021/GET-DBMS/SQL Command and Joins/Data_Text_Files/Category_Data.txt' INTO TABLE Category FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 0 LINES (Category_Name,Parent_Category);

LOAD DATA INFILE 'D:/GET2021/GET-DBMS/SQL Command and Joins/Data_Text_Files/Product_Data.txt' INTO TABLE Product FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 0 LINES (Product_Title,Product_Description,Unit_Price,Stock_Quantity,Created_At);

LOAD DATA INFILE 'D:/GET2021/GET-DBMS/SQL Command and Joins/Data_Text_Files/User_Data.txt' INTO TABLE User FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 0 LINES (User_Name,User_Role,User_Mail,@date_val,Contact_no)
SET Birth_Date=str_to_date(@date_val, '%Y-%m-%d');

LOAD DATA INFILE 'D:/GET2021/GET-DBMS/SQL Command and Joins/Data_Text_Files/Address_Data.txt' INTO TABLE Address FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 0 LINES (User_Id,Area,City,Zipcode,State,Country);

LOAD DATA INFILE 'D:/GET2021/GET-DBMS/SQL Command and Joins/Data_Text_Files/Image_Data.txt' INTO TABLE Image FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 0 LINES (Image_Id,Product_Id,Image_URL);

LOAD DATA INFILE 'D:/GET2021/GET-DBMS/SQL Command and Joins/Data_Text_Files/Product_Category_Data.txt' INTO TABLE Product_Category FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 0 LINES (Product_Id,Category_Id);

LOAD DATA INFILE 'D:/GET2021/GET-DBMS/SQL Command and Joins/Data_Text_Files/Orders_Data.txt' INTO TABLE Orders FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 0 LINES (Order_Id,User_Id,Order_Date,Order_Amount,Order_Status);

LOAD DATA INFILE 'D:/GET2021/GET-DBMS/SQL Command and Joins/Data_Text_Files/Order_Items_Data.txt' INTO TABLE Order_Items FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 0 LINES (Order_Id,Product_Id,Quantity,status);

LOAD DATA INFILE 'D:/GET2021/GET-DBMS/SQL Command and Joins/Data_Text_Files/Order_Address_Data.txt' INTO TABLE Order_Address FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n' IGNORE 0 LINES (Address_Id,Order_Id,User_Id);




# Query to display Id, Title, Category Title, Price of the products which are Active and recently added products should be at top.
SELECT p.Product_Id, p.Product_Title, c.Category_Name, p.Unit_Price 
FROM Product p , Category c, Product_Category pc
WHERE p.Product_Id = pc.Product_Id and pc.Category_Id = c.Category_Id and Stock_Quantity > 0
ORDER BY Created_At DESC;
# alternate option of previous query
SELECT p.Product_Id, p.Product_Title, c.Category_Name, p.Unit_Price 
FROM Product p 
INNER JOIN Product_Category pc
ON p.Product_Id = pc.Product_Id 
INNER JOIN Category c
ON pc.Category_Id = c.Category_Id
WHERE p.Stock_Quantity > 0 
ORDER BY Created_At DESC;


# Query to get list of products having no image 
SELECT Product_Id, Product_Title FROM Product WHERE Product_Id NOT IN (SELECT Product_Id FROM Image);

# Query to get all the category list in ascending order on the basis of category names
SELECT c.Category_Name as Category_Title,
IF (c.Parent_Category = 0,'Top Category',c1.Category_Name ) as Parent_Title, c.Category_Id
FROM Category c
LEFT JOIN Category c1
ON c.Parent_Category = c1.Category_Id 
ORDER BY 
    CASE WHEN c.Parent_Category <> 0 THEN c.Category_Name END ASC,
    CASE WHEN c.Parent_Category = 0 THEN c.Category_Name END ASC;

# Query to display all the leaf categories
SELECT c.Category_Id,c.Category_Name,c1.Category_Name as Parent_Category_Name
FROM Category c
LEFT JOIN Category c1
ON c.Parent_Category = c1.Category_Id
WHERE c1.Category_Id NOT IN (c.Category_Id);

# Query to have Products from mobile category
SELECT p.Product_Title,p.Unit_Price,p.Product_Description
FROM Product p
INNER JOIN Product_Category pc
ON (p.Product_Id = pc.Product_Id AND 
    pc.Category_Id=(SELECT Category_id from Category WHERE Category_Name = "Mobile"));

# Query to get list of products whose quantity < 50 
SELECT Product_Title,Product_Description,Unit_Price,Stock_Quantity FROM Product WHERE Stock_Quantity < 50;

