USE StoreFront;
SHOW Tables;

# SQL Query to consider a form where providing a Zip Code populates associated City and State. 
CREATE TABLE Cities_States (
    ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    City varchar(55),
    State varchar(55)
);
CREATE TABLE ZipCodes (
    ZipCode int NOT NULL PRIMARY KEY,
    Area varchar(100),
    City_Code int,
    FOREIGN KEY (City_Code) REFERENCES Cities_States(ID)
);

INSERT INTO Cities_States (City,State) VALUES
    ('Ajmer','Rajasthan'),
    ('Bhilwara','Rajasthan'),
    ('jaipur','Rajasthan'),
    ('Kota','Rajasthan'),
    ('Udaipur','Rajasthan'),
    ('Bhopal','M.P.'),
    ('Indore','M.P.'),
    ('Varanasi','U.P.'),
    ('Mumbai','Maharashtra');

INSERT INTO ZipCodes values
    ('324001','Mahaveer Nagar','4'),
    ('324002','DADABARI','4'),
    ('311001','R.K. Colony','2'),
    ('311002','Sindhu Nagar','2'),
    ('302011','Pratap Nagar','3'),
    ('302022','Sitapura','3'),
    ('324009','Mahaveer Nagar','4'),
    ('394004','Thane','9'),
    ('324008','Teachers colony','7');
    
#SQL query for that returns a Resultset containing Zip Code, City Names and States 
#ordered by State Name and City Name.

SELECT z.ZipCode,c.City,c.State
FROM ZipCodes z
LEFT JOIN
Cities_States c
ON z.City_Code = c.Id
ORDER BY c.State, c.City;