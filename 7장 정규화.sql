# 날짜 : 2024/07/19
# 이름 : 하진희
# 내용 : 정규화 실습하기



use Studydb;
drop table BookOrder;
create table `BookOrder` (
	`orderNo` int ,
    `orderDate` date,
    `userId` varchar(10),
    `userName` varchar(10),
    `userAddr` varchar(20),
    `bookNo` int,
    `bookName`varchar(20),
    `count` int,
    `price` int);
    
    select * from bookorder;
    
    insert into `bookOrder` values 
		(10001,now(),'a101','김유신','김해',101,'프로그래밍',1,28000),
		(10002,now(),'a102','김춘추','경주',101,'프로그래밍',1,28000),
		(10002,now(),'a102','김춘추','경주',102,'자료구조',2,32000),
		(10003,now(),'a103','장보고','완도',102,'자료구조',2,32000),
		(10004,now(),'a104','강감찬','서울',110,'데이터베이스',1,25000),
		(10005,now(),'a105','이순신','서울',110,'데이터베이스',1,25000),
		(10005,now(),'a105','이순신','서울',102,'자료구조',1,41000);
        
select * from userOrder;
select * from `order`;

select * from book;
