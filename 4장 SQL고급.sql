# 날짜 : 2024.07.05
# 이름 : 하진희
# 내용 : 4장. SQL 고급
#실습 4-1
create table Member (
	uid varchar(10) primary key,
    name varchar(10) not null,
	hp char(13) unique not null,
    pos varchar(10) not null default '사원',
    dep int,
    rdate datetime	not null
);

drop table department;
create table Department (
	depNo int primary key auto_increment,
    name varchar(10) not null,
    tell char(12) not null
);
drop table sales;
create  table Sales (
	seq int primary key auto_increment,
    uid varchar(10) not null,
    year year not null,
    month tinyint not null,
    sale int default NULL
);

show tables;

show columns from Member;
show columns from department;
show columns from Sales;

#실습 4-2
insert into member values
		('a101','박혁거세','010-1234-1001','부장',101,now()),
        ('a102','김유신','010-1234-1002','차장',101,now()),
        ('a103','김춘추','010-1234-1003','사원',101,now()),
        ('a104','장보고','010-1234-1004','대리',102,now()),
        ('a105','강감찬','010-1234-1005','과장',102,now()),
        ('a106','이성계','010-1234-1006','차장',103,now()),
        ('a107','정철','010-1234-1007','차장',103,now()),
        ('a108','이순신','010-1234-1008','부장',104,now()),
        ('a109','허균','010-1234-1009','부장',104,now()),
        ('a110','정약용','010-1234-1010','사원',105,now()),
        ('a111','박지원','010-1234-1011','사원',105,now());

select * from member;
insert into department values (101,'영업1부','051-512-1002');


insert into  department (name,tell) values
                        ('영업3부','051-512-1003'),
                        ('영업4부','051-512-1004'),
                        ('영업5부','051-512-1005'),
                        ('영업지원부','051-512-1006'),
                        ('인사부','051-512-1007');
                        
select * from department;

insert into sales (uid, year,month,sale) values
				('a101',2018,1,98100),
                ('a102',2018,1,136000),
                ('a103',2018,1,80100),
                ('a104',2018,1,78000),
                ('a105',2018,1,93000),
                ('a101',2018,2,23500),
                ('a102',2018,2,126000),
                ('a103',2018,2,18500),
                ('a105',2018,2,19000),
                ('a106',2018,2,53000),
                ('a101',2019,1,24000),
                ('a102',2019,1,109000),
                ('a103',2019,1,101000),
                ('a104',2019,1,53500),
				('a107',2019,1,24000),
                ('a102',2019,2,160000),
                ('a103',2019,2,101000),
                ('a104',2019,2,43000),
                ('a105',2019,2,24000),
                ('a106',2019,2,109000),
                ('a102',2020,1,201000),
                ('a104',2020,1,63000),
                ('a105',2020,1,74000),
                ('a106',2020,1,122000),
                ('a107',2020,1,111000),
                ('a102',2020,2,120000),
                ('a103',2020,2,93000),
                ('a104',2020,2,84000),
                ('a105',2020,2,180000),
                ('a108',2020,2,76000);    
                
select * from sales;

#실습 4-3
select * from member where name='김유신';
select * from member where pos='차장' AND dep=101;
select * from member where pos='차장' or dep =101;
select * from member where name!= '김춘추';   # 김춘추가 아닌 사람
select * from member where name <> '김춘추'; # 이름이 김춘추가 아닌 사람
select * from member where pos='사원' or pos='대리';  # pos가 사원이거나 대리인 사람
select * from member where pos IN('사원','대리'); # pos가 사원이거나 대리인 사람
select * from member where dep in(101,102,103); #dep이 101,102,103중에 해당하는 사람
select * from member where name Like '%신'; #이름에 신으로 끝나는 사람
select * from member where name Like '김%';# 이름이 김으로 시작하는 사람
select * from member where name like '%거%'; #이름에 거가 포함된 사람
select * from member where name like '김__';
select * from member where name like '김_';
select * from member where name like '_성_';
select * from member where name like '정__';

select * from sales where sale > 50000;
select * from sales where sale >=50000 AND sale < 100000 AND month=1;
select * from sales where sale between 50000 and 100000;
select * from sales where sale not between 50000 and 100000;

select * from sales where year in(2020);
select * from sales where year in(2018);

select * from sales where month in(1,2);

select * from sales;
select * from sales order by sale asc;

select * from sales order by sale desc;

select * from sales 
		where sale>50000
        order by year, month, sale desc;


#실습 4-4
#실습 4-5

select * from sales limit 3;
select * from sales LIMIT 5, 3;
select * from sales limit 1, 2;
select * from sales order by sale desc limit 3, 5;

select * from sales where sale < 50000 order by sale desc limit 3;

select * from sales 
			where sale>50000
            order by year desc, month, sale desc
            limit 5;
#실습 4-6

select sum(sale) as 합계 from sales;
select count(*) as `갯수` from sales;

select concat("Hello","World");
select concat(uid,name,hp) from member where uid='a108';

select now();

insert into member values('a112','유관순','010-1234-1012','대리',107,now());

select * from member;
#실습 4-7
select sum(sale) as `2018년 1월 매출의 총합` from sales where year=2018 and month =1; 
select sale,sum(sale) as `합계` from sales 
group by year,month
order by year desc;

#실습 4-8
select sum(sale) as `총합` ,avg(sale) as `평균`
from sales 
where year in(2019) AND month in(2) and sale>=50000;
#실습 4-9
select max(sale) as `최고`, min(sale) as `최저` 
from sales 
where year in(2020);

select max(sale) as `최고`, min(sale) as `최저` 
from sales 
where year=2020;
#실습 4-10
#실습 4-11
#실습 4-12
#실습 4-13
#실습 4-14
#실습 4-15

#실습 4-1
#실습 4-1
#실습 4-1
#실습 4-1


