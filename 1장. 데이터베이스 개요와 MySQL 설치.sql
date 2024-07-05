#날짜 : 2024.07.01
#내용 : 1장 데이터베이스 개요와 MySQL 설치
#이름 : 하진희

#실습 1-1.MySQL 접속, 데이터베이스 생성 및 삭제
CREATE DATABASE `StudyDB`;
show databases; #ctrl+enter

drop database `StudyDB`;

#실습 1-2. 일반 관리자 생성 및 권한 부여
create user 'id'@'%' identified by 'passwd';

grant all privileges on StudyDB.* to 'hajhi79'@'%';
flush privileges;

drop user 'hajhi789'@'%';

#실습 1-3. 사용자 비밀번호 수정 및 삭제
alter user 'hajhi789'@'%' identified by '~~~~';
drop user 'hajhi789'@'%';

Flush privileges;






