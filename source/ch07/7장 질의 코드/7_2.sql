/* C++ 강좌를 삽입한다 */
INSERT INTO	Summer VALUES (NULL, 'C++', 25000);

/* Summer 테이블 전체를 조회해 본다 */
SELECT * FROM	Summer;

/* NULL 값이 있는 경우 질의에 주의한다 - 투플은 5개이지만 수강 학생은 총 4명이다 */
SELECT	COUNT(*) '수강 인원'
FROM	Summer;

SELECT	COUNT(sid) '수강 인원'
FROM	Summer;

SELECT	COUNT(*) '수강 인원'
FROM	Summer
WHERE	sid IS NOT NULL;

/* 다음 실습을 위해 C++ 강좌를 삭제한다 */
DELETE	FROM Summer WHERE class LIKE 'C++';