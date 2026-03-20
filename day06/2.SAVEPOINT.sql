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

-- 현재 MySQL DB엔진 종류 확인
-- InnoDB(최신버전 엔진), MyISAM(구버전)
-- MyISAM : 트랜잭션 처리가 필요X
SHOW TABLE status LIKE 'accounts';

-- 현재 실행중 트랜잭션 조회 쿼리(root만 가능)
SELECT * FROM information_schema.INNODB_TRX it;

