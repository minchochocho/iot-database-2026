/* JAVA 강좌 수강료를 수정한다 */
UPDATE	SummerPrice
SET		price=15000
WHERE	class LIKE 'JAVA';

/* JAVA 강좌 수강료를 조회해 보니 불일치 문제가 없다 */
SELECT	price 'JAVA 수강료'
FROM	SummerPrice
WHERE	class LIKE 'JAVA';

/* 실습 후 JAVA 강좌의 수강료를 다시 20,000원으로 복구한다 */
UPDATE	SummerPrice
SET		price=20000
WHERE	class LIKE 'JAVA';