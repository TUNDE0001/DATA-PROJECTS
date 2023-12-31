create database project;
CREATE TABLE Customers(
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Password VARCHAR(100),
    Address VARCHAR(255),
    Phone VARCHAR(20)
);
select * from customers
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(50)
);
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10, 2),
    StockQuantity INT,
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID)
);
select * from products
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate DATETIME,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT,
    Subtotal DECIMAL(10, 2), 
    VAT AS 0.02 * Subtotal, 
    Discount DECIMAL(10, 2),
    TotalAmount AS (Subtotal + (0.02 * Subtotal)) - ISNULL(Discount, 0)
);

insert into customers(firstName, lastname, email, password, address, phone)
values
        ('john', 'Doe', 'john.doe@mail.com', 'password123', '123 main st', '555-1234'),
        ('jane', 'smith', 'jane.smith@email.com', 'password456', '456 oak st', '555-5678'),
		('Alice', 'johnson', 'alicelohnson@gmail.com', 'password789', '789 pine st', '555-9101'),
		       ('jenny', 'Dray', 'jenny.dray@mail.com', 'password113', '193 main st', '555-1134'),
        ('jude', 'swiss', 'jude.swiss@email.com', 'password256', '256 oak st', '555-5778'),
		('Ali', 'john', 'alijohn@gmail.com', 'password189', '189 pine st', '555-9301'),
		       ('wohn', 'soe', 'wohn.soe@mail.com', 'password523', '153 main st', '555-1534'),
        ('lanny', 'buz', 'lanny.buz@email.com', 'password656', '656 oak st', '555-6678'),
		('lice', 'son', 'lice.son@gmail.com', 'password989', '989 pine st', '555-9901'),
		('tuns', 'son', 'tuns.son@gmail.com', 'password389', '389 pine st', '555-3901');



insert into categories (categoryName)
values
('eletronics'),
('clothing'),
('Home and Garden'),
('books');
select * from categories

Insert into products (name, description, price, stockQuantity, categoryID)
VALUES
('smartphone', 'high-end smartphone with advanced features', 699.99, 100, 1),
('laptop', 'powerful laptop for productivity and gaming', 1299.99, 50, 1),
('T-shirt', 'comfortable cotton t-shirt', 19.99, 200, 2),
('normalphone', 'normal-end smartphone with advanced features', 559.99, 120, 3),
('laptop', 'good laptop for productivity and betting', 1449.99, 40, 1),
('T-cloth', 'comfortable cotton t-shirt', 19.39, 230, 3),
('goodphone', 'high-end smartphone with advanced features', 79.99, 700, 1),
('mobile', 'powerful mobile for productivity and chatting', 8899.99, 80, 2),
('G-shirt', 'Affordable cotton t-shirt', 33.99, 300, 3),
('j-shirt', 'exellent cotton t-shirt', 61.99, 600, 1);
select * from products


Insert into orders (customerID, orderdate, productID, Quantity, subtotal)
values
      (1, getdate(), 1, 2, 1399.98),
	  (2, getdate(), 3, 5, 99.95),
	  (3, getdate(), 2, 1, 1299.99),
	  (4, getdate(), 1, 4, 1499.98),
	  (5, getdate(), 1, 5, 99.55),
	  (6, getdate(), 9, 1, 1699.99);

	  WITH DiscountCTE AS (
    SELECT 
        OrderID,
        CASE 
            WHEN Subtotal > 20000 THEN Subtotal * 0.1
            ELSE Subtotal * 0.05
        END AS Discount
    FROM Orders
) 

UPDATE o
SET o.Discount = d.Discount
FROM Orders o
JOIN DiscountCTE d ON o.OrderID = d.OrderID;


select * from orders
select * from customers
select * from categories
select * from products

QUESTIONS
select top 3 firstName, lastName, phone, sum(totalAmount) as totalspent
from customers c
join order o on c. customerID = o.customerID
GROUP BY c. customerID, firstName, lastName, phone
ORDER BY totalSpent DESC;

1.
select top 3 firstName, lastName, phone, sum(totalAmount) as totalspent
from customers c 
join order o on c. customerID  = o. customer ID
group by c. customerID, firstName, lastName, phone
orderby totalspent DESC;
2.
select COUNT(DISTINCT c. customerID) AS numberOfCustomers, SUM( o. TotalAmount) AS TotalRevenue
FROM customers c JOIN Orders o ON c. customerID = o. customerID
WHERE o.OrderDate >= DATEDIFF(MONTH, 1, GETDATE( ));
3.
SELECT TOP 1 c. categoryName, SUM(o. Quantity) AS Totalsalesvolume
FROM Categories c JOIN products p ON c. categoryID = p.CategoryID
JOIN Orders o ON p. ProductID = o. ProductID 
GROUP BY c. categoryName
ORDER BY Totalsalesvolume DESC;
4.
SELECT tc. categoryName, p.productID, P.Name, p. Description, SUM( o. Quantity) AS Totalsales
FROM categories tc JOIN products p ON tc. categoryID = P. categoryID
JOIN orders o ON P.productID = o.productID
GROUP BY tc.categoryName, p. productID, P.Name, p.Description 
ORDER BY TotalSales DESC;
ALTER TABLE Products
ALTER COLUMN Description VARCHAR(MAX);
5.
select sum(TotalAmount) AS TotalRevenue from orders 
where orderDate >= DATEDIFF(QUARTER, 1, GETDATE());
6.
SELECT c.categoryName, AVG(o. TotalAmount) AS AverageOrderValue
FROM orders o JOIN Products p ON o.productID = p. productID JOIN categories c
ON p. categoryID = c. categoryID
GROUP BY
c.categoryName;
7.
select sum(DISCOUNT) DISCOUNT FROM orders where DISCOUNT IS NOT NULL;
8.
SELECT SUM(TotalAmount) - SUM(DISCOUNT) FROM Orders;
9
SELECT
SUM(DISCOUNT) AS TotalDiscountCost,
SUM(TotalAmount) - SUM(DISCOUNT) AS overrallprofitability,
(SUM(TotalAmount) - SUM(DISCOUNT)) / NULLIF(sum(discount), 0) AS profitabilityToDiscountRatio
from orders;







