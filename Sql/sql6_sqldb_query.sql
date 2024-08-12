drop database if exists sqldb1;

create database sqldb1;

use sqldb1;

create table usertbl (
userid char(8) not null primary key,
name varchar(10) not null,
birthyear int not null,
addr char(2) not null,
mobile1 char(3),
mobile2 char(8),
height int,
mdate date);

insert into usertbl values('lsg', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
insert into usertbl values('kbs', '김범수', 1979, '경남', '011', '2221111', 173, '2012-4-4');
insert into usertbl values('kkh', '김경호', 1979, '전남', '011', '3333333', 177, '2008-7-7');
insert into usertbl values('jyp', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
insert into usertbl values('ssk', '성시경', 1979, '서울', null, null, 187, '2013-12-12');
insert into usertbl values('ljb', '임재범', 1963, '서울', '016', '1111111', 182, '2009-9-9');
insert into usertbl values('yjs', '윤종신', 1969, '경남', null, null, 170, '2005-5-5');
insert into usertbl values('ejw', '은지원', 1972, '경북', '011', '1111111', 174, '2014-3-3');
insert into usertbl values('jkw', '조관우', 1965, '경기', '011', '1111111', 172, '2010-10-10');
insert into usertbl values('bbk', '바비킴', 1973, '서울', '011', '1111111', 176, '2013-7-7');

create table buytbl(
num int auto_increment not null primary key,
userid char(8) not null,
prodname char(6) not null,
groupname char(4),
price int not null,
amount int not null);

insert into buytbl values
(null, 'kbs', '운동화', null, 30, 2),
(null, 'kbs', '노트북', '전자', 30, 1),
(null, 'jyp', '모니터', '전자', 1000, 1),
(null, 'bbk', '모니터', '전자', 200, 5),
(null, 'kbs', '청바지', '의류', 200, 3),
(null, 'bbk', '메모리', '전자', 50, 10),
(null, 'ssk', '책', '서적', 80, 5),
(null, 'ejw', '책', '서적', 15, 2),
(null, 'ejw', '청바지', '의류', 15, 1),
(null, 'bbk', '운동화', null, 50, 2),
(null, 'ejw', '책', '서적', 30, 1),
(null, 'lsg', '운동화', null, 30,2);