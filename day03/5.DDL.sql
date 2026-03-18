/* CREATE */

-- TABLE
-- NewBook 테이블 생성
CREATE TABLE NewBook(
	bookid integer,
	BOOKNAME varchar(20),
	publisher varchar(20),
	price decimal(10, 2) -- 외국에서 많이 사용, (총길이수, 소수점)
);

-- 테이블 지우기
DROP TABLE NewBook;

-- 컬럼은 대소문자 구분없음. 테이블 및 객체명은 대소문자 구분
-- MySQL 해당버전의 특징
SELECT BOOKID, bookname, PUBLISHER, PRICE
  FROM NewBook;

-- NewBook 테이블 생성
-- 기본키 추가해서 생성
CREATE TABLE NewBook(
	bookid integer PRIMARY KEY,
	BOOKNAME varchar(20) NOT NULL,
	publisher varchar(20) NOT NULL,
	price decimal(10, 2) NOT NULL
);

-- 제약조건을 따로 적는 방법
-- 기본키가 하나 이상이면 반드시 아래의 방법으로 작성
-- PRIMARY KEY (bookid, bookname)
CREATE TABLE NewBook(
	bookid integer,
	BOOKNAME varchar(20) NOT NULL,
	publisher varchar(20) UNIQUE,
	price decimal(10, 2) DEFAULT 10000 CHECK (price > 1000),
	PRIMARY KEY (bookid, bookname) -- 기본키를 복합키로 설정할 때 반드시 사용해야하는 방식	
);

-- PRIMARY KEY는 UNIQE에 NOT NULL
INSERT INTO NewBook (bookid, bookname, publisher, price)
VALUES (1,'야구의 추억','대한미디어',9000);

-- price가 not null이기에 절대 들어갈 수 없다
INSERT INTO NewBook (bookid, bookname, publisher)
VALUES (2,'골프 바이블','이상미디어');

-- 조건 범위가 안맞으므로 안됨
INSERT INTO NewBook (bookid, bookname, publisher, price)
VALUES (3,'골프여제 박세리','피어슨', 800);


