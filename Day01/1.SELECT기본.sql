-- Set as a Default와 동일한 기능
use madangdb;

-- 일반 조회 쿼리
SELECT*FROM Book;

-- 1. 김연아 고객의 전화를 찾으시오
select phone from Customer
where name = '김연아';
SELECT * FROM Book;

SELECT * from Customer
WHERE name = '김연아';


-- 한 줄 주석
/*  여러
 줄
 주석  */

-- 모든 쿼리의 마지막은 ; 으로 끝냄
-- ; 은 옵션이지만 무조건 사용을 권함

-- 테이블에서 가져오는 데이터가 아니면 FROM절은 생략
SELECT NOW();	-- 영국 표준시간이기에 + 9를 해줘야 한다
			 	-- Doker로 깔았기 때문, 로컬로 깔면 잘 나올것
                
SELECT bookname, price
	FROM Book;
   
-- 필터링
SELECT * FROM Customer
	WHERE custid > 1 AND custid < 5;

-- 정렬
SELECT * FROM Book;

SELECT * FROM Book
 ORDER BY bookid ASC; -- asc는 생략 가능

SELECT * FROM Book
 ORDER BY bookid DESC;



