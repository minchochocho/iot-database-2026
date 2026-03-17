DROP TABLE IF EXISTS SummerPrice; /* 기존 테이블이 있으면 삭제 */
DROP TABLE IF EXISTS SummerEnroll; /* 기존 테이블이 있으면 삭제 */

/* SummerPrice 테이블 생성 */
CREATE TABLE SummerPrice (
	class VARCHAR(20),
    price INTEGER
);

INSERT INTO SummerPrice VALUES ('JAVA', 20000);
INSERT INTO SummerPrice VALUES ('PYTHON', 15000);
INSERT INTO SummerPrice VALUES ('C', 10000);

SELECT	*
FROM	SummerPrice;

/* SummerEnroll 테이블 생성 */
CREATE TABLE SummerEnroll (
	sid	INTEGER,
	class VARCHAR(20)
);

INSERT INTO SummerEnroll VALUES (100, 'JAVA');
INSERT INTO SummerEnroll VALUES (150, 'PYTHON');
INSERT INTO SummerEnroll VALUES (200, 'C');
INSERT INTO SummerEnroll VALUES (250, 'JAVA');

SELECT	*
FROM	SummerEnroll;