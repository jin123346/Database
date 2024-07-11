#날짜 : 2024/07/11
#이름 : 하진희
#내용 : SQL연습문제4

#실습 4-1
create database `Theater`;
create user `theater`@`%` identified by '1234';
grant all privileges On `Theater`.* to `theater`@`%`;
flush privileges;

use mysql;
select * from user;
#실습 4-2
create table `Movies`(
	movie_id int primary key auto_increment,
    title varchar(30) not null,
    genre varchar(10) not null,
    release_date date not null
); 
rename table `Customer` to `Customers`;
create table Customers(
	customer_id int primary key auto_increment,
    name varchar(20) not null,
    email varchar(50) not null,
    phone char(13) not null
);

create table Bookings 
(	booking_id int primary key ,
	customer_id int not null,
    movie_id int not null,
    num_tickets int not null,
    booking_date datetime not null
);

select * from movies;
#실습 4-3
update Movies set movie_id=1 where movie_id=11;
update Movies set movie_id=2 where movie_id=12;
update Movies set movie_id=3 where movie_id=13;
update Movies set movie_id=4 where movie_id=14;
update Movies set movie_id=5 where movie_id=15;
update Movies set movie_id=6 where movie_id=16;
update Movies set movie_id=7 where movie_id=17;
update Movies set movie_id=8 where movie_id=18;
update Movies set movie_id=9 where movie_id=19;
update Movies set movie_id=10 where movie_id=20;
insert into `Movies` (title,genre,release_date) values
					("쇼생크의 탈출","드라마","1994-10-14"),
					("타이타닉","로맨스","1997-03-24"),
					("탑컨","액션","1987-07-16"),
					("쥬라기공원","액션","1994-02-11"),
					("글래디에이터","액션","2000-05-03"),
					("시네마천국","드라마","1995-04-12"),
					("미션임파서블","액션","1995-11-11"),
					("노트북","로맨스","2003-08-23"),
					("인터스텔라","SF","2011-05-26"),
					("아바타","SF","2010-02-10");

insert into `Customers` (name,email,phone) values
					("김유신","kys@example.com","010-1234-1001"),
					("김춘추","kcc@example.com","010-1234-1002"),
					("장보고","jbg@example.com","010-1234-1003"),
					("강감찬","kgc@example.com","010-1234-1004"),
					("이순신","iss@example.com","010-1234-1005");
                    
select * from Customers;
drop table bookings;

INSERT INTO Bookings (booking_id, customer_id, movie_id, num_tickets, booking_date) VALUES 
(101, 1,  1, 2, '2023-01-10'),
(102, 2,  2, 3, '2023-01-11'),
(103, 3,  2, 2, '2023-01-13'),
(104, 4,  3, 1, '2023-01-17'),
(105, 5,  5, 2, '2023-01-21'),
(106, 3,  8, 2, '2023-01-21'),
(107, 1, 10, 4, '2023-01-21'),
(108, 2,  9, 1, '2023-01-22'),
(109, 5,  7, 2, '2023-01-23'),
(110, 3,  4, 2, '2023-01-23'),
(111, 1,  6, 1, '2023-01-24'),
(112, 3,  5, 3, '2023-01-25');

#실습 4-4
select title from `Movies`;


#실습 4-5
select * from movies where genre = "로맨스";


#실습 4-6
select movie_id,title,genre,release_date from movies where year(release_date) >= 2010;

#실습 4-7
select booking_id,booking_date from bookings where num_tickets>=3;

#실습 4-8

select * from bookings where date(booking_date)< "2023-01-20";
#실습 4-9
select * from Movies where release_date Between '1990-01-01' AND '1999-12-31';
#실습 4-10
select * from bookings
order by booking_date desc
limit 3;
#실습 4-11
select title,release_date from movies
order by release_date asc
limit 1;

#실습 4-12
select 
	concat(title,' - ',release_date) as movie_info
from movies
where genre = "액션" And title Like "%공원%"
order by release_date asc
limit 1;

select * from movies;

#실습 4-13
select booking_date, title from bookings as a join movies as b on a.movie_id = b.movie_id
where customer_id=2;

#실습 4-14
select 
	c.name,
    c.phone,
    b.booking_date,
    M.title
 from bookings B
 join customers C on B.customer_id =  c.customer_id
 join movies M on B.movie_id = M.movie_id;
#실습 4-15
SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

select 
	M.genre,
    AVG(B.num_tickets) as avg_tickets
from bookings B
join movies M on b.movie_id= M.movie_id
group by genre;

#실습 4-16
select 
	c.name,
    AVG(B.num_tickets) as avg_tickets
from bookings B
join customers C on B.customer_id=c.customer_id
group by name;

#실습 4-17
select 
	c.name,
    sum(B.num_tickets) as `전체 예매 티켓 수`
from bookings B
join customers C on B.customer_id=c.customer_id
group by name;

#실습 4-18
select 
	b.booking_id,
    b.movie_id,
    c.name,
    b.booking_date
from bookings B
join Customers C on b.customer_id = b.customer_id
order by b.booking_date asc
limit 1;

#실습 4-19
select genre,title,release_date
from movies
where (genre, release_date) IN( select genre, Max(release_date) from movies group by genre);
#실습 4-20
select * from movies
where movie_id IN(
	select movie_id from bookings
    where customer_id= (select customer_id from customers where name="김유신")
    );

#실습 4-21
select name,email from customers
where customer_id = (
	select customer_id from bookings 
    group by customer_id
    order by sum(num_tickets) desc
    limit 1
);

#실습 4-22
select * from bookings
where num_tickets > (select avg(num_tickets) from bookings);
#실습 4-23
select 
	m.title , sum(b.num_tickets) as total_tickets
from bookings b
join movies m on b.movie_id=m.movie_id
group by title;

#실습 4-24
select 
	c.name,
    sum(b.num_tickets) as total_tickets,
    avg(b.num_tickets) as avg_tickets
from bookings b
join customers c on b.customer_id = c.customer_id
group by c.customer_id;
#실습 4-25
select 
	c.customer_id,
    c.name,
    c.email,
    sum(b.num_tickets) as `예매 티켓수`
from bookings b
join Customers c on b.customer_id = c.customer_id
group by c.name
order by `예매 티켓수` desc;

#실습 4-26
select
	c.name,
    m.title,
    b.num_tickets,
    b.booking_date
from bookings b
join customers c on b.customer_id = c.customer_id
join movies m on b.movie_id = m.movie_id
order by num_tickets desc;
#실습 4-27
select 
	m.title,
    m.genre,
    sum(b.num_tickets) as `예매 티켓 수`,
    avg(b.num_tickets) as `평균 티켓 수`
from bookings b
join movies m on b.movie_id=m.movie_id
where m.genre="액션"
group by m.title
order by `평균 티켓 수`;

select * from movies where genre="액션";
select * from bookings;
#실습 4-28
select 
	b.customer_id,
    c.name,
    sum(`num_tickets`) as `ticket_total`
from bookings b
join customers c on b.customer_id = c.customer_id
group by c.name
order by `ticket_total` desc;

#실습 4-29
select 
	b.booking_id,
    b.customer_id,
    b.movie_id,
    MaxTickets.max_tickets
from bookings B
join (
	select movie_id , Max(num_tickets) as max_tickets
    from bookings 
    group by movie_id
    )as MaxTickets
on MaxTickets.movie_id = b.movie_id and  b.num_tickets = MaxTickets.max_tickets;

#실습 4-30
select 
	b.booking_id,
    b.customer_id,
    c.name,
    m.title,
    m.genre,
    sum(b.num_tickets) as `예매 티켓 수`
from bookings b
join movies m on M.movie_id = b.movie_id
join customers c on c.customer_id = b.customer_id
group by m.title
having `예매 티켓 수` = (
	select Max(total_tickets)
    from (
			select sum(b2.num_tickets) as total_tickets
            from bookings b2 
            join movies m2 on b2.movie_id= m2.movie_id
            where m2.genre=m.genre
            group by m2.title
		) as selectMAX
)
    order by `예매 티켓 수` desc;
