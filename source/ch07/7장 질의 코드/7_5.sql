/* C++ 강좌를 삽입한다. SummerPrice 테이블에 NULL 값 없이 입력할 수 있다 */
INSERT INTO SummerPrice VALUES ('C++', 25000);

SELECT	*
FROM	SummerPrice;

/* 수강신청 정보를 SummerEnroll 테이블에서 확인한다 */
SELECT	*
FROM	SummerEnroll;

/* 다음 실습을 위해 C++ 강좌를 삭제한다 */
DELETE	FROM SummerPrice WHERE class LIKE 'C++';