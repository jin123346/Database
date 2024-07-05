#날짜 : 2024/07/05
#이름 : 하진희
#내용 : 5장 데이터베이스 개체

#실습 5-1

show index from `user1`;
show index from `user2`;
show index from `user3`;
show index from `user4`;

#실습 5-2
create  index `idx_user1_uid` on `user1` (`uid`);

select * from user1;

analyze table user1;

select * from user5;

insert into `user5` (name,gender,age,addr) select `name`,`gender`,`age`,`addr` from `user5`;

update `user5` set `name`='홍길동' where `seq`=3;



select * from user5;

update `user5` set `name`='정약용3' where `seq`=1000000;
update `user5` set `name`='안중근' where `seq`=4000000;

select count(*) from `user5`;


select * from `user5` where name='홍길동';

select * from `user5` where name='정약용3';
select * from `user5` where name='안중근';

select * from `user5` where seq=4000000;

create index `idx_user5_name` on `user5` (`name`);

analyze table user5;


delete from user5 where `seq`>5;


select * from user5;

#실습 5-4 뷰 생성
create view `vw_USER1` AS (select `name`,`hp`,`age` from `User1`);

create view `vw_user4_age_under30` AS (Select * from `user4` where `age`<30);

create view `vw_member_with_sales` AS (
	select 
		a.uid as `직원아이디`,
		b.name as `직원이름` ,
		b.pos as `직급`,
		c.name as `부서명` ,
		a.year as `매출년도`,
		a.month as `월`,
		a.sale as `매출액`
    from sales as a 
    join member as b on a.uid=b.uid
    join department as c on b.dep=c.depNo
);
#실습 5-5 뷰 조회
select * from vw_user1;
select * from vw_user4_age_under30;
select * from vw_member_with_sales;


#실습 5-6 뷰 삭제 
drop view `vw_user1`;


#실습 5-7.프로시저생성및실행기본
delimiter $$
	create procedure proc_test()
	begin
		select * from `member`;
        select * from `department`;
	End $$
delimiter ;



call proc_test();   
  

select * from member;
#실습5-8.매개변수를갖는프로시저생성및실행

delimiter $$
	create procedure proc_test2(IN _userName varchar(10))
	begin
		select * from `member` where `name`=_username;
	End $$
delimiter ;
call proc_test2('김유신');  

delimiter $$
	create procedure proc_test3(IN _pos varchar(10),In _dep Tinyint)
	begin
		select * from `member` where `pos`=_pos AND `dep`=_dep;
	End $$
delimiter ;
call proc_test3('차장',101);

delimiter $$
	create procedure proc_test4(In _pos varchar(10), Out _count int)
	begin
		select count(*) into _count from `member` where `pos`=_pos;
	End $$
delimiter ;
call proc_test4('차장',@_count);
select concat('_count : ',@_count );

#실습5-9.프로시저프로그래밍

delimiter $$ 
	create procedure proc_test5(IN _name varchar(10))
	begin
		declare userid varchar(10);
        select `uid` into userid from `member` where `name`=_name;
        select * from sales where `uid`=userid;
	End $$
delimiter ;

call proc_test5('김유신');

delimiter $$
	create procedure proc_test6()
	begin
		declare num1 int;
        declare num2 int;
        
        set num1=1;
        set num2=2;
        
        if(num1>num2) then
			select 'num1이 num2보다 크다' as `결과2`;
		else
			select 'num1이 num2보다 작다' as `결과2`;
		end if;
	end $$
delimiter ;

call proc_test6();


delimiter $$ 
create procedure proc_test7()
	begin
		declare sum int;
        declare num int;
        
        set sum=0;
        set num=1;
        
        while (num<=10) DO
			set sum = sum+ num;
            set num = num+1;
		End while;
        
        select sum as '1부터 10까지 합계';
	end $$
    delimiter ;
    
    call proc_test7();

#실습5-10.커서를활용하는프로시저
 DELIMITER $$
	 CREATE PROCEDURE proc_test8()
	 BEGIN    
	   # 변수 선언
	   DECLARE total INT DEFAULT 0;
	   DECLARE price INT;
	   DECLARE endOfRow BOOLEAN DEFAULT false;  # 상태변수
			
	   # 커서 선언
	   DECLARE salesCursor CURSOR FOR
			SELECT `sale` FROM `Sales`;
		
	   # 반복 조건
	   DECLARE CONTINUE HANDLER
			FOR NOT FOUND SET endOfRow = TRUE;
	   # 커서 열기
	   OPEN salesCursor;
		
	   cursor_loop: LOOP
		  FETCH salesCursor INTO price;
		  IF endOfRow THEN
			LEAVE cursor_loop;
		  END IF;   #if문 종료
			
		  SET total = total + price;
	   END LOOP;
		
	   SELECT total AS '전체 합계';
		
	   CLOSE salesCursor;
	 END $$
 DELIMITER ;
 
 call proc_test8();
#실습5-11.저장함수생성및호출

 DELIMITER $$
 CREATE FUNCTION func_test1(_userid VARCHAR(10)) RETURNS INT  #3 반환타입 지정
 BEGIN
    DECLARE total INT;
    SELECT SUM(`sale`) INTO total FROM `Sales` WHERE `uid`=_userid;
    RETURN total;
 END $$
 DELIMITER ;
 
 
 drop function func_test1;
 
 select * from sales;
 
 SELECT func_test1('a102');
 
DELIMITER $$
 CREATE FUNCTION func_test2(_sale INT) RETURNS DOUBLE
 BEGIN
    DECLARE bonus DOUBLE;
    IF (_sale >= 100000) THEN
   SET bonus = _sale * 0.1;
       ELSE
   SET bonus = _sale * 0.05;   
       END IF;
 RETURN bonus;
 END $$
 DELIMITER ;


select 
	uid,
    year,
    month,
    sale,
    func_test2(sale) as `bouus`
from `sales`;
