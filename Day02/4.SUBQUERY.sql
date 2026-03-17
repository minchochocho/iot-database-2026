-- 가장 비싼 도서의 이름을 조회하세요
SELECT b1.bookname, b1.price
  FROM Book b1 
 WHERE b1.price>=(SELECT max(b.price)
                    FROM Book b);
