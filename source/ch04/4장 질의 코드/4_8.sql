SELECT	orderid '주문번호', DATE_FORMAT(orderdate, '%Y-%m-%d') '주문일', custid '고객번호', bookid '도서번호'
FROM	Orders
WHERE	orderdate= STR_TO_DATE('20240707', '%Y%m%d');