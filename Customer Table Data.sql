create table Customer
(	id int Primary Key identity (1,1),
	FirstName varchar(50),
	LastName varchar(50),
	Age int,
	City varchar(50)
)

select *
from Customer;

insert into Customer
(FirstName,LastName,Age,City)
values ('Joey','Blue',40,'Goddard');
insert into Customer
(FirstName,LastName,Age,City)
values ('Barry','Bonds',50,'San Francisco');
insert into Customer
(FirstName,LastName,Age,City)
values ('Mike','Schmidt',60,'KC');


create table Products
(	id int Primary Key identity (1,1),
	ProductName varchar(50)
)

alter table Products
add Price float;

Select * from Products

insert into Products (ProductName,Price) values ('Baseball',5.95);
insert into Products (ProductName,Price) values ('Bat',195.99);

create table Orders
(	OrderId int Primary key identity(1,1),
	OrderDate Datetime,
	CustomerID int,
	ProductID int
)

select * from Orders;
select * from Products;
select * from Customer;

insert into Orders(OrderDate,CustomerID,ProductID)
values (GETDATE(),2,2);
insert into Orders(OrderDate,CustomerID,ProductID)
values (GETDATE(),2,1);
insert into Orders(OrderDate,CustomerID,ProductID)
values (GETDATE(),1,1);
insert into Orders(OrderDate,CustomerID,ProductID)
values (GETDATE(),3,1);
insert into Orders(OrderDate,CustomerID,ProductID)
values (GETDATE(),3,2);
insert into Orders(OrderDate,CustomerID,ProductID)
values (GETDATE(),1,2);

alter table Orders
add foreign key (CustomerId) references Customer(Id);

alter table Orders
add foreign key (ProductId) references Products(Id);


select * from Orders
inner join Products on Orders.ProductID=Products.id

select * from Orders as o
inner join Products as p on o.ProductID=p.id

select * from Orders o
inner join Products p on o.ProductID=p.id

select o.*,p.*,c.* from Orders o
inner join Products p on o.ProductID=p.id
inner join Customer c on o.CustomerID=c.id

select o.OrderDate,p.ProductName,p.Price,c.* from Orders o
inner join Products p on o.ProductID=p.id
inner join Customer c on o.CustomerID=c.id

update Customer
Set City='Washington DC'
where FirstName='Barry'and LastName='Bonds'

select sum (p.Price)
from Orders o
inner join Products p on o.ProductID=p.id
inner join Customer c on o.CustomerID=c.id

select sum (p.Price) as Total
from Orders o
inner join Products p on o.ProductID=p.id
inner join Customer c on o.CustomerID=c.id

select c.LastName, sum (p.Price) Total
from Orders o
inner join Products p on o.ProductID=p.id
inner join Customer c on o.CustomerID=c.id
group by c.LastName

select c.LastName, p.ProductName, sum (p.Price) Total
from Orders o
inner join Products p on o.ProductID=p.id
inner join Customer c on o.CustomerID=c.id
group by c.LastName, p.ProductName

select c.LastName, p.ProductName, sum (p.Price) Total
from Orders o
inner join Products p on o.ProductID=p.id
inner join Customer c on o.CustomerID=c.id
group by p.ProductName, c.LastName

select c.City, sum(p.Price),AVG(p.price) Total
from Orders o
inner join Products p on o.ProductID=p.id
inner join Customer c on o.CustomerID=c.id
group by c.City

select c.City, sum(p.Price) Total,AVG(p.price) Average
from Orders o
inner join Products p on o.ProductID=p.id
inner join Customer c on o.CustomerID=c.id
group by c.City