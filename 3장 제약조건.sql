# 날짜 : 2024/07/02
# 이름 : 하진희
# 내용 : 3장 제약조건

# 실습 3-1 기본키 실습하기

create table `User2`(
	`uid` Varchar(10) Primary key,
	`name` varchar(10),
    `birth` char(10),
    `addr` varchar(50)
    );
    


# 실습 3-2 
insert into User2 values ('A101','김유신','1968-05-09','경남 김해시');
insert into User2 values ('A102','김춘추','1972-11-23','경남 경주시');
insert into User2 values ('A103','장보고','1978-03-01','전남 완도군');
insert into User2 values ('A104','강감찬','1979-08-16','서울시 관악구');
insert into User2 values ('A105','이순신','1981-05-23','부산시 진구');

show columns from user2;
select * from User2;

# 실습 3-3 고유키 실습하기 
create table User3(
	uid varchar(10) primary key,
    name varchar(10),
    birth char(10),
    hp char(13) unique,
    addr varchar(50)
);

show columns from user3;

# 실습 3-4 
insert into User3 values ('A101','김유신','1968-05-09','010-1234-1001','경남 김해시');
insert into User3 values ('A102','김춘추','1972-11-23','010-1234-1002','경남 경주시');
insert into User3 values ('A103','장보고','1978-03-01','010-1234-1003','전남 완도군');
insert into User3 values ('A104','강감찬','1979-08-16','010-1234-1004','서울시 관악구');
insert into User3 values ('A105','이순신','1981-05-23','010-1234-1005','부산시 진구');

select * from User3;
# 실습 3-5 

drop table Parent;
show tables;

create table Parent(
	pid Varchar(10) Primary key,
    name varchar(10),
    birth char(10),
    addr varchar(100)
);

create table child(
	cid varchar(10) primary key,
    name varchar(10),
    hp char(13) unique,
    parent varchar(10),
    foreign key(parent) references parent(pid)
    );
    
    
    
show columns from child;

show columns from parent;
# 실습 3-6 
insert into Parent (pid,name,birth,addr) values
	('p101','김유신','1968-05-09','경남 김해시'),
    ('p102','김춘추','1972-11-23','경남 경주시'),
    ('p103','장보고','1979-03-01','전남 완도시'),
    ('p104','강감찬','1979-08-16','서울 관악구'),
    ('p105','이순신','1981-05-23','부산 진구');
    
select * from parent;

insert into child values 
		('c101','김철수','010-1234-1001','p101'),
        ('c102','김여희','010-1234-1002','p101'),
        ('c103','강철수','010-1234-1003','p103'),
        ('c104','이철수','010-1234-1004','p105');
        
select * from child;

insert into child values('c105','최철수','010-1234-1005','p107'); 
#pid 값이 parent테이블에 없기 떄문에 입력 불가능

# 실습 3-7  
create table user4 (
	uid varchar(10) primary key,
    name varchar(10) not null,
    gender char(1),
    age int default 1,
    hp char(13) unique,
    addr varchar(20)
);

show columns from user4;



# 실습 3-8 
insert into user4 values 
	('A101','김유신','M',25,'010-1234-1111','경남 김해시'),
    ('A102','김춘추','M',23,'010-1234-2222','경남 경주시'),
    ('A103','장보고','M',35,'010-1234-3333','전남 완도시'),
    ('A104','강감찬','M',42,'010-1234-4444','서울 관악구'),
    ('A106','신사임당','F',32,null,'강릉시'),
	('A107','허난설현','F',27,null,'경기도 광주시');
    
insert into user4 (uid,name,gender,hp,addr) values ('A110','강감찬','M','010-1234-8888','서울 관악구');


select * from user4;


# 실습 3-9 
create table user5 (
	seq int primary key auto_increment,
    name varchar(10) not null,
    gender char(1) check(gender IN('M','F')),
    age int default 1 check(age >0  AND age < 200),
    addr varchar(20)
);

show columns from user5;

insert into user5 (name,gender,age,addr) values ('김유신','M',25,'경남 김해시');
insert into user5 (name,gender,age,addr) values ('김춘추','M',23,'경남 경주시');                
insert into user5 (name,gender,age,addr) values ('김장보고','M',35,'전남 완도시');
insert into user5 (name,gender,age,addr) values ('강감찬','M',42,'서울시 관악구');
insert into user5 (name,gender,age,addr) values ('이순신','A',51,'부산시');
insert into user5 (name,gender,age,addr) values ('신사임당','F',-1,'강릉시');

select * from user5;