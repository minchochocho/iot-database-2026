-- GROUP BY
-- 주문정보에서 각 고객별 총판매액을 조회하시오
-- GROUP BY에서 WITH ROLLUP을 사용하면
-- HAVING 절 이전에 합산 후
-- HAVING 절로 필터링
SELECT o.custid, sum(o.saleprice) AS "Totalprice"
  FROM Orders o
WHERE  > 20000
 GROUP BY o.custid WITH ROLLUP;

-- ROLLUP을 사용하지 않으면 쿼리길이가 두배가까이 늘어남
SELECT o.custid, sum(o.saleprice) AS "TotalPrice"
  FROM Orders o
 GROUP BY o.custid
HAVING TotalPrice > 20000
 UNION 
SELECT NULL, sum(t.TotalPrice)
  FROM (SELECT o.custid, sum(o.saleprice) AS "TotalPrice"
        FROM Orders o
       GROUP BY o.custid       
      HAVING TotalPrice > 20000) t;

-- 필터링 ROLLUP을 하려면 서브쿼리 사용
SELECT t.custid , sum(t.TotalPrice) AS "TotalPrice"
  FROM (SELECT o.custid, sum(o.saleprice) AS "TotalPrice"
		  FROM Orders o
		 GROUP BY o.custid
		HAVING TotalPrice > 20000) t
GROUP BY t.custid  WITH ROLLUP;

-- GROUPING
SELECT o.custid , sum(o.saleprice) AS "TotalPrice"
	 , GROUPING(o.custid)
  FROM Orders o 
 GROUP BY o.custid WITH ROLLUP;