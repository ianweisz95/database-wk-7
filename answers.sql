-- Q1. 
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50)
);
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
-- Insert orders
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Insert order products
INSERT INTO OrderProducts (OrderID, Product) VALUES
(101, 'Laptop'),
(101, 'Mouse'),
(102, 'Tablet'),
(102, 'Keyboard'),
(102, 'Mouse'),
(103, 'Phone');



-- Q2. Step 1: Create orders table (link order to customer)
CREATE TABLE orders (
    orderNumber INT PRIMARY KEY,
    customerNumber INT,
    FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);

-- Step 2: Create new normalized orderdetails table
CREATE TABLE orderdetails_2NF (
    orderNumber INT,
    productCode VARCHAR(15),
    quantityOrdered INT,
    PRIMARY KEY (orderNumber, productCode),
    FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber)
);

-- Step 3: Insert into orders (distinct OrderID, Customer)
INSERT INTO orders (orderNumber, customerNumber)
SELECT DISTINCT o.OrderID, c.customerNumber
FROM OrderDetails o
JOIN customers c ON o.CustomerName = c.customerName;

-- Step 4: Insert into orderdetails_2NF
INSERT INTO orderdetails_2NF (orderNumber, productCode, quantityOrdered)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
