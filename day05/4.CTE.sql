-- CTE(Common Table Expression)
-- 단독으로 실행x alt + x로 전체 실행

-- 일반 서브쿼리
/*
SELECT *
  FROM (SELECT o.custid, sum(o.saleprice) AS "TotalPrice"
		  FROM Orders o
		 GROUP BY o.custid) t
 WHERE t.TotalPrice > 31000;
*/

-- 구문이 많을 때는 Alt+x로 실행권장
-- CTE
WITH order_sum as(
	SELECT o.custid
		 , sum(o.saleprice) AS "TotalPrice"
	  FROM Orders o
	 GROUP BY o.custid
),
customer_sub AS (
	SELECT name, address
	  FROM Customer
)
-- SELECT  *
--   FROM order_sum 
--  WHERE TotalPrice > 31000;
SELECT *
  FROM customer_sub
 WHERE name = '박지성';

-- 1부터 10까지 가상테이블 생성
WITH RECURSIVE numbers AS( 
	SELECT 1 AS num -- 시작값
	 UNION ALL 
	 
	SELECT num +1	-- 이전 수에 1더하기
	  FROM numbers
	 WHERE num < 10	-- 종료 조건까지
)
SELECT *
  FROM numbers;
	
