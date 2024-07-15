# 날짜: 2024/07/15
# 이름 : 하진희
# 내용 : 데이터 모델링 실습하기

# 실습 6-2
use shoperd;
insert into `Customer` values 
				("c101","김유신","010-1234-1001","경남 김해시","2023-01-01"),
				("c102","김춘추","010-1234-1002","경남 경주시","2023-01-02"),
				("c103","장보고","010-1234-1003","전남 완도군","2023-01-03"),
				("c104","강감찬","010-1234-1004","서울시 관악구","2023-01-04"),
				("c105","이순신","010-1234-1005","부산시 금정구","2023-01-05");

insert into Product values
			(1,"새우깡",5000,1500,"농심"),
			(2,"초코파이",2500,2500,"오리온"),
			(3,"포카칩",3600,1700,"오리온"),
			(4,"양파링",1250,1800,"농심"),
			(5,"죠리퐁",2200,null,"크라운");
            
insert into `Order` values
			(1,"c102",3,2,"2023-01-01 13:15:10"),
			(2,"c101",4,1,"2023-01-01 13:15:12"),
			(3,"c102",1,1,"2023-01-01 13:15:14"),
			(4,"c103",5,5,"2023-01-01 13:15:16"),
			(5,"c105",2,1,"2023-01-01 13:15:18");
            
delete from `Order` where orderNo = 4; 
# 실습 6-3

select * from `Order`;
select 
	a.orderNo,
    b.name,
    p.prodName,
    a.orderCount,
    a.orderDate 
 from `Order`as a 
 join Customer as b on b.custid = a.orderid 
 join Product as p  on p.prodNo = a.orderProduct;

select 
	a.orderNo,
    a.orderNo,
    p.prodName,
    p.price,
    a.orderCount,
    a.orderDate 
 from `Order`as a 
 join Customer as b on b.custid = a.orderid 
 join Product as p  on p.prodNo = a.orderProduct
 where b.name="김유신";
 
 select sum(p.price*o.orderCount) as `총 주문 금액` from product as p 
 join `Order` as o  on p.prodNo = o.orderProduct; 
 
# 실습 6-4 <Bank 모델링 실습>
#erd 생성하기 
use bank;


# 실습 6-5

select* from bank_customer;

delete from `bank_customer`;
delete from `bank_transaction`;
delete from `bank_account`;

insert into `bank_customer` values
			("730423-1000001","김유신",1,"010-1234-1001","경남 김해시"),
			("730423-1000002","김춘추",1,"010-1234-1002","경남 경주시"),
			("730423-1000003","장보고",1,"010-1234-1003","전남 완도군"),
			("102-12-51094","(주)정보산업",2,"051-500-1004","부산시 부산진구"),
			("930423-1000005","이순신",1,"010-1234-1005","서울 종로구");

insert into `bank_transaction` values
				(1,"101-11-1001",1,50000,"2023-01-01 13:15:10"),
				(2,"101-12-1001",2,1000000,"2023-01-02 13:15:12"),
				(4,"101-11-1002",2,100000,"2023-01-04 13:15:16"),
				(5,"101-11-1003",3,75000,"2023-01-05 13:15:18"),
				(6,"101-11-1001",1,150000,"2023-01-06 13:15:28");
                
insert into `bank_transaction` values (3,"101-11-1002",3,260000,"2023-01-03 13:15:14");
insert into `bank_account` values
			("101-11-1001","S1","자유저축예금","730423-1000001",1550000,"2011-04-11"),
			("101-11-1002","S1","자유저축예금","930423-1000005",260000,"2011-05-12"),
			("101-11-1003","S1","자유저축예금","730423-1000003",75000,"2011-06-13"),
			("101-12-1001","S2","기업전용예금","102-12-51094",15000000,"2011-07-14"),
			("101-13-1001","S3","정기저축예금","730423-1000002",1200000,"2011-08-15");
            
		
                
select * from bank_transaction;
# 실습 6-6
select 
	c.c_no,
	c.c_name,
    c.c_phone,
    a.a_no,
    a.a_item_name,
    a.a_balance
 from bank_customer as c left join bank_account as a 
 on c.c_no = a.a_c_no;

SELECT 
    t.t_dist, t.t_amount, t.t_datetime
FROM
    `bank_transaction` AS t
        JOIN
    `bank_account` AS a ON a.a_no = t.t_a_no
WHERE
    a.a_c_no IN (SELECT 
            c.c_no
        FROM
            bank_customer AS c
        WHERE
            c_name = '이순신');
		
        



use bank;
select 
	a_c_no,
    c_name,
    a_no,
    a_balance,
    a_open_date
from bank_account as a 
join bank_customer as c on a.a_c_no = c.c_no
where c.c_dis = 1
order by a_balance desc 
limit 1;

# 실습 6-7

select * from student;
insert into `Student`  values	
		("20201011","김유신","010-1234-1001",3,"경남 김해시"),
		("20201122","김춘추","010-1234-1002",3,"경남 경주시"),
		("20210213","장보고","010-1234-1003",2,"전남 완도군"),
		("20210324","강감찬","010-1234-1004",2,"서울 관악구"),
		("20220415","이순신","010-1234-1005",1,"서울 종로구");

insert into `lecture` values 
			(101,"컴퓨터와 개론",2,40 ,"본301"),
			(102,"프로그래밍 언어",3, 52,"본302"),
			(103,"데이터베이스",3, 56,"본303"),
			(104,"자료구조",3, 60,"본304"),
			(105,"운영체제",3, 52,"본305");
            
insert into Register values
		("20220415",101,60,30,null,null),
		("20210324",103,54,36,null,null),
		("20201011",105,52,28,null,null),
		("20220415",102,38,40,null,null),
		("20210324",104,56,32,null,null),
		("20210213",103,48,40,null,null);
        
        



# 실습 6-9
use Collegeerd;
select * from Student where stdNo Not IN  (select regStdNo from register);

select 
	`stdNo`,
    `stdName`,
    `stdHp`,
    `stdYear`
from `Student` as a
left join `Register` as b on a.stdNo = b.regStdNo
where `regStdNo` is null; 



select 
	`regStdNo`, 
    `regLecNo`, 
    `regMidScore`,
    `regFinalScore`,
    `regMidScore` + `regFinalScore` as `합`,
    case
		when (`regMidScore` + `regFinalScore` >= 90) then 'A'
		when (`regMidScore` + `regFinalScore` >= 80) then 'B'
		when (`regMidScore` + `regFinalScore` >= 70) then 'C'
		when (`regMidScore` + `regFinalScore` >= 60) then 'D'
	else 'F'
    end as `등급`
from `Register`;

update register set regTotalScore = regMidScore + regFinalScore ;
update register set regGrade = 
		case
			when regTotalScore >=90 AND regTotalScore<=100 then "A"
			when regTotalScore >=80 AND regTotalScore<90 then "B"
			when regTotalScore >=70 AND regTotalScore<80 then "C"
			when regTotalScore >=60 AND regTotalScore<70 then "D"
			when regTotalScore >=50 AND regTotalScore<60 then "E"
		    else "F"
		end;
        
select * from register;

select 
	s.stdNo,
    s.stdName,
    s.stdYear,
    lecName,
    regMidScore,
    regFinalScore,
    regTotalScore,
    regGrade
from register as r join lecture as l on r.reglecno = l.lecNo 
join student as s on s.stdno= r.regstdno  
where stdYear = 2;


		
        
		

