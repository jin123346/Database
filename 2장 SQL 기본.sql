#날짜 : 2024.07.01
#내용 : 2장 SQL 기본
#이름 : 하진희

#실습 2-1. 테이블 생성, 제거
use StudyDB;

Create table `User1`(
	`uid` varchar(10),
    `name` varchar(10),
    `hp` char(13),
    `age` int
    );
    
drop table `User1`;


#실습 2-2. 데이터 입력 #ctrl+shift +enter 여러개 지정시 
Insert into `User1` values('A101','김유신','010-1234-1111',25);
Insert into `User1` values('A102','김춘추','010-1234-1122',30);
Insert into `User1` values('A103','장보고','010-1234-1133',21);
Insert into `User1` values('A104','궁예','010-1234-1144',0);
Insert into `User1` values('A105','서희','010-1234-1155',34);

Insert into `User1` (`uid`,`name`,`age`) values ('ㅁ106','강감찬',45);

#실습 2-3. 데이터 조회
select * from User1;
select * from User1 where uid='A101';
select * from User1 where name='김춘추';
select * from User1 where age < 30;
select * from User1 where age >=30;
select uid,name,age from User1;

## 수정 및 삭제시 You are using safe update mode ~ 뜨면서 수정 안될때 아래 쿼리 실행
set sql_safe_updates=0;
#실습 2-4 데이터 수정 
update User1 set hp='010-1234-1199' where uid='A101';
update User1 set age='51' where uid='A105';
update User1 set hp = '010-1234-1001' where uid='A103';


select * from User1;

#실습 2-5. 데이터 삭제
delete from User1 where uid='A101';
delete from User1 where uid='A102' AND age=30;

select * from User1;

#실습 2-6. 테이블 컬럼 수정
## 테이블 제일 끝 열에 컬럼 추가
Alter table User1 add gender tinyint;
## 지정한 컬럼의 다음에 컬럼 추가
Alter table USer1 add birth Char(10) AFTER name;
##지정한 컬럼의 데이터 타입 수정
Alter table User1 modify gender char(1);
alter table User1 modify age TINYINT;
##지정한 컬럼 제거 
Alter table User1 drop gender;

show columns from User1;


select * from User1;

#2-7 테이블 복사 
#Create table 새로운테이블명 Like 복사할테이블명alter

create table User1Copy like User1;
Insert into User1Copy select * from USer1;

# 테이블 데이터 복사
#INSERT INTO 테이블명 SELECT * FROM 복사할_테이블명;
#INSERT INTO 테이블명 (칼럼명...) SELECT 칼럼명... FROM 복사할_테이블명;
select * from User1Copy;
show tables; 

#실습 2-8 아래와 같이 테이블 생성 후 데이터를 입력하시오. 

create table TblUser (
	user_id varchar(10),
    user_name varchar(10),
    user_hp char(13),
    user_age int,
    user_addr varchar(20)
    );
    
create table TblProduct(
	prod_no varchar(10),
    prod_name varchar(10),
    prod_price int,
    prod_stock int,
    prod_company varchar(20),
    prod_date date
    );
    
    show tables;
    
show columns from tbluser;
show columns from tblproduct;


insert into tbluser values ('p101','김유신','010-1234-1001',25,'경남 김해시');
insert into tbluser values ('p102','김춘추','010-1234-1002',23,'경남 경주시');
insert into tbluser values ('p103','장보고',null,31,'전남 완도군');
insert into tbluser values ('p104','강감찬',Null,null,'서울시 중구');
insert into tbluser values ('p105','이순신','010-1234-1005',25,null);

update tbluser set user_age=50 where user_name='이순신';
select * from tbluser;

insert into tblproduct (prod_no,prod_name,prod_price,prod_stock,prod_company,prod_date) 
	values
    ('1001','냉장고',800000, 25,'LG전자',20220106),
    ('1002','노트북',1200000, 120,'LG전자',20220106),
    ('1003','모니터',350000, 35,'LG전자',20220106),
    ('1004','세탁기',1000000, 80,'LG전자',20220106),
    ('1005','컴퓨터',1500000, 20,'삼성전자',20220106),
    ('1006','휴대폰',950000, 102,null,20220106);

select * from tblproduct;

select user_name from tbluser;

select user_name , user_hp from tblUser;

select * from tbluser where user_id='p102';
select * from tbluser where user_id='p104' or user_id='p105';
select * from tbluser where user_addr='부산시 금정구';

select * from tbluser where user_age > 30;

select * from tbluser where user_hp IS NULL;

update tbluser set user_age=42 where user_id='p104';

delete from tbluser where user_id='p103';


select * from tbluser;

select * from tblProduct where prod_company = 'LG전자';

update tblproduct set prod_company='삼성전자' where prod_no=1006; 

select * from tblproduct;
