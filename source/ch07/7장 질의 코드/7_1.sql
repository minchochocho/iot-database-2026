/* C 강좌 수강료를 조회하면 10,000원으로 나온다 */
SELECT	price 'C 수강료'
FROM	Summer 
WHERE	class LIKE 'C';

/* 200번 학생이 수강신청을 취소하였다. SummerEnroll 테이블에서 삭제한다 */
SET	SQL_SAFE_UPDATES=0; /* DELETE, UPDATE 연산에 필요한 설정문 */
DELETE	FROM Summer
WHERE	sid=200;

/* C 강좌 수강료를 다시 조회하면 조회되지 않는다 */
SELECT	price 'C 수강료'
FROM	Summer
WHERE	class LIKE 'C';

/* 다음 실습을 위해 200번 학생 자료를 다시 입력한다 */
INSERT INTO	Summer VALUES (200, 'C', 10000);