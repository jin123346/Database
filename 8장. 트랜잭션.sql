# 날짜 : 2024/07/19
# 이름 : 하진희
# 내용 : 트랜잭션 실습하기


update `bank_account` set `a_balance`=100000 where a_no= '101-11-1001';

set autocommit=0;

#실습 8-1 트랜잭션Commit
start transaction;  -- transaction 시작  (locked)
UPDATE `bank_account` 
				SET 
					`a_balance` = `a_balance` - 10000
				WHERE
					`a_no` = '101-11-1001';
UPDATE `bank_account` 
				SET 
					`a_balance` = `a_balance` + 10000
				WHERE
					`a_no` = '101-11-1212';     
                    
commit;   -- transcation 작업 종료 (unlock)
select * from `bank_account`;


#실습 8-2 트랜잭션Rollback


#실습 8-3 커밋OFF