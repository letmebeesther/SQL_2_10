--output 매개변수
create proc p11
@이름 char(20), @점수 int output
as
select @점수=점수
from 성적
where 이름=@이름

declare @점수 int
exec p11 '김태희', @점수 output
select @점수 점수

--return 매개변수 (return값은 반드시 int 타입)
create proc rt
@name char(20)
as
declare @grd int
select @grd=점수
from 성적
where 이름=@name
return @grd

declare @a int
exec @a = rt '김태희'
select @a

-- 12. return 값이 있는 프로시저 생성1
-- 제품 테이블에서 해당 제품의 종류를 입력받아 
--이 제품의 개수를 결과로 반환하도록 프로시저를 생성하시오.
--( return 사용)
select* from 제품

create proc p13
@종류 char(20)
as
declare @cnt int
select @cnt=count(*)
from 제품
where 종류=@종류
return @cnt

declare @cnt int
exec @cnt = p13 '코트'
select @cnt

-- 행의 개수 카운팅 @@ROWCOUNT
select* from 성적
where 점수>= 90
select @@ROWCOUNT

select* from 성적
where 점수>= 95
select @@ROWCOUNT

select 제품명, 가격, 가격*1.1 인상가격
from 제품
where 종류='셔츠'
select @@ROWCOUNT

--13. return 값이 있는 프로시저 생성2
-- 테이블 ‘제품’에서 매개변수 값 ‘종류’의 값에 따라 
-- 제품의 가격을 10%인상하는 프로시저를 생성하시오. 
-- 이때, return 결과는 몇 개의 레코드가 인상적용 되었는지 개수를 출력하세요.
-- 참고) select @@rowcount (sql문이 적용된 레코드갯수)
create proc ro
@종류 char(20)
as
select 제품명, 종류, 가격, 가격*1.1 인상가격
from 제품
where 종류=@종류
return @@ROWCOUNT

declare @cnt int
exec @cnt = ro '셔츠'
if @cnt=0 select '인상된 제품이 없습니다.'
else select '인상된 제품이 있습니다.'
select @cnt

-- 트리거
create trigger trg1
on 회원1
after insert --insert, update, delete
as
begin
	print 'hello world !'
end

create table 회원1
(이름 char(20))

insert 회원1 values('홍길동')

--메모리안에 임시테이블이 생성(only 1개 레코드)
--임시 테이블의 명칭 : inserted

alter trigger trg1
on 회원1
after insert
as
begin 
	select* from inserted
end

insert 회원1 values('김선달'), ('홍길동')

alter trigger trg1
on 회원1
after insert
as
begin 
	select 이름+'님 반가워요!' from inserted
end

insert 회원1 values('에스더')

USE tempdb
 -- 모의고사 테이블 생성
 CREATE TABLE 성적
  (
  학번 CHAR(5) NOT NULL,
  영어 INT NOT NULL,
  수학 INT NOT NULL,
  국어 INT NOT NULL,
  총점 INT DEFAULT  0,
  평균 INT DEFAULT 0
  )

--1. AFTER insert 트리거 문제1
-- AFTER insert 트리거로 동작하는 예제를 실습해보자. 
-- 하나의 테이블을 기반으로 하는 INSERT 트리거이다. 
-- 위의 내역에 따라 모의고사테이블을 만들고 
-- 학번, 국어, 영어, 수학 값을 입력하면 
-- 자동적으로 총점과 평균이 입력되도록 트리거를 생성하시오.

create trigger grd
on 성적
after insert
as
begin
	update 성적 set 총점=영어+수학+국어
	update 성적 set 평균=총점/3
	select * from 성적
end

insert 성적(학번, 영어, 수학, 국어) values(3,66,55,100)

select sum(영어+수학+국어) from 성적

drop table 성적
