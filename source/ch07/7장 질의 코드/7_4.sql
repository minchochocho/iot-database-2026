/* C 강좌 수강료를 조회하면 10,000원으로 나온다 */
SELECT	price 'C 수강료'
FROM	SummerPrice
WHERE	class LIKE 'C';

/* 200번 학생이 수강신청을 취소하였다. SummerEnroll 테이블에서 삭제한다 */
SET SQL_SAFE_UPDATES=0; /* DELETE, UPDATE 연산에 필요한 설정문 */
DELETE
FROM	SummerEnroll 
WHERE	sid=200;

SELECT	*
FROM	SummerEnroll;

/* C 강좌의 수강료가 존재하는지 확인한다. SummerPrice 테이블에서 조회한다 */
SELECT	price "C 수강료"
FROM	SummerPrice
WHERE	class LIKE 'C';

/* 다음 실습을 위해 200번 학생의 자료를 다시 입력한다 */
INSERT INTO	SummerEnroll VALUES (200, 'C');