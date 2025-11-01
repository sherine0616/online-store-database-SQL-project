create database online_store;
use online_store;

create table customers(customerID int primary key auto_increment,
coustomerName varchar(100),
Email varchar(100),
City varchar(50));


create table products(productID int primary key auto_increment,
productName varchar(100),
price decimal(10,2),
stock int);


create table orders(orderID int primary key auto_increment,
customerID int,
ProductID int,
Quantity int,
OrederDate date,
foreign key(customerID)references customers(customerID),
foreign key(productID)references products(productID));

insert into customer(customerName,Email,City)
values ("sherine","sherine@gamil.com","chennai"),
       ("Anto","anto@gamil.com","bangalore"),
       ("krithika","krithika@gmail.com","hyderabad");
       
insert into products (productName,price,stock)
values("laptop",55000,10),
       ("Headphones",1500,23),
       ("Mobile",26000,15);
       
insert into orders(customerID,ProductID,Quantity,OrederDate)
values(1,1,1,"2025-10-25"),
	  (2,2,2,"2025-10-24"),
      (3,3,3,"2025-10-26");
	

;
select*from Products;
select*from Orders;

    ---- JOIN(1) ----
    
select
O.OrderID,
C.CoustomerName,
P.ProductName,
O.Quantity,
O.Orders o
from  oreders o
join customers c on o.coustomerID = c.customerID
join products p on o.productsID = p.productID

 ---- VIEW(2) ----
 
Create view orderDetails AS
select
 o.orderID
 c.coustomerName,
 p.productName,
 o.Quantity,
 (p.price * o.Quantity) AS TotalAmount,
 o.OrderDate
 From Orders o
 Join customer c ON  o.customerID =c.customerID
 Join Products p ON  o.productID  =p.productID;
 
 select * from orderDetails;
 
 ---- SUBQUERY (3) ----
 
 select coustomerName
 from coustomers
 where customerID in(
 select customerID
 from orders o
 join products p on o.productID = p.productId
 where p.price > 20000);
 
 ------ TRIGGER (4) -----
 
 create trigger reducestock
 after insert on orders
 for each row
 update products
 set stock = stock - new.quantity
 where productID = new.productID;
 
 insert into orders(customerID,productID ,Quantity,orderDate)
 values(1,2,3, curdate());
 select*from products; 
 
 ----- STORED PROCEDURE (5) -----
 
 DELIMITER //
 create procedure GetOrderCount(in custID int)
 begin
 select
      c.coustomerName,
      count(o.OrderID)as totalOrders
      from customers c
      left join orders o on c.customerName;
END//
DELIMITER ;

call GetOrderCount(1);
 
 

