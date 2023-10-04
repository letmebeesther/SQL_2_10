--output �Ű�����
create proc p11
@�̸� char(20), @���� int output
as
select @����=����
from ����
where �̸�=@�̸�

declare @���� int
exec p11 '������', @���� output
select @���� ����

--return �Ű����� (return���� �ݵ�� int Ÿ��)
create proc rt
@name char(20)
as
declare @grd int
select @grd=����
from ����
where �̸�=@name
return @grd

declare @a int
exec @a = rt '������'
select @a

-- 12. return ���� �ִ� ���ν��� ����1
-- ��ǰ ���̺��� �ش� ��ǰ�� ������ �Է¹޾� 
--�� ��ǰ�� ������ ����� ��ȯ�ϵ��� ���ν����� �����Ͻÿ�.
--( return ���)
select* from ��ǰ

create proc p13
@���� char(20)
as
declare @cnt int
select @cnt=count(*)
from ��ǰ
where ����=@����
return @cnt

declare @cnt int
exec @cnt = p13 '��Ʈ'
select @cnt

-- ���� ���� ī���� @@ROWCOUNT
select* from ����
where ����>= 90
select @@ROWCOUNT

select* from ����
where ����>= 95
select @@ROWCOUNT

select ��ǰ��, ����, ����*1.1 �λ󰡰�
from ��ǰ
where ����='����'
select @@ROWCOUNT

--13. return ���� �ִ� ���ν��� ����2
-- ���̺� ����ǰ������ �Ű����� �� ���������� ���� ���� 
-- ��ǰ�� ������ 10%�λ��ϴ� ���ν����� �����Ͻÿ�. 
-- �̶�, return ����� �� ���� ���ڵ尡 �λ����� �Ǿ����� ������ ����ϼ���.
-- ����) select @@rowcount (sql���� ����� ���ڵ尹��)
create proc ro
@���� char(20)
as
select ��ǰ��, ����, ����, ����*1.1 �λ󰡰�
from ��ǰ
where ����=@����
return @@ROWCOUNT

declare @cnt int
exec @cnt = ro '����'
if @cnt=0 select '�λ�� ��ǰ�� �����ϴ�.'
else select '�λ�� ��ǰ�� �ֽ��ϴ�.'
select @cnt

-- Ʈ����
create trigger trg1
on ȸ��1
after insert --insert, update, delete
as
begin
	print 'hello world !'
end

create table ȸ��1
(�̸� char(20))

insert ȸ��1 values('ȫ�浿')

--�޸𸮾ȿ� �ӽ����̺��� ����(only 1�� ���ڵ�)
--�ӽ� ���̺��� ��Ī : inserted

alter trigger trg1
on ȸ��1
after insert
as
begin 
	select* from inserted
end

insert ȸ��1 values('�輱��'), ('ȫ�浿')

alter trigger trg1
on ȸ��1
after insert
as
begin 
	select �̸�+'�� �ݰ�����!' from inserted
end

insert ȸ��1 values('������')

USE tempdb
 -- ���ǰ�� ���̺� ����
 CREATE TABLE ����
  (
  �й� CHAR(5) NOT NULL,
  ���� INT NOT NULL,
  ���� INT NOT NULL,
  ���� INT NOT NULL,
  ���� INT DEFAULT  0,
  ��� INT DEFAULT 0
  )

--1. AFTER insert Ʈ���� ����1
-- AFTER insert Ʈ���ŷ� �����ϴ� ������ �ǽ��غ���. 
-- �ϳ��� ���̺��� ������� �ϴ� INSERT Ʈ�����̴�. 
-- ���� ������ ���� ���ǰ�����̺��� ����� 
-- �й�, ����, ����, ���� ���� �Է��ϸ� 
-- �ڵ������� ������ ����� �Էµǵ��� Ʈ���Ÿ� �����Ͻÿ�.

create trigger grd
on ����
after insert
as
begin
	update ���� set ����=����+����+����
	update ���� set ���=����/3
	select * from ����
end

insert ����(�й�, ����, ����, ����) values(3,66,55,100)

select sum(����+����+����) from ����

drop table ����
