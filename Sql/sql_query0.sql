
-- 한 줄 주석

/*
여러 줄 주석
여러 줄 주석
*/

-- use database이름;
-- select 컬럼명, ... from 테이블이름;
-- select 컬럼명, ... from 테이블이름 where 조건;

-- shopdb...

drop database shopdb;

create database shopdb;

use shopdb;

create table membertbl
(memberid char(5) primary key,
membername char(5),
memberaddress varchar(20));

insert into membertbl values('dang', '당당이', '경기도 부천시 중동');
insert into membertbl values('han', '한국진', '인천시 남구 주안동');
insert into membertbl values('joe', '지운이', '서울시 은평구 중동');
insert into membertbl values('sang', '상길이', '경기도 성남시 분당구');

select * from membertbl;

create table producttbl
(productname char(5) primary key,
price int,
makedate date,
company char(5),
amount int);

insert into producttbl values('냉장고', 5, '2019-03-01', '대우', 23);
insert into producttbl values('세탁기', 20, '2014-09-01', 'LG', 3);
insert into producttbl values('컴퓨터', 10, '2013-01-01', '삼성', 17);

select * from producttbl;

select memberid, memberaddress from membertbl;

select productname, amount from producttbl;

select * from producttbl where company='삼성';
select * from producttbl where amount < 5;

select * from membertbl where memberaddress = '인천시 남구 주안동';

# 재고 총 금액이 100 이상인 제품의 목록을 출력...
select * from producttbl where price*amount > 100;

select productname from producttbl order by makedate limit 1;

# 대우에서 제조한 제품의 재고는 얼마나 남아있는가?
select amount from producttbl where company='대우';


# sqldb를 생성...

drop database if exists sqldb;
create database sqldb;
use sqldb;

create table usertbl (
	userid char(8) not null primary key,
    name varchar(10) not null,
    birthyear int not null,
    addr char(5) not null,
    mobile1 char(3),
    mobile2 char(8),
    height int,
    mDate date);
    
create table buytbl (
	num int auto_increment not null primary key,
    userid char(8) not null,
    prodname char(6) not null,
    groupname char(4),
    price int not null,
    amount int not null);
    
insert into usertbl values('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
select * from usertbl;
insert into usertbl values('kbs', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
insert into usertbl values('kkh', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
insert into usertbl values('jyp', '조용필', 1950, '경기', '011', '4444444', 166, '2009-7-7');
insert into usertbl values('ssk', '성시경', 1979, '서울', null, null, 186, '2013-12-12');
insert into usertbl values('ljb', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
insert into usertbl values('yjs', '윤종신', 1969, '경남', null, null, 170, '2014-3-3');
insert into usertbl values('ejw', '은지원', 1972, '경북', '011', '9999999', 172, '2010-10-10');
insert into usertbl values('jkw', '조관우', 1965, '경기', '018', '8888888', 176, '2010-10-10');
insert into usertbl values('bbk', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');

select * from usertbl;

insert into buytbl values(null, 'kbs', '운동화', null, 30, 2);
insert into buytbl values(null, 'kbs', '노트북', '전자', 1000, 1);
insert into buytbl values(null, 'jyp', '모니터', '전자', 200, 1);
insert into buytbl values(null, 'bbk', '모니터', '전자', 200, 5);
insert into buytbl values(null, 'kbs', '청바지', '의류', 50,5);
insert into buytbl values(null, 'bbk', '메모리', '전자', 80, 10);
insert into buytbl values(null, 'ssk', '책', '서적', 15, 5);
insert into buytbl values(null, 'ejw', '책', '서적', 15, 2);
insert into buytbl values(null, 'ejw', '청바지', '의류', 50, 1);
insert into buytbl values(null, 'bbk', '운동화', null, 30, 2);
insert into buytbl values(null, 'ejw', '운동화', '서적', 15, 1);
insert into buytbl values(null, 'bbk', '운동화', null, 30, 2);

select * from usertbl;
select * from buytbl;

-- 김경호라는 가수의 데이터를 출력
select * from usertbl where name='김경호';
-- 출생년도가 1970년 이후이고, 키가 182 이상인 사람alter
select * from usertbl where birthyear >= 1970 and height >= 182;
-- 출생년도가 1970년 이후이거나, 키가 182 이상인 사람의 이름
select * from usertbl where birthyear >= 1970 or height >= 182;
-- 키가 180이상이고 183 이하인 사람..
select * from usertbl where height >= 180 and height <= 183;
select * from usertbl where height between 180 and 183;
-- 임재범 보다 나이가 많은 사람의 데이터
select 2024-birthyear from usertbl where name='임재범';
select * from usertbl where 2024-birthyear > 61;

-- subquery
select * from usertbl where 2024-birthyear > 
	(select 2024-birthyear from usertbl where name='임재범');
    
-- 김범수와 동일 지역 출신인 사람... subquery
select addr from usertbl where name = '김범수';
select * from usertbl where addr='경남';

select * from usertbl where addr=(select addr from usertbl where name = '김범수');


use employees;
-- employees database에서 employees table에서 여성의 데이터만 출력하시오.
show tables;
select * from employees where gender='f';
-- employees table에서 '1960'년 이후에 출생한 사람의 사번을 출력하시아...
select * from employees where birth_date > '1960-01-01';
-- 연봉이 $100000 이상인 직원의 사번을 출력하시오....
show tables;
select emp_no,salary from salaries where salary >= 100000;

select * from titles;
-- titles table에서 퇴직한 직원들의 emp_no을 출력하시오..
select emp_no from titles where to_date < '9999-01-01';
-- 퇴직한 직원의 수..
select count(emp_no) from titles where to_date < '9999-01-01';
-- 입사한 날짜가 1990년 이전이면서 현재 engineer인 사람의 데이터를 출력..
show tables;
select * from titles where title='engineer' and from_date < '1990-01-01';
-- title의 종류를 출력
select distinct title from titles;


--  sqldb
use sqldb;
show tables;

-- 경남에 사는 사람보다 키가 큰 사람의 데이터를 출력
select * from usertbl where addr='경남';
select * from usertbl where height > 173;

select * from usertbl where height > (select height from usertbl where addr='경남');  -- error, 복수값 비교, 경남에 사는 사람이 여러명 이라서 오류
select * from usertbl where height > any(select height from usertbl where addr='경남');  -- 최소크기만족
select * from usertbl where height > all(select height from usertbl where addr='경남');  -- 최대크기만족

-- 경남에 사는 사람과 키가 같은 사람의 데이터를 출력...
select * from usertbl where height = (select height from usertbl where addr='경남');  -- error, 복수값 비교
select * from usertbl where height in (select height from usertbl where addr='경남');  --

-- 텍스트 검색 : like

-- 성이 '김'인 사람..
select * from usertbl where name like '김%'; -- % : 모든 문자 (시작 기준)

-- 이름이 '종신'인 성이 한 글자인 사람...
select * from usertbl where name like '_종신'; -- _ : 하나의 문자

-- 출생일을 기준으로 올림차순 정렬 출력..
select * from usertbl order by birthyear;

-- 출생일을 기준으로 내림차순 정렬 출력...
select * from usertbl order by birthyear desc;

-- 키가 큰 사람 상위 2인
select * from usertbl order by height desc limit 2;

-- 나이가 어린 사람 상위 2인
select * from usertbl order by birthyear desc limit 2;

-- 구매자의 id를 중복없이 출력...
select distinct userid from buytbl;

-- Mysql 내장함수...

-- cast : 데이터의 타입을 변경
select cast('2020-10-19 12:35:29:123' as date) as 'Date';
select cast('2020-10-19 12:35:29:123' as time) as 'Time';
select cast('2020-10-19 12:35:29:123' as datetime) as 'DateTime';

-- concat : 문자열을 이어준다
select concat('100', '200');
select concat('hello ', 'python');

select num, concat(cast(price as char(10)), 'x', cast(amount as char(10)), '=') as '가격x구매액',
price*amount as '총구매액' from buytbl;

-- concat_ws : 문자열을 구분자로 붙여서 이어주는 함수..
select concat_ws('/', '2020', '01', '01') as '날짜';

-- ifnull(요소1, 요소2) 
select ifnull(null, 'python'); -- 요소1이 null 이면 요소2 python을 출력해라
select ifnull('java', 'python'); -- 요소1이 java aus java를 출력해라

-- insert('문자열1', index, length, '문자열2');
select insert('abcdefghi', 3, 4, '@@@@');
select insert('abcdefghi', 3, 2, '@@@@');

-- left('문자열', num) : 문자열 왼쪽 num개를 리턴
-- right('문자열', num) : 문자열 오른쪽 num개를 리턴
select left('abcdefghi', 3);
select right('abcdefghi', 3);

-- repeat('문자열', num) : 문자열을 num번 반복
select repeat('abc', 5);

-- 변수
set @myvar1 = 5;
set @myvar2 = 3;
set @myvar3 = 3.14;
set @myvar4 = '가수 이름 =>';

select @myvar1;
select @myvar1 + @myvar2;

select @myvar4, name from usertbl where height>180;

-- prepare 이름 from query
prepare myquery -- 쿼리문 저장
	from 'select name, height from usertbl order by height';
execute myquery; -- 저장된 쿼리문 실행

set @myvar1 = 3;
prepare myquery1
	from 'select name, height from usertbl order by height limit ?';
execute myquery1 using @myvar1;

select if(100>200, 1, 0); -- 삼항 연산자
select if(100<200, 1, 0);

-- ascii(문자) : 문자에 해당하는 ascii값
select ascii('a');
select char(97); -- ? 

-- bit_length: bit수, char_length:문자의 길이, length:byte크기
select bit_length('abc'), char_length('abc'), length('abc');
select bit_length('가나다'), char_length('가나다'), length('가나다');

select lower('abcdEFG');
select upper('abcdEFG');

select lpad('이것이', 5, '##');
select rpad('이것이', 5, '##');

select replace('이것이 mysql이다', '이것이', 'this is');

select reverse('mysql');

select substring_index('cafe.naver.com', '.', 2);
select substring('대한민국만세', 3, 2);
select substring('대한민국만세', 2, 3);

select abs(-1);
select ceiling(4.2), floor(4.7), round(4.7);

select mod(157, 10), 157%10, 157 mod 10;

select truncate(12345.565656, 2); -- 소수점 2자리까지만
select truncate(12345.565656, -2); -- 실수 2자리까지만 나머지는 0처리

select adddate('2020-01-01', interval 31 day);
select adddate('2020-01-01', interval 1 month);

select subdate('2020-01-01', interval 31 day);
select subdate('2020-01-01', interval 1 month);

select addtime('2020-01-01 23:59:59', '1:1:1');
select subtime('2020-01-01 23:59:59', '1:1:1');

select curdate();
select year(curdate());
select month(curdate());
select dayofmonth(curdate());

select current_time();
select hour(current_time());
select minute(current_time());
select second(current_time());
select microsecond(current_time());

select datediff('2020-01-01', now());
select timediff('23:23:59', '12:11:10');

select last_day(curdate());

select makedate(2020, 55);

select maketime(12, 11, 10);

select period_add(202001, 5);
select period_diff(202001, 201812); -- 개월 차이 계산

select quarter('2020-07-07'); -- 분기

select time_to_sec('12:11:10');

-- ----------------
use sqldb;

create table maxtbl (col1 longtext, col2 longtext); -- 컬럼하나에 4기가를 할당 할 수 있음

insert into maxtbl values(repeat('a', 1000000), repeat('가', 1000000)); -- a,가 백만번 반복
select * from maxtbl;

insert into maxtbl values(repeat('a', 100000000), repeat('가', 100000000)); -- error
select * from maxtbl;

# my.ini
# max_allowed_packet = 500M


-- ------------------------
select * from usertbl;

select * into outfile 'c:/temp/usertbl.txt' from usertbl;

create table usertbl1 like usertbl;  -- usertbl과 동일한 구조를 가진 usertbl1을 생성
load data infile 'c:/temp/usertbl.txt' into table usertbl1;

select * from usertbl1;

-- ------------------


### MySql Datatype

/*
1. 문자열
char(num) : num 크기의 문자열을 저장할 수 있도록 고정
varchar(num) : num 크기보다 작은 문자열이 들어오면 문자열 크기에 맞춰서 저장공간의 크기를 줄인다. 
               장-memory 용량 절약, 단-속도가 느림
text : 최대 65535 바이트를 저장
longtext : 최대 42994967295 바이트 저장 (4기가)

2. 숫자
int : -2147483648 ~ 2147483648
float : -3.10282+38e ~ 3.10282+38e

3. 날짜형
date : 년월일
time : 시분초
datetime : 년월일 시분초
*/


### join : table을 병합하는 것 (pandas : merge)
-- inner join : 테이블 간에 공통으로 존재하는 데이터들로 테이블을 합하는 방법
-- left join : 왼쪽 테이블의 데이터는 모두 포함하고, 오른쪽 테이블의 데이터는 왼쪽 데이블에 존재하는 데이터들만 포함
-- right join : 오른쪽 테이블의 데이터는 모두 포함하고, 왼쪽 테이블의 데이터는 오른쪽 데이블에 존재하는 데이터들만 포함
-- outer join : 양 테이블 중 어느 한 쪽에 존재하는 데이터는 모두 포함..

select * from usertbl;
select * from buytbl;

-- inner join

select * from buytbl inner join usertbl
	on buytbl.userid = usertbl.userid;
    
select * from buytbl as b inner join usertbl as u
	on b.userid = u.userid;
    
select * from buytbl b inner join usertbl u
	on b.userid = u.userid;
    
select * from buytbl b, usertbl u -- where구문은 inner join에서만 가능..
	where u.userid=b.userid;
    
-- 조용필이 구매한 제품의 이름과 조용필의 전화번호를 출력...
select prodname, mobile1, mobile2 from buytbl b inner join usertbl u
	on b.userid = u.userid
    where name='조용필';

-- 모니터를 구매한 사람들의 이름과 연락처...
select name, addr from buytbl b inner join usertbl u
	on b.userid = u.userid
    where prodname='모니터';

-- 전화번호가 없는 고객의 이름과 주소..
select name, addr from usertbl where mobile1 is null;

-- 총구매금익이 가장 큰 고객의 이름과 주소, 총구매금액..
select * from buytbl b inner join usertbl u
	on b.userid = u.userid;

select b.userid, sum(price*amount) as total_amt from buytbl b inner join usertbl u
	on b.userid = u.userid
    group by b.userid
    order by total_amt desc
    
    limit 1;


use sqldb;

-- left join
select * from buytbl b left join usertbl u		
	on u.userid = b.userid;

-- right join
select * from buytbl b right join usertbl u
	on u.userid = b.userid;


-- table 3개 join

create table stdtbl(
	stdname varchar(10) not null primary key,
    addr char(4) not null);
    
create table clubtbl(
	clubname varchar(10) not null primary key,
    roomno char(5) not null);
    
create table stdclubtbl(
	num int auto_increment not null primary key,
    stdname varchar(10) not null,
    clubname varchar(10) not null);
    
insert into stdtbl values
	('김범수', '경남'),
    ('성시경', '서울'),
    ('조용필', '경기'),
    ('은지원', '경북'),
    ('바비킴', '서울');
select * from stdtbl;

insert into clubtbl values
	('수영', '101호'),
    ('바둑', '102호'),
    ('축구', '103호'),
    ('봉사', '104호');
select * from clubtbl;

insert into stdclubtbl values
	(null, '김범수', '바둑'),
    (null, '김범수', '축구'),
    (null, '조용필', '축구'),
    (null, '은지원', '축구'),
    (null, '은지원', '봉사'),
    (null, '바비킴', '봉사');
select * from stdclubtbl;

select * from stdtbl;
select * from clubtbl;
select * from stdclubtbl;

-- 축구부에 가입한 학생의 주소, 학생이름와 클럽 주소를 출력를...
select * from stdtbl s inner join stdclubtbl sc on s.stdname = sc.stdname
					   inner join clubtbl c on sc.clubname = c.clubname;
                       
select * from stdtbl s, clubtbl c, stdclubtbl st
		 where s.stdname = st.stdname and st.clubname = c.clubname;
         
select * from stdtbl s, clubtbl c, stdclubtbl st
		 where s.stdname = st.stdname and st.clubname = c.clubname
			   and c.clubname='축구';
               
select s.stdname, addr, roomno from stdtbl s, clubtbl c, stdclubtbl st
		 where s.stdname = st.stdname and st.clubname = c.clubname
			   and c.clubname='축구';
			         
select s.stdname, addr, roomno from stdtbl s inner join stdclubtbl sc on s.stdname = sc.stdname
					   inner join clubtbl c on sc.clubname = c.clubname
					   where s.stdname = sc.stdname and sc.clubname = c.clubname
			           and c.clubname='축구';
                       

					
                    
-- 조건문 : if구문/ case when구문

use sqldb;

drop procedure if exists ifproc;  -- 동일한 이름의 procedure 삭제

-- delimiter 수정
delimiter $$  

create procedure ifproc()   -- ifproc procedure 생성, 함수기능..

-- procedure 시작
begin  
	declare var1 int;
    set var1 = 100;
    
    if var1 = 100 then 
		select '100입니다';
	else
		select '100이 아닙니다';
	end if;
   
-- procedure 종료
end $$  

-- delimiter 수정
delimiter ;

call ifproc();

-- ----------

drop procedure if exists caseproc;

delimiter $$

create procedure caseproc()

-- procedure 시작
begin
	declare point int;
    declare credit char(10);
    set point = 77;
    
    -- case when 조건문 시작
    case 
    when point >= 90 then
		set credit ='A';
	when point >= 80 then
		set credit ='B';
	when point >= 70 then
		set credit ='C';
	when point >= 60 then
		set credit ='D';
	else
		set credit ='F';
	end case;
    -- 여기까지 case when 조건문 종료
    
    -- 출력
    select concat('취득점수 :', point), concat('학점 :', credit);    
    
-- procedure 종료
end $$

-- delimiter 재수정
delimiter ;

-- procedure 호출... 
call caseproc();

-- --------------------------  

-- 기존의 procedure가 있으면 삭제...
drop procedure if exists whileproc;

-- delimiter 수정
delimiter $$

-- procedure 생성
create procedure whileproc()
begin
	declare i int;
    declare hap int;
    set i=1;
    set hap=0;
    
    -- 반복문의 시작
    while(i<=100) do
		set hap = hap + i;
		set i = i+1;
	end while;
    -- 여기까지 반복문의 종료
    
    -- 값출력
    select hap;
    
-- procedure 종료
end $$

-- delimiter 복구
delimiter ;

-- whileproc 호출...
call whileproc();


