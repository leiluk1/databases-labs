create table Item (
    itemID INTEGER primary key,
    itemName VARCHAR(15),
    price REAL
);

create table Customer (
    customerID INTEGER primary key,
    customerName VARCHAR(15),
    city VARCHAR(15)
);

create table "Order" (
   orderID INTEGER primary key,
   customerID INTEGER REFERENCES Customer(customerID),
   date DATE
);

create table OrderInfo (
    orderID INTEGER REFERENCES "Order"(orderID),
  	itemID INTEGER REFERENCES Item(itemID),
    quantity INTEGER,
  	PRIMARY KEY (orderID, itemID)
);

insert into Item (itemID, itemName, price) values 
	(3786, 'Net', 35.00),
    (4011, 'Racket', 65.00),
    (9132, 'Pack-3', 4.75),
    (5794, 'Pack-6', 5.00),
    (3141, 'Cover', 10.00);
    
insert into Customer (customerID, customerName, city) values
    (101, 'Martin', 'Prague'),
    (107, 'Herman', 'Madrid'),
    (110, 'Pedro', 'Moscow');
    
insert into "Order" (orderID, customerID, date) values 
    (2301, 101, '2011-02-23'),
    (2302, 107, '2011-02-25'),
    (2303, 110, '2011-02-27');
    
insert into OrderInfo (orderID, itemID, quantity) values
    (2301, 3786, 3),
    (2301, 4011, 6),
    (2301, 9132, 8),
    (2302, 5794, 4),
    (2303, 4011, 2),
    (2303, 3141, 2);


SELECT MIN(totalAmount) AS cheapestOrder
FROM (
  SELECT O.OrderID, SUM(It.price * O.quantity) AS totalAmount
  FROM OrderInfo as O
  JOIN Item AS It ON O.itemID = It.itemID
  GROUP BY O.orderID
);


SELECT C.customerName, C.city
FROM Customer as C
JOIN "Order" as O ON C.customerID = O.customerID
JOIN OrderInfo as Oi ON Oi.orderID = O.orderID
GROUP BY C.customerID, C.city
HAVING SUM(Oi.quantity) >= (
  SELECT MAX(total)
  FROM (
    SELECT SUM(quantity) AS total
    FROM OrderInfo as Oi
    GROUP BY customerID
  ) 
);