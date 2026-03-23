/*
 * 새 도서를 추가하면, 자동으로 Book_log 테이블에 추가된 내용을 기록하는 트리거
*/

-- 로그 테이블 생성
CREATE TABLE Book_log(
	log_idx int PRIMARY KEY AUTO_INCREMENT,
	bookid_l int,
	bookname_l varchar(40),
	publisher_l varchar(40),
	price_l int,
	dml_type varchar(10),
	dml_dt datetime DEFAULT now()
);

SELECT *
  FROM Book_log;	-- book의 로그 확인
  
-- Book 테이블에 데이터 추가
INSERT INTO Book values(45, '겨울왕국','레리꼬',18500);
COMMIT;

-- 위 데이터 수정
UPDATE Book
   SET publisher = '디즈니'
     , price = 20000
 WHERE bookid = 45;

-- 위 데이터 삭제
DELETE FROM Book
 WHERE bookid = 45;