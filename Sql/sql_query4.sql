
create database if not exists mysqladv;
use mysqladv; 

-- view

-- 기존 테이블의 일부만으로 만들어진 꾸며진 테이블
-- 기존 테이블의 일부분에만 접근이 가능하도록 하기 위해서.. 테이블의 일부만을 공유...

-- 1. 보안을 위해서
-- 2. 복잡한 쿼리를 단순화할 수 있다..

use sqldb2;
show tables;

select * from usertbl;

create view v_usertbl
as
	select userid, name, addr from usertbl;
    
select * from v_usertbl;

update v_usertbl set addr='부산' where userid='jkw';
select * from v_usertbl;

select * from usertbl; -- 원본테이블에 반영..

insert into v_usertbl(userid, name, addr) values('kbm', '김병만', '충북');  -- 원본테이블에 birth가 not null인데 view에는 없다..
desc usertbl;

create view v_sum
as 
	select userid, sum(price*amount) as '총구매금액'
    from buytbl group by userid;
    
select * from v_sum;

create view v_height177
as 
	select * from usertbl where height >= 177;
    
select * from v_height177;

insert into v_height177 values('kbm', '김변만', 1977, '경기', '010', '5555555', 158, '2019-01-01');

select * from v_height177;  -- view의 조건에 맞지 않아서 view에 추가가 되지 않음..
select * from usertbl;  -- 원본에는 반영이 됨..

insert into usertbl values ('kki', '김니니', 1988, '서울', '011', '111111', 182, '2019-01-01');  -- 원본에 추가
select * from v_height177;  -- view에 반영...

alter view v_height177
as 
	select * from usertbl where height >= 177
    with check option;  -- 데이터 입력시 view의 조건을 확인..

insert into v_height177 values('kss', '김변만', 1977, '경기', '010', '5555555', 155, '2019-01-01');

drop view if exists v_usertbl;
create view v_usertbl
as 
	select u.userid, u.name, b.prodname, u.addr, concat(u.mobile1, u.mobile2) as mobile
		from usertbl u
			inner join buytbl b
				on u.userid=b.userid;

select * from v_usertbl;

insert into v_usertbl values('pkl', '박경리', '운동화', '경기', '11111111');  -- 두 개 이상의 테이블이 연결된 뷰는 업데이가 되지 않음..


-- index

-- 1. cluster index
-- 데이터를 index 기준으로 정렬
-- 사전방식
-- select 속도는 cluster index가 빠름
-- insert, update 하는 경우 보조인덱스가 효과적임..
-- primary key - 해당 칼럼에 cluster index

-- 2. secondary index
-- 데이터 자체를 정렬하지 않고, 색인인덱스
-- 색인방식
-- select 속도는 cluster index가 빠름
-- insert, update 하는 경우 보조인덱스가 효과적임..
-- unique를 설정, 기타 방식으로 보조인덱스를 설정..

create table tbl1(
a int primary key,  -- cluster index
b int, 
c int);
show index from tbl1;

create table tbl3(
a int unique,  -- secondary index
b int unique,
c int unique,
d int);
show index from tbl3;

create table tbl4(
a int unique not null,  -- cluster index
b int unique,  -- secondary index
d int unique,  -- secondary index
c int);
show index from tbl4;

create table tbl5(
a int unique not null,  -- secondary index
b int unique,  -- secondary index
d int primary key,  -- cluster index
c int);
show index from tbl5







