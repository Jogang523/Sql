-- group by
-- 데이터를 묶어서 그룹을 생성
-- 그룹별로 연산값을 구한다 - 집계함수..
-- 조건을 추가하는 경우 where가 아닌, having을 사용한다..

use sqldb; -- 사용할 database를 지정, 활성화...

select * from usertbl;
select * from buytbl;

-- user별로 총구매금액을 구하시오..
select userid, sum(price*amount) as tot_amt 
	from buytbl
    group by userid;
    
-- user별로 평균구매금액..
select userid, avg(price*amount) as avg_amt 
	from buytbl
    group by userid;
    
-- -- user별로 구매횟수..
select userid, count(price) as count_amt 
	from buytbl
    group by userid;    
    
    
-- 사용자별 총구매금액이 1000이상인 고객의 데이터를 출력... -- error
select userid, sum(price*amount) as tot_amt
	from buytbl
    group by userid
    where tot_amt > 1000;    
    
select userid, sum(price*amount) as tot_amt
	from buytbl
    group by userid
    having tot_amt > 1000;    
    
-- 총구매횟수가 2회를 넘는 고객 데이터를 출력..
select userid, count(price) as count_amt 
	from buytbl
    group by userid
    having count_amt >= 2;  
    

show tables;
show databases;


-- auto_increment : 값을 입력하지 않고 null를 입력하면 자동으로 순서값이 입력된다.. ex> id, 
create table testtbl0(
	id int auto_increment primary key,
    username char(7),
    age int);

insert into testtbl0 values (null, '지민', 25);
insert into testtbl0 values (null, '유나', 27);
insert into testtbl0 values (null, '유경', 33);

select * from testtbl0;    


-- table의 값을 수정...
-- update ~ set ~...
use employees;
show tables;

select * from employees;
select * from employees where first_name = 'aamer';

update employees set last_name='없음' where first_name='aamer';  -- error

-- safe update 해제
use employees;
update employees set last_name='없음' where first_name='aamer';

select * from employees where first_name = 'aamer';

-- sqldb에서 buytbl의 운동화 가격을 20% 상승적용...
use sqldb;
select * from buytbl;
update buytbl set price=price*1.2 where prodname='운동화';
select * from buytbl;


-- table의 데이터를 삭제 : delete

-- first_name이 'Aamer'인 데이터중 10개만 삭제..
use employees;
select * from employees where first_name='Aamer';

# 주의 : delete from employees;

delete from employees where first_name='Aamer' limit 10;

select * from employees where first_name='Aamer';

delete from employees where first_name='Aamer';
    
select * from employees where first_name='Aamer';    