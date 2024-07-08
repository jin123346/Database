#날짜 : 2024/07/08
#이름 : 하진희
#내용 : sql 연습문제1 실습하기 

#실습 1-1
create database `Shop`;
create user 'shop'@'%' identified by '1234';
grant all privileges on `Shop`.* to 'shop'@'%';
flush privileges;

#실습 1-2

use mysql;

use Shop;

create table Customer(
	`custId` varchar(10) primary key,
    `name` varchar(10) not null,
    `hp` char(10)  unique default null,
    `addr` varchar(100) default null,
    rdate date not null);
alter table `Customer` modify column  `hp` char(13) ;


show columns from Customer;

create table `Product` (
	`prodNo` int primary key,
    `prodName` varchar(10) not null,
    `stock` int  not null default 0,
    `price` int default null,
    `company` varchar(20)
);

create table `Order`(
	`orderNo` int primary key auto_increment,
    `orderId` varchar(10) not null,
    `orderProduct` int not null,
    `orderCount` int not null default 1,
    `orderDate` datetime not null
);




#실습 1-3
insert into `Customer` values
	('C101','김유신','010-1234-1001','김해 봉황동',20220101),
    ('C102','김춘추','010-1234-1002','경주 보문동',20220102),
	('C103','장보고','010-1234-1003','완도군 정산면',20220103),
	('C104','강감찬','010-1234-1004','서울시 마포구',20220104),
	('C106','정철','010-1234-1006','김경기도 용인시',20220106),
	('C108','이순신','010-1234-1008','서울시 영등포구',20220108),
	('C109','송상현','010-1234-1009','부산시 동래구',20220109),
    ('C110','정약용','010-1234-1010','경기도 광주시',20220110);
    
    insert into `Customer` (custId,name,rdate) values ('c105', '이성계',20220105), ('c107','허준',20220107);
    
    select * from customer;
    drop table product;
    
    insert into `product` values 
			(1,'새우깡',5000,1500,'농심'),
            (2,'초코파이',2500,2500,'오리온'),
            (3,'포카칩',3600,1700,'오리온'),
            (4,'양파링',1250,1800,'농심'),
            (5,'죠리퐁',2200,null,'크라운'),
            (6,'마카렛트',3500,3500,'롯데'),
            (7,'뿌셔뿌셔',1650,1200,'오뚜기');
	select * from product;
  
    insert into `order` (orderid,orderproduct,ordercount,orderDate) values ('c102',3,2,'2022-07-01 13:15:10');
	insert into `order` (orderid,orderproduct,ordercount,orderDate) values ('c101',4,1,'2022-07-01 14:16:11');
    insert into `order` (orderid,orderproduct,ordercount,orderDate) values ('c108',1,1,'2022-07-01 17:23:18');
    insert into `order` (orderid,orderproduct,ordercount,orderDate) values ('c109',6,5,'2022-07-02 10:46:36');
    insert into `order` (orderid,orderproduct,ordercount,orderDate) values ('c102',2,1,'2022-07-03 09:15:37');
    insert into `order` (orderid,orderproduct,ordercount,orderDate) values ('c101',7,3,'2022-07-03 12:35:12');
    insert into `order` (orderid,orderproduct,ordercount,orderDate) values ('c110',1,2,'2022-07-03 16:55:36');
    insert into `order` (orderid,orderproduct,ordercount,orderDate) values ('c104',2,4,'2022-07-04 14:23:23');
    insert into `order` (orderid,orderproduct,ordercount,orderDate) values ('c102',1,3,'2022-07-04 21:54:34');
    insert into `order` (orderid,orderproduct,ordercount,orderDate) values ('c107',6,1,'2022-07-04 14:21:03');
	
    delete from `order` where orderNo=11;
        
        select * from `order`;



#실습 1-4
select * from `Customer`;

#실습 1-5
select custId, name, hp from `Customer`;

#실습 1-6
select * from product;

#실습 1-7
select company from product ;


#실습 1-8
select distinct(company) from product;

#실습 1-9 
select prodName,price from product;

#실습 1-10
select `prodName` ,price+500 as `조정단가` from `Product`;

#실습 1-113
select `prodName`,`stock`,`price` from `product` where company='오리온';

#실습 1-12
select `orderProduct`,`orderCount`, `orderDate` from `order` where orderid='c102';

#실습 1-13
select `orderProduct`, `orderCount`,`orderDate` from `Order` where orderid='c102' AND ordercount>=2;

#실습 1-14
select * from `Product` where price >=1000 And price <=2000;

#실습 1-15
select `custid`,`name`,`hp`,`addr` from `Customer` where name Like '김%';

#실습 1-16
select custid,name,hp,addr from `Customer` where name Like '__';

#실습 1-17
select * from `Customer` where `hp` is null;
#실습 1-18
select * from Customer where addr is not null;

#실습 1-19
select * from customer order by rdate desc;

#실습 1-20
select * from `order` 
where `orderCount` >=3  
order by `orderCount` desc,`orderProduct` asc;

#실습 1-21
select AVG(price) from product;


#실습 1-22
select sum(stock) AS `재고량 합계` from product where company ='농심';

#실습 1-23
select count(custId) As`고객수`from Customer;

#실습 1-24
select count(distinct(company)) as `제조업체 수` from product;

#실습 1-25
select `orderProduct` as `주문 상품번호` , sum(`orderCount`) AS `총 주문수량` from `Order` group by orderProduct order by `orderProduct`;

SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

#실습 1-26
select `company` as `제조업체`, count(*) as `제품수`, Max(`price`) AS `최고가` from `product` group by company;

#실습 1-27
select `company` as `제조업체`,count(*) as `제품수` ,max(`price`) as `최고가` from product group by company having `제품수` >=2;

#실습 1-28
select  `orderProduct`, `orderId`,sum(orderCount)over(partition by `orderProduct`) as `총 주문수량` from `Order` order by  `orderProduct`asc;
select  `orderProduct`, `orderId`,sum(orderCount) as `총 주문수량` from `Order` group by `orderProduct`,`orderId` order by  `orderProduct`asc;



#실습 1-29
select a.orderId , b.prodName from `Order` as a join `Product` as b
on a.orderProduct = b.prodNo
where a.orderId='c102';

#실습 1-30
select `orderId`,`name`,`prodName`,`orderDate` from `order` as a 
join `Customer` As b
On a.orderId=b.custId
join `product` as c
on a.orderProduct = c.prodNo
where orderDate Like '2022-07-03%';

select `orderId`,`name`,`prodName`,`orderDate` from `order` as a 
join `Customer` As b
On a.orderId=b.custId
join `product` as c
on a.orderProduct = c.prodNo
where  substring(orderdate,1,10) = '2022-07-03';


    