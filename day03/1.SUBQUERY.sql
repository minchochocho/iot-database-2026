-- 서브쿼리 종류

-- WHERE절 서브쿼리

-- 서브쿼리를 사용해서 출판사 이름이 '미디어'로 끝나는 출판사에서
-- 출판한 책을 조회하시오

SELECT bookname,publisher 
  FROM Book
 WHERE publisher IN ( SELECT DISTINCT publisher
                        FROM Book
                       WHERE publisher LIKE '%미디어');

-- 도서를 구매한 적이 있는 고객의 이름을 검색
SELECT c.name
  FROM Customer c
 WHERE c.custid IN (SELECT DISTINCT custid
                      FROM Orders);

-- 대한미디어에서 출판한 도서를 구매한 고객의 정보를 보이시오
SELECT *
  FROM Customer c 
 WHERE custid IN (SELECT custid 
                    FROM Orders
                   WHERE bookid IN ( SELECT b.bookid
                                       FROM Book b 
                                      WHERE b.publisher = "대한미디어"));

-- 조인으로 변경, 모든 테ㅣ블의 컬럼 사용가능
SELECT *
  FROM Customer c
     , Orders o 
     , Book b 
 WHERE c.custid = o.custid 
   AND b.bookid = o.bookid
   AND b.publisher ='대한미디어';
   
-- 도서 전체의 평균값 보다 저렴한 책들을 조회하시오
SELECT *
  FROM Book b
WHERE b.price<= (SELECT avg(price)
                   FROM Book);

-- 출판사별 가장 비싼 도서를 조회하세요
-- 서브쿼리로 두 컬럼을 비교 가능
SELECT *
  FROM Book b
 WHERE (publisher,b.price) IN (SELECT publisher, max(price)
                                 FROM Book  
                                GROUP BY publisher);

-- 출판사별 가장 비싼 도서와 가격이 일치하는 책정보를 조회
SELECT *
  FROM Book b
 WHERE price IN (SELECT max(price)
                   FROM Book  
                  GROUP BY publisher);
 
-- any, some 결과 중 메인쿼리 조건이 하나라도 참이면 출력
-- 출판사별 가장비싼 책과 가격이 하나라도 일치하는 책정보를 조회하라
SELECT *
  FROM Book b
 WHERE price = ANY (SELECT max(price)
                    FROM Book  
                   GROUP BY publisher);

-- 출판사별 가장비싼 책과 가격이 하나라도 더 비싼 책정보를 조회하라
SELECT *
  FROM Book b
 WHERE price > ANY (SELECT max(price)
                    FROM Book  
                   GROUP BY publisher);

SELECT *
  FROM Book b
 WHERE price > SOME (SELECT max(price)
                    FROM Book  
                   GROUP BY publisher);

-- ALL = AND
-- 출판사별 가장 비싼 책들과 가격이 모두 조건에 일치하는 책정보를 조회하라
SELECT *
  FROM Book b
 WHERE price >= ALL (SELECT max(price)
                    FROM Book  
                   GROUP BY publisher);

-- EXISTS
-- 서브쿼리 결과가 아무것도 없으면 메인퀄는 조회안됨
-- 서브쿼리 결과가 뭐라도 있으면 메인쿼리 조회가능
SELECT *
  FROM Book b
 WHERE EXISTS (SELECT max(price)
                 FROM Book  
                GROUP BY publisher
               HAVING  max(price) > 40000);

-- 상관서브쿼리(Correlated subquery). 
-- 메인쿼리의 컬럼이 서브쿼리의 조건에 포함될 때
-- 가장 까다로움, 서브쿼리만 따로 실행 불가능
-- 되도록이면 쓰지 말 것
-- 출판사별 출판사 평균 도서가격보다 비싼 도서를 조회하세요


-- 샘플
(SELECT avg(b2.price)
   FROM Book b2
  GROUP BY b2.publisher);

-- 상관 서브쿼리는 안쪽 서브쿼리만 따로 실행불가. 코드 이해가 쉽지 않음
-- 요새는 많이 안쓰는 걸 권장  
SELECT *
  FROM Book b1
 WHERE b1.price > (SELECT avg(b2.price)
			      FROM Book b2
			      WHERE b2.publisher = b1.publisher );

/* FROM절 서브쿼리 */

-- 서브쿼리로 만들어진 가상테이블을 진짜 테이블처럼 FROM절에 사용
-- 구매 고객별 합계 중에서 총 금액이 32,000 이상인 구매건의 고객번호와 금액을 조회
SELECT *
  FROM (SELECT custid,sum(saleprice) AS "TotalPrice"
		  FROM Orders
		 GROUP BY custid) t
 WHERE t.TotalPrice  >= 32000
 ORDER BY t.TotalPrice  DESC;
-- from절의 쿼리도 진짜 많이 씀

-- FROM절 서브쿼리는 일반 테이블 Customer와 조인 가능
SELECT t.custid , c.name , t.TotalPrice 
  FROM (SELECT custid,sum(saleprice) AS "TotalPrice"
		  FROM Orders
		 GROUP BY custid) t
 INNER JOIN Customer c 
    ON t.custid = c.custid 
 WHERE t.TotalPrice >=32000
 ORDER BY t.TotalPrice  DESC;

-- 구매를 3번 이상한 고객만 조회하시오
SELECT *
  FROM (SELECT custid, count(*) AS "OrderCount"
  		  FROM Orders
		 GROUP BY custid) t
 WHERE t.OrderCount >=3;


/* SELECT절 서브쿼리 */
-- 조인을 사용하지 않고 주문번호가 5이하인 주문건들의 고객명과 책 이름을 같이 조회하시오

-- 조인을 사용했을 때의 쿼리
SELECT o.orderid
	 , o.custid 
	 , c.name 
	 , b.bookname 
	 , o.bookid 
	 , o.saleprice 
, o.orderdate  
  FROM Orders o, Customer c, Book b
 WHERE o.custid = c.custid 
   AND o.bookid  = b.bookid 
   AND o.orderid <=5;

-- SELECT 서브쿼리는 한 행 한 컬럼만 리턴되어야 함!
SELECT o.orderid
	 , o.custid 
	 , (SELECT name FROM Customer WHERE custid = o.custid ) '고객명'
	 , o.bookid 
	 , (SELECT bookname FROM Book WHERE bookid = o.bookid) '도서명'
	 , o.saleprice 
	 , o.orderdate  
  FROM Orders o
 WHERE o.orderid <=5;

