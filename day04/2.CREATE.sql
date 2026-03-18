-- CREATE 계속

-- 테이블 날리기
DROP TABLE NewBook;

-- NewBook, NewOrder 테이블 생성
CREATE TABLE NewBook(
	bookid int PRIMARY KEY,		-- 기본키
	bookname varchar(40) NOT NULL,
	publisher varchar(40),
	price decimal(10,2) DEFAULT 10000
);

-- NewCustomer 테이블
CREATE TABLE NewCustomer(
	custid int,
	custname varchar(40),
	address varchar(120) NOT NULL,
	phone varchar(20) NOT NULL,
	PRIMARY KEY(custid)
);

-- NewOrder
-- 주문번호(PK), 고객번호(FK), 책번호(FK)
-- 판매가격, 판매일자
CREATE TABLE NewOrder(
	orderid int,
	custid int NOT NULL,
	bookid int NULL,
	salaprice decimal(10, 2),
	orderdate datetime,
	PRIMARY KEY(orderid),
	FOREIGN KEY(custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE,
	FOREIGN KEY(bookid) REFERENCES NewBook (bookid) ON DELETE CASCADE
);

-- OldBook AUTO_INCREMENT
CREATE TABLE OldBook(
	bookid int AUTO_INCREMENT PRIMARY KEY,
	bookname varchar(40) NOT NULL,
	publisher varchar(40),
	price decimal(10,2)
);

-- bookid는 생략
INSERT INTO OldBook (bookname, publisher, price)
VALUES ('프로젝트 헤일메리','대한미디어',22000);

SELECT * FROM OldBook;

-- 데이터베이스 생성
-- 관리자에서 가능
CREATE DATABASE testdb;

-- 사용자 생성, 뷰, 인덱스 ...