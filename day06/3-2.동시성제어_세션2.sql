-- 세션2
select @@autocommit;

set autocommit = 0;

-- start TRANSACTION;

UPDATE accounts
   SET balance = balance - 1500
 WHERE id = 3;

SELECT * FROM accounts;

commit;

-- 다른세션에서 다른 데이터를 수정
UPDATE accounts
   SET balance = balance - 500
 WHERE id = 3;

 -- Non-Repeatable Read

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

update accounts
  set balance = 25000
 where id = 1;


SELECT * FROM accounts;

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

 commit;

-- 팬텀 리드 세션 2

insert into employees(name, salary) values ('Dread', 6500);

SELECT * FROM employees WHERE salary >= 5000;
commit;

ROLLBACK;

-- DeadLock
-- Autocommit 해제
select @@autocommit;
set autocommit = 0;

select * from employees;

-- 6번 id 급여를 8000으로 변경
UPDATE employees
   set salary = 8000
 where id = 6;

-- 다른 세션의 5번 id 급여를 100증가
UPDATE employees
   set salary = salary + 100
 where id = 5;

Update accounts
   set balance = 7000
where id = 2;

-- 테이블 락
SELECT * FROM accounts;

update accounts
   SET balance = 9000
 WHERE id =3;

 ROLLBACK;

 