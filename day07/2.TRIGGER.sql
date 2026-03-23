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

