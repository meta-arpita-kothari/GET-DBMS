/*
*  SQL file containing script for creating database and tables
*/
DROP DATABASE StoreFront;
CREATE DATABASE StoreFront;
USE StoreFront;
SET time_zone='+05:30';

CREATE TABLE Category(
    Category_Id INT NOT NULL AUTO_INCREMENT,
    Category_Name VARCHAR(20),
    Parent_Category INT,
    PRIMARY KEY(Category_Id)
);

CREATE TABLE Product(
    Product_Id INT NOT NULL AUTO_INCREMENT,
    Product_Title VARCHAR(30),
    Product_Description VARCHAR(200),
    Unit_Price INT,
    Stock_Quantity INT,
    Created_At DATETIME,
    PRIMARY KEY(Product_Id)
);

CREATE TABLE Product_Category (
    Id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Product_Id INT NOT NULL,
    Category_Id INT NOT NULL,
    FOREIGN KEY(Product_Id) REFERENCES Product(Product_Id),
    FOREIGN KEY(Category_Id) REFERENCES Category(Category_Id)
);

CREATE TABLE Image(
    Image_Id INT NOT NULL,
    Product_Id INT,
    Image_URL VARCHAR(30),
    PRIMARY KEY(Image_Id),
    FOREIGN KEY(Product_Id) REFERENCES Product(Product_Id)
); 

CREATE TABLE User(
    User_Id INT NOT NULL AUTO_INCREMENT,
    User_Name VARCHAR(30),
    User_Role VARCHAR(30),
    User_Mail VARCHAR(50) NOT NULL,
    Birth_Date DATE,
    Contact_No NUMERIC(10),
    PRIMARY KEY(User_Id)
);

CREATE TABLE Address(
    Address_Id INT NOT NULL AUTO_INCREMENT,
    User_Id INT,
    Area VARCHAR(200),
    City VARCHAR(30),
    Zipcode INT,
    State VARCHAR(30),
    Country VARCHAR(30),
    FOREIGN KEY(User_Id) REFERENCES User(User_Id),
    PRIMARY KEY(Address_Id)
);


CREATE TABLE Orders(
    Order_Id INT NOT NULL,
    User_Id int,
    Order_Date TIMESTAMP,
    Order_Amount INT,
    Order_Status varchar(12),
    PRIMARY KEY(Order_Id),
    FOREIGN KEY(User_Id) REFERENCES User(User_Id)
);



CREATE TABLE Order_Items (
    Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Order_Id INT,
    Product_Id INT,
    Quantity INT,
    status VARCHAR(12),
    CHECK(status = "placed" OR status = "returned" OR status = "exchanged" OR status = "shipped" OR status = "delivered" OR status = "cancelled")
);

CREATE TABLE Order_Address (
    Id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Address_Id INT NOT NULL,
    Order_Id INT NOT NULL,
    User_Id INT NOT NULL,
    FOREIGN KEY(Address_Id) REFERENCES Address(Address_Id),
    FOREIGN KEY(Order_Id) REFERENCES Orders(Order_Id),
    FOREIGN KEY(User_Id) REFERENCES User(User_Id)
);


DROP TABLE Image;
DROP TABLE Product_Category;
DROP TABLE Product;

CREATE TABLE Product(
    Product_Id INT NOT NULL AUTO_INCREMENT,
    Product_Title VARCHAR(30),
    Product_Description VARCHAR(200),
    Unit_Price INT,
    Stock_Quantity INT,
    PRIMARY KEY(Product_Id)
);

CREATE TABLE Product_Category (
    Id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Product_Id INT NOT NULL,
    Category_Id INT NOT NULL,
    FOREIGN KEY(Product_Id) REFERENCES Product(Product_Id),
    FOREIGN KEY(Category_Id) REFERENCES Category(Category_Id)
);

CREATE TABLE Image(
    Image_Id INT NOT NULL,
    Product_Id INT,
    Image_URL VARCHAR(30),
    PRIMARY KEY(Image_Id),
    FOREIGN KEY(Product_Id) REFERENCES Product(Product_Id)
); 
