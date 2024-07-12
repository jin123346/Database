#날짜 : 2024/07/12
#이름 : 하진희
#내용 : SQL연습문제5



#실습 5-1

create database `BookStore`;
create user `bookstore`@`%` identified by '1234';
grant all privileges on `BookStore`.* to `bookstore`@`%`;

flush privileges;
use bookstore;

#실습 5-2
create table `Customer` (
		`custID` int primary key auto_increment,
        `name` varchar(10) not null,
        `address` varchar(20) default null,
        `phone` varchar(13) default null
        );
        
create table `Book`(
	`bookId` int primary key,
    `bookName` varchar(20) not null,
    `publisher` varchar(20) not null,
    `price` int  default null);
    
create table `Order` (
	`orderId` int primary key auto_increment,
    `custId` int,
    `bookId` int,
    `salePrice` int ,
    `orderDate` date);
    
#실습 5-3
insert into `Customer` values 
			(1 ,"박지성","영국 맨체스터", "000-5000-0001"),
			(2 ,"김연아" ,"대한민국 서울", "000-6000-0001"),
			(3 ,"장미란" ,"대한민국 강원도", "000-7000-0001"),
			(4 ,"추신수", "미국 클리블랜드", "000-8000-0001"),
			(5, "박세리", "대한민국 대전", NULL);
            
            
       insert into `Customer` values      (5, "박세리", "대한민국 대전", NULL);
	drop table `book`;
insert into `Book` values
(1,"축구의 역사", "굿스포츠", "7000"),
(2 ,"축구아는 여자", "나무수", "13000"),
(3 ,"축구의 이해", "대한미디어", "22000"),
(4 ,"골프 바이블", "대한미디어", "35000"),
(5 ,"피겨 교본", "굿스포츠", "8000"),
(6 ,"역도 단계별기술", "굿스포츠", "6000"),
(7 ,"야구의 추억", "이성미디어", "20000"),
(8 ,"야구를 부탁해", "이성미디어", "13000"),
(9 ,"올림픽 이야기", "삼성당", "7500"),
(10 ,"Olympic Champions", "Pearson", "13000");

drop table `Order`;
insert into `Order` values
		(1, 1, 1 ,6000 ,"2014-07-01"),
		(2, 1 ,3, 21000, "2014-07-03"),
		(3, 2, 5 ,8000 ,"2014-07-03"),
		(4, 3, 6, 6000, "2014-07-04"),
		(5, 4, 7 ,20000 ,"2014-07-05"),
		(6, 1, 2 ,12000, "2014-07-07"),
		(7, 4, 8, 13000 ,"2014-07-07"),
		(8, 3, 10, 120000 ,"2014-07-08"),
		(9, 2, 10, 7000, "2014-07-9"),      	
		(10, 3, 8, 13000, "2014-07-10");        	





#실습 5-4
select * from Customer;


#실습 5-5
select bookname, price from book;
#실습 5-6
select price,bookname from book;
#실습 5-7
select * from book;
#실습 5-8
select publisher from book;

#실습 5-9
select distinct(publisher) from book;
#실습 5-10
select * from book where price>=20000;

#실습 5-11
select * from book where price<20000;

#실습 5-12
select * from book where price between 10000 AND 20000;

#실습 5-13
select * from book where price >= 15000 AND price <=30000;

#실습 5-14
select * from book where bookid =2 or bookid=3 or bookid=5; 
select * from book where bookid IN(2,3,5); 
#실습 5-15
select * from book where bookid % 2 =0;
select * from book where mod(bookid ,2) =0;

#실습 5-16
select * from Customer where name like '박%';

#실습 5-17
select * from Customer where address Like "대한민국%";

#실습 5-18
select * from Customer where phone is not null;

#실습 5-19
select * from book where publisher IN('굿스포츠','대한미디어');

#실습 5-20
select publisher from book where bookname="축구의 역사";

#실습 5-21
select publisher from book where bookname like "%축구%";

#실습 5-22
select * from book where bookname like "_구%";
#실습 5-23
select * from book where bookname like "%축구%" AND price >=20000;


#실습 5-24
select * from book order by bookname;

#실습 5-25
select * from book order by price asc, bookname;

#실습 5-26
select * from book order by price desc, publisher asc;

#실습 5-27
select * from book order by price desc limit 3;

#실습 5-28
select * from book order by price limit 3;
select * from `Order`;
update `Order` set  saleprice = 12000 where orderid=8;

#실습 5-29
select sum(salePrice) as `총판매액` from `order`;

 
 
#실습 5-30
select 
	sum(salePrice) as `총판매액`,
	avg(salePrice) as `평균값`,
    Min(salePrice) as `최저가`,
    Max(salePrice) as `최고가`  from `Order`;
#실습 5-31
select count(*) from `Order`;

#실습 5-32
update `book` set bookname = replace(bookname,"농구","야구");
select * from book; 

select bookid,
	   replace(bookname,"야구","농구"),
       publisher,
       price
       from book;


#실습 5-33
select custId , count(salePrice) as `수량` 
from `Order` 
where saleprice >=8000  
group by custId 
having `수량` >=2;

#실습 5-34
select * from customer as a 
join `Order` as b on a.custid = b.custid;

#실습 5-35
select * from customer as a 
join `Order` as b on a.custid = b.custid 
order by a.custid;

#실습 5-36
select a.name, b.saleprice from customer as a 
join `Order` as b on a.custid = b.custid 
order by a.custid;

#실습 5-37
select a.name, sum(b.saleprice) 
from customer as a 
join `Order` as b on a.custid = b.custid 
group by a.name 
order by a.name;


#실습 5-38
select a.name, c.bookname 
from customer as a 
join `Order` as b on a.custid = b.custid 
join `book` as c on b.bookid = c.bookid
order by a.name;

SELECT 
    a.name,
    (SELECT 
            c.bookname
        FROM
            book AS c
        WHERE
            c.bookid = b.bookid) AS bookname
FROM
    customer AS a
        JOIN
    `order` AS b USING (custid)
ORDER BY a.name;

#실습 5-39
SELECT 
    a.name, b.bookname
FROM
    customer AS a
        JOIN
    `Order` AS o ON a.custid = o.custid
        JOIN
    `book` AS b ON b.bookid = o.bookid
WHERE
    b.price = 20000; 
 

 
 select * from book;
 
#실습 5-40
select 
	name,
    saleprice
from customer as a left join `order` as o on a.custid = o.custid;


#실습 5-41
select sum(saleprice) from `order`
where custid In (select custid from customer as c  where name="김연아");

#실습 5-42
select bookname from book order by price desc  limit 1;
select bookname from book where price=(select max(price) from book);

#실습 5-43
select name from customer 
where custid Not in( select custid from `Order`as o ); 

select name from customer  as a 
left join `order`as o on a.custid=o.custid
where orderid is null;

#실습 5-44
insert into book values (11,"스포츠의학","한솔의학서적",null);
select * from book;

#실습 5-45
update `customer` set address ="대한민국 부산"  where  custid=5;
select * from customer;


#실습 5-46
delete from `customer` where custid=5;
select * from customer;



