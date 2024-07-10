#날짜 : 2024/07/10
#이름 : 하진희
#내용 : SQL연습문제3

#실습 3-1
create database College;
create user `college`@`%` identified by '1234';
grant all privileges on College.*  to `college`@`%`;  
flush privileges;

use College;
#실습 3-2
create table `Student` (
				stdNo char(8) primary key,
                stdName varchar(20) not null,
                stdHp char(13) unique not null,
                stdYear int not null,
                stdAddress varchar(100) default Null
            );
            
create table `Lecture` (
				`lecNo` int primary key,
                `lecName` varchar(20) not null,
                `lecCredit` int not null,
                `letTime` int not null,
                `lecClass` varchar(10));
                
create table `Register` (
				`regStdNo` char(8) not null,
                `regLecNo` int not null,
                `regMidScore` int default null,
                `regFinalScore` int default null,
                `regTotalScore` int default Null,
                `regGrade` char(1) default null
);


#실습 3-3

insert into `Student` (stdNo,stdName,stdHp,stdYear) values ("20201016","김유신","010-1234-1001",3);
insert into `Student` values ("20201126","김춘추","010-1234-1002",3,"경상남도 경주시");
insert into `Student` values ("20210216","장보고","010-1234-1003",2,"전라남도 완도시");
insert into `Student` values ("20210326","강감찬","010-1234-1004",2,"서울시 영등포구");
insert into `Student` values ("20220416","이순신","010-1234-1005",1,"부산시 부산진구");
insert into `Student` values ("20220521","송상현","010-1234-1006",1,"부산시 동래구");

insert into `Lecture` values 
			(159,"인지행동심리학",3,40,"본304"),
			(167,"운영체제론",3,25,"본B05"),
			(234,"중급 영문법",3,20,"본201"),
			(239,"세법개론",3,40,"본204"),
			(248,"빅데이터 개론",3,20,"본B01"),
			(253,"컴퓨팅사고와 코딩",2,10,"본B02"),
			(349,"사회복지 마케팅",2,50,"본301");


insert into `Register` (regStdNo, regLecNo) values 
									("20201126",234),
									("20201016",248),
									("20201016",253),
									("20201126",239),
									("20210216",349),
									("20210326",349),
									("20201016",167),
									("20220416",349);

#실습 3-4
select * from Lecture;
#실습 3-5
select * from student;
#실습 3-6
select * from register;
#실습 3-7
select * from `Student` where stdYear=3;
#실습 3-8
select * from `Lecture` where lecCredit = 2;
#실습 3-9
SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
set sql_safe_updates=0;

update  `register` set `regMidScore`=36,`regFinalScore`=42 where `regStdNo`="20201126" AND `regLecNO`=234;
update  `register` set `regMidScore`=24,`regFinalScore`=62 where `regStdNo`="20201016" AND `regLecNO`=248;
update  `register` set `regMidScore`=28,`regFinalScore`=40 where `regStdNo`="20201016" AND `regLecNO`=253;
update  `register` set `regMidScore`=37,`regFinalScore`=57 where `regStdNo`="20201126" AND `regLecNO`=239;
update  `register` set `regMidScore`=28,`regFinalScore`=68 where `regStdNo`="20210216" AND `regLecNO`=349;
update  `register` set `regMidScore`=16,`regFinalScore`=65 where `regStdNo`="20210326" AND `regLecNO`=349;
update  `register` set `regMidScore`=18,`regFinalScore`=38 where `regStdNo`="20201016" AND `regLecNO`=167;
update  `register` set `regMidScore`=25,`regFinalScore`=58 where `regStdNo`="20220416" AND `regLecNO`=349;

alter table register add seq int auto_increment primary key First;

alter table register drop column seq;



select * from register;

show columns from register;

#실습 3-10
update `register` set `regTotalScore`=`regMidScore`+`regFinalScore`,
						`regGrade` = if(`regTotalScore`>=90,'A',
									 if(`regTotalScore`>=80,'B',
									 if(`regTotalScore` >=70,'C',
									 if(`regTotalScore`>=60,'D','F'))));
select * from register;
#실습 3-11
select * from `Register` order by `regTotalScore` desc;
#실습 3-12
select * from `Register` where regLecNo=349 order by `regTotalScore` desc;
#실습 3-13
 alter table `Lecture` rename column letTime to lecTime;
select * from `Lecture` where lecTime >= 30;
#실습 3-14
select lecName , lecClass from lecture;
#실습 3-15
select stdNo, stdName from student;
#실습 3-16
select * from `student` where stdAddress is null;
#실습 3-17
select * from `Student` where substring(stdAddress,1,3) ='부산시';
#실습 3-18
select * from `Student` as a left join `Register` as b on  a.stdNo = b.regstdNo;

#실습 3-19
select 
	a.stdNo,
    a.stdName,
    b.regLecNo,
    b.regMidScore,
    b.regFinalScore,
    b.regTotalScore,
    b.regGrade
from `Student` AS a , Register as b where a.stdNo=b.regstdNO;

#실습 3-20
select `stdName`,`stdNo`,`regLecNo`
from `Student` as a
join `Register` as b
on a.stdNo=b.regstdNo where regLecNo=349;

#실습 3-21
select 
	stdNo,
    stdName,
    Count(`stdNo`) as `수강신청 건수`,
    Sum(`regTotalScore`) as `종합점수`,
    sum(`regTotalScore`)/Count(`stdNo`) as `평균`
from `Student` as a
join `Register` as b
on a.stdNo=b.regStdNo
group by stdNo;

#실습 3-22
select * from `Register` as a, `Lecture` as b 
where a.regLecNo = b.lecNo;

#실습 3-23
select 
	`regStdNo`,
    `regLecNo`,
    `lecName`,
    `regMidScore`,
    `regFinalScore`,
    `regTotalScore`,
    `regGrade`
    from register as a , lecture as b
    where a.regLecNo=b.lecNo;

#실습 3-24
select  
	count(*) as `사회복지 마케팅 수강 신청 건수`,
    AVG(`regTotalScore`) as `사회복지 마케팅 평균`
from `Register` As a join `Lecture` as b on a.regLecNo = b.LecNo
where a.regLecNo=349;

#실습 3-25
select 
	`regStdNo`,
    `lecName`
from `Register` as a join `Lecture` as b on a.regLecNo=b.lecNo
where `regGrade`="A";
#실습 3-26
select * from `Student` AS a
join `Register` As b on a.stdNo = b.regStdNo 
join `Lecture` as c on c.lecNo = b.regLecNo;
#실습 3-27
select 
	`stdNo`,
    `stdName`,
    `lecNo`,
    `lecName`,
    `regMidScore`,
    `regFinalScore`,
    `regTotalScore`,
    `regGrade`
from `Student` as a
join `Register` As b on a.stdNo = b.regStdNo 
join `Lecture` as c on c.lecNo = b.regLecNo;

#실습 3-28
select 
	`stdNo`,
    `stdName`,
    `lecName`,
    `regTotalScore`,
    `regGrade`
from `Student` as a
join `Register` As b on a.stdNo = b.regStdNo 
join `Lecture` as c on c.lecNo = b.regLecNo
where `regGrade`='F';
#실습 3-29

select 
	`stdNo`,
    `stdName`,
    sum(`lecCredit`) AS `이수학점`
from `Student` as a
join `register` as b on a.stdNo = b.regStdNo
join `Lecture` as c on c.lecNo = b.regLecNo
where  regGrade <> 'F'
group by a.stdNo;
#실습 3-30
select 
	`stdNo`,
    `stdName`,
	group_concat(`lecName`) as `신청과목`,
    group_concat(if(`regTotalScore` >= 60, `lecName`,null)) as `이수과목`
from `Student` as a
join `Register` as b on a.stdNo = b.regStdNo
join `Lecture` as c on c.lecNo = b.regLecNo
group by stdNo;

