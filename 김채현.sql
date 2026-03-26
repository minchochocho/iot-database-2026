-- 1. 현재 대여 중인 도서를 조회하시오
SELECT m.member_name AS "회원명"
	 , b.book_name AS "책제목"
	 , r.rentalDate AS "대여일"
  FROM rentals r
  JOIN books b
 	ON r.book_idx=b.book_idx
  JOIN members m 
    ON r.member_idx = m.member_idx
 WHERE r.returndate IS NULL
 order by r.rentalDate;

-- 2. 회원별 대여 횟수를 집계하시오
SELECT r.member_idx AS "회원번호"
	 , m.member_name AS "회원명"
	 , count(r.member_idx ) AS "대여횟수"
  FROM rentals r
  JOIN members m
    ON r.member_idx = m.member_idx 
 GROUP BY r.member_idx
 ORDER BY 대여횟수 DESC, 회원명;

-- 3. 장르별 도서수를 조회하시오
SELECT d.div_code "장르코드"
	 , d.div_name "장르명"
	 , count(b.div_code) AS 도서수
  FROM division d 
  LEFT JOIN books b
  	ON d.div_code = b.div_code
 GROUP BY 장르코드;
    

-- 4. 한번도 대여되지 않은 도서를 조회하시오
SELECT b.book_name, count(r.book_idx) "대여횟수"
  FROM books b
  LEFT JOIN rentals r 
    ON b.book_idx  = r.book_idx
 GROUP BY b.book_name
 HAVING `대여횟수` = 0;

-- 5. 평균 대여수보다 많이 대여한 회원을 조회하시오
SELECT r.member_idx , m.member_name, count(r.rental_idx) "대여횟수"
  FROM rentals r
  JOIN members m
    ON r.member_idx = m.member_idx 
 GROUP BY r.member_idx
 HAVING `대여횟수` > (SELECT avg(t.a)
FROM (SELECT count(r.rental_idx) "a"
		FROM rentals r 	
 		GROUP BY r.member_idx, r.rental_idx ) AS t)



