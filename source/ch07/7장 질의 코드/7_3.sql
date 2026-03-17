/* JAVA 강좌 수강료를 수정하면 JAVA 강좌 수강료 전체가 정상적으로 수정된다 */
UPDATE	Summer
SET		price=15000
WHERE	class='JAVA';

SELECT	*
FROM	Summer;

/* JAVA 강좌를 조회하면 같은 값이 2번 조회되므로 DISTINCT 문을 사용한다 */
SELECT	DISTINCT price 'JAVA 수강료'
FROM	Summer
WHERE	class LIKE 'JAVA';

/* 다음 실습을 위해 JAVA 강좌의 수강료를 다시 20,000원으로 복구한다 */
UPDATE	Summer
SET		price=20000
WHERE	class LIKE 'JAVA';

/* UPDATE 문을 다음과 같이 조건부로 작성하면 데이터 불일치 문제가 발생한다 */
UPDATE	Summer
SET		price=15000
WHERE	class LIKE 'JAVA' AND sid=100;

/* Summer 테이블을 조회해 보면 JAVA 강좌의 수강료가 1건만 수정되었다 */
SELECT	*
FROM	Summer;

/* JAVA 수강료를 조회하면 두 건이 나와 데이터 불일치 문제가 발생하였다 */
SELECT	price 'JAVA 수강료'
FROM	Summer
WHERE	class LIKE 'JAVA';

/* 다음 실습을 위해 JAVA 강좌의 수강료를 다시 20,000원으로 복구한다. */
UPDATE	Summer
SET		price=20000
WHERE	class LIKE 'JAVA';