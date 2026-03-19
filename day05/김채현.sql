-- 1. 각 고객의 custid와 총 구매금액 조회
-- 총 데이터는 1,000건 custid 686, total_price 99,800원부터

SELECT c.custid, sum(o.saleprice) AS "total_price"
  FROM Customer c 
  JOIN Orders o
    ON c.custid = o.custid
 GROUP BY c.custid
 ORDER BY total_price DESC;

-- 2. 주문한 고객의 이름, 책 번호, 판매가격, 주문일자를 조회하시오
-- 총 2,000건의 데이터에 박서진, 691, 39,600, 2026-03-18 부터 시작
SELECT c.name "이름"
	 , b.bookid "책번호"
	 , o.saleprice "판매가격"
	 , o.orderdate "주문일자"
  FROM Orders o
  JOIN Customer c
    ON o.custid = c.custid 
  JOIN Book b
    ON b.bookid = o.bookid
 ORDER BY o.orderdate desc;

-- 3. 전체 주문의 평균 판매가보다 높은 판매가격의 주문을 조회하시오
-- 주문번호, 고객번호, 책번호, 판매가격을 출력하시오
-- 총 988건의 데이터, 505, 686, 766, 49,900부터 시작
    
SELECT o.orderid "주문번호"
	 , c.custid "고객번호"
	 , b.bookid "책번호"
	 , o.saleprice "판매가격"
  FROM Orders o 
  JOIN Customer c
    ON o.custid = c.custid 
  JOIN Book b
    ON b.bookid = o.bookid
 WHERE o.saleprice > (SELECT AVG(o.saleprice ) "Avg_price" FROM Orders o)
 ORDER BY o.saleprice DESC;

    

-- 4. 고객별 총 구매금액 50,000원 이상인 고객의 이름과 총 구매금액을 조회하시오
-- 총 619건의 데이터, 박준경 99,800 부터 시작합니다
SELECT c.name "이름"
	 , sum(o.saleprice) "Total_Price"
  FROM Orders o
  JOIN Customer c
    ON o.custid = c.custid 
 GROUP BY c.custid
HAVING Total_Price > 50000
 ORDER BY Total_Price DESC;
  
