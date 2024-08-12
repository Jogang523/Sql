
-- 제약조건 (constraints)
-- primary key : null값이 없고, 중복값도 없는 칼럼. 테이블의 모든 데이터를 식별가는하도록 하는 칼럼.
--               최소한 하나 이상의 칼럼에 primary key 를 설정해야..
-- foreign key : 특정 테이블의 칼럼에 다른 테이블의 칼럼 값을 참조하도록.. 데이터의 일치성을 보장
--               기본 칼럼과 참조하는 칼럼 간에 데이터의 정합성이 존재해야 한다..
-- unique : 해당 칼럼에 중복값이 존재해서는 안 됨...
-- not null : null값을 허용하지 않음
-- default : 칼럼 값에 기본값을 설정하는 경우
-- auto_increment : 값을 입력하지 않으면 이전 데이터의 다음 정수값이 자동으로 할당..

-- primary key

-- 1.
drop table if exists usertbl;

create table usertbl (
	userid char(8) not null primary key,
    name varchar(10) not null,
    birthyear int not null,
    addr char(5) not null,
    mobile1 char(3),
    mobile2 char(8),
    height int,
    mdate date);
    
-- 2.
drop table if exists usertbl;

create table usertbl (
	userid char(8) not null,
    name varchar(10) not null,
    birthyear int not null,
    addr char(5) not null,
    mobile1 char(3),
    mobile2 char(8),
    height int,
    mdate date,
    constraint primary key pk_usertbl(userid));
    
-- desc 테이블명 : 테이블의 구조를 확인..
desc usertbl;

-- 3
drop table if exists usertbl;

create table usertbl (
	userid char(8) not null,
    name varchar(10) not null,
    birthyear int not null,
    addr char(5) not null,
    mobile1 char(3),
    mobile2 char(8),
    height int,
    mdate date);
    
desc usertbl;

alter table usertbl
	add constraint pk_userid
    primary key (userid);
    
desc usertbl;

-- unique 

drop table if exists usertbl;

create table usertbl (
	userid char(8) not null,
    name varchar(10) not null,
    birthyear int not null,
    addr char(5) not null,
    mobile1 char(3),
    mobile2 char(8),
    height int,
    mdate date);

desc usertbl;

insert into usertbl values ('lsg', '이승기', 1987, '서울', '011', '88888888', 182, '2008-01-01');
insert into usertbl values ('kbs', '김병수', 1977, '인천', '011', '77777778', 176, '2008-01-01');
insert into usertbl values ('lsg', '이승기', 1987, '서울', '011', '88888888', 182, '2008-01-01'); -- error

select * from usertbl;

alter table usertbl  -- error
	add constraint uq_userid
    unique (userid);
 
-- ---------------------------------------
    
drop table if exists usertbl;

create table usertbl (
	userid char(8) unique not null,
    name varchar(10) not null,
    birthyear int not null,
    addr char(5) not null,
    mobile1 char(3),
    mobile2 char(8),
    height int,
    mdate date);

desc usertbl;

insert into usertbl values ('lsg', '이승기', 1987, '서울', '011', '88888888', 182, '2008-01-01');
insert into usertbl values ('kbs', '김병수', 1977, '인천', '011', '77777778', 176, '2008-01-01');
insert into usertbl values ('lsg', '이승기', 1987, '서울', '011', '88888888', 182, '2008-01-01'); -- error

select * from usertbl;    


-- default : 칼럼에 초기값 설정

drop table if exists usertbl

create table usertbl(
	userid char(8) not null,
    name varchar(10),
    birthyear int not null default -1,
    addr char(2) not null default '서울',
    height int default 170,
    mdate date);
    
insert into usertbl values ( null, '김민호', 1975, '서울', 177, '2020-02-02');  -- error

insert into usertbl values ( 'lhl', '이채리', default, default, 180, '2020-02-02');

insert into usertbl values ('sjs', '김장수', '1998-01-01'); -- error
-- 칼럼값을 입력 시 순서가 바뀌거나 빠는 칼럼값이 존재하면 반드시 칼럼명을 명시해야 함...
insert into usertbl (userid, name, mdate) values ('sjs', '김장수', '1998-01-01');

select * from usertbl;

-- alter table

alter table usertbl	
	add homepage varchar(30)
    default 'http://www.naver.com' 
    null;
    
select * from usertbl;

alter table usertbl
	drop column homepage;

select * from usertbl;

alter table usertbl	
	change column name uname varchar(30) null;
    
select * from usertbl;

desc usertbl;

alter table usertbl add constraint pk_userid primary key (userid);

desc usertbl;


-- 외래키 제약조건 : foreign key contraints

drop database if exists tabledb;

create database tabledb;

use tabledb;


create table usertbl (
userid char(8) not null primary key,
name varchar(10) not null,
birthyear int not null,
addr char(2) not null,
mobile1 char(3),
mobile2 char(8),
height int,
mdate date);

create table buytbl(
num int auto_increment not null primary key,
userid char(8) not null,
prodname char(6) not null,
groupname char(4),
price int not null,
amount int not null);

show tables;

-- buytbl의 userid칼럼에 usertbl의 userid 칼럼을 참조하도록 외래키 제약조건을 설정
alter table buytbl add constraint fk_userid foreign key(userid) references usertbl(userid);


-- 외래키 설정
-- 기본키는 usertbl의 userid칼럼, 참조테이블 buytbl userid칼럼
-- usertbl의 userid와 buytbl의 userid칼럼 간의 데이터의 일치성이 유지되어야 한다..
-- usertbl은 삭제할 수 없음 - 다름 테이블에서 참조하고 있으므로
-- usertbl의 userid의 값을 수정할 수없다..
-- buytbl은 usertbl에 없는 userid 데이터를 추가할 수 없음...

insert into usertbl values ('lsg', '이승기', 1987, '서울', '011', '1111111', 182, '2020-02-02');
insert into usertbl values ('kbs', '김병수', 1987, '서울', '011', '1111111', 182, '2020-02-02');
insert into usertbl values ('kkh', '김기호', 1987, '서울', '011', '1111111', 182, '2020-02-02');

select * from usertbl;

insert into buytbl values(null, 'lsg', '모니터', '전자', 200, 3);
insert into buytbl values(null, 'kbs', '자전거', '스포츠', 200, 3);
insert into buytbl values(null, 'jyp', '노트북', '전자', 200, 3);  -- error, 기본테이블에 없는 데이터를 입력할 수 없음...

select * from buytbl;

update usertbl set userid = 'mbc' where userid='kbs';  -- error, 참조받는 칼럼의 값을 수정할 수 없음..

drop table usertbl;  -- error, 참조받는 테이블은 삭제할 수 없음..

select * from information_schema.table_constraints where table_name ='buytbl';  -- 테이블의 제약조건들을 확인

alter table buytbl drop foreign key fk_userid; -- 외래키를 제거

insert into buytbl values(null, 'jyp', '노트북', '전자', 200, 3);  -- success
select * from buytbl;

update usertbl set userid = 'mbc' where userid='kbs';  -- success
select * from usertbl;

drop table if exists usertbl; -- success
show tables;



-- on update cascade  : update내용을 다른 table에 반영
-- on delete cascade  : 삭제된 내용을 다른 table에 반영

drop table if exists usertbl;
drop table if exists buytbl;

create table usertbl (
userid char(8) not null primary key,
name varchar(10) not null,
birthyear int not null,
addr char(2) not null,
mobile1 char(3),
mobile2 char(8),
height int,
mdate date);

create table buytbl(
num int auto_increment not null primary key,
userid char(8) not null,
prodname char(6) not null,
groupname char(4),
price int not null,
amount int not null);

alter table buytbl 
	add constraint foreign key(userid) references usertbl(userid)
    on update cascade;
    
insert into usertbl values ('lsg', '이승기', 1987, '서울', '011', '1111111', 182, '2020-02-02');
insert into usertbl values ('kbs', '김병수', 1987, '서울', '011', '1111111', 182, '2020-02-02');
insert into usertbl values ('kkh', '김기호', 1987, '서울', '011', '1111111', 182, '2020-02-02');    

insert into buytbl values(null, 'lsg', '모니터', '전자', 200, 3);
insert into buytbl values(null, 'kbs', '자전거', '스포츠', 200, 3);

select * from usertbl;
select * from buytbl;

-- usertbl의 userid를 수정
update usertbl set userid='mbc' where userid='kbs';

select * from usertbl;
select * from buytbl; -- usertbl 수정내용이 buytbl에 반영됨

delete from usertbl where userid='mbc';  -- error, 참조받는 테이블의 데이터를 수정 삭제가 안 됨...

-- ----------------------------------

# select * from information_schema.table_constraints where table_name ='buytbl';
# alter table buytbl drop foreign key buytbl_ibfk_1;

drop table if exists usertbl;
drop table if exists buytbl;

create table usertbl (
userid char(8) not null primary key,
name varchar(10) not null,
birthyear int not null,
addr char(2) not null,
mobile1 char(3),
mobile2 char(8),
height int,
mdate date);

create table buytbl(
num int auto_increment not null primary key,
userid char(8) not null,
prodname char(6) not null,
groupname char(4),
price int not null,
amount int not null);

alter table buytbl 
	add constraint foreign key(userid) references usertbl(userid)
    on update cascade
    on delete cascade;
    
insert into usertbl values ('lsg', '이승기', 1987, '서울', '011', '1111111', 182, '2020-02-02');
insert into usertbl values ('kbs', '김병수', 1987, '서울', '011', '1111111', 182, '2020-02-02');
insert into usertbl values ('kkh', '김기호', 1987, '서울', '011', '1111111', 182, '2020-02-02');    

insert into buytbl values(null, 'lsg', '모니터', '전자', 200, 3);
insert into buytbl values(null, 'kbs', '자전거', '스포츠', 200, 3);

-- usertbl의 userid를 수정
update usertbl set userid='mbc' where userid='kbs';
select * from usertbl;
select * from buytbl;

-- usertbl의 데이터 삭제
delete from usertbl where userid='lsg'; -- usertbl에서 userid가 lsg인 데이터를 삭제하고, 참조하는 테이블 buytbl에도 반영된다..

select * from usertbl;
select * from buytbl;