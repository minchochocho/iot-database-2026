/* 트랜잭션 기본 */

-- 계좌 테이블 생성

CREATE TABLE accounts(
    id int PRIMARY KEY,
    owner varchar(40),
    balance int
); 

-- 데이터 추가
INSERT INTO accounts (id, owner, balance)
VALUES (1,'Kim',10000)
	 , (2,'Lee',20000)
	 , (3,'Sung',100000000);

-- 트랜잭션 사용가능 여부 확인
-- 1: 자동처리 상태(트랜잭션확인 불가)
-- 0: 트랜잭션 사용 모드
SELECT @@autocommit;

-- 자동커밋 끄기
SET autocommit = 0;

-- 트랜잭션 사용순서
START TRANSACTION;

COMMIT;
ROLLBACK;

-- 1. kim 계좌에서 1000원 출금
-- 다시 시작할때는 start transaction을 다시 실행해야 함
START TRANSACTION;

UPDATE accounts
   SET balance = balance - 1000
  WHERE id=1;

SELECT *
  FROM accounts;

COMMIT;
ROLLBACK;

-- 2. lee 계좌에서 30000원 출금
START TRANSACTION;

UPDATE accounts
   SET balance = balance - 30000
  WHERE id=2;

SELECT *
  FROM accounts;

COMMIT;

ROLLBACK;
-- 한번 커밋된 것은 다시 롤백 못함 주의!!!!!!
-- 다 작성하고 되면은 커밋, 틀렸으면 롤백을 작성하는게 좋다
-- 미리 적어놓으면 실수할 확률이 높음


-- 3. kim -> sung 5000원 출금
START TRANSACTION;

-- kim 출금
UPDATE accounts
   SET balance = balance - 5000
  WHERE id=1;

-- sung 입금
UPDATE accounts
   SET balance = balance + 5000
  WHERE id=3;

SELECT *
  FROM accounts;

COMMIT;

ROLLBACK;

-- 4. kim -> lee 송금 중 문제발생
START TRANSACTION;

-- kim 출금
UPDATE accounts
   SET balance = balance - 1000
  WHERE id=1;

-- 세이브포인트 다시 확인
SAVEPOINT sp_transfer;

-- lee 입금
UPDATE accounts
   SET balance = balance + 1000
  WHERE id=2;

SELECT *
  FROM accounts;

ROLLBACK TO sp_transfer;

COMMIT;

ROLLBACK;


