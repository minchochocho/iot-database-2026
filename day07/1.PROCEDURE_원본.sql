-- prc_insertBook 프로시저 원본

CREATE PROCEDURE madangdb.prc_insertBook(
	IN vbookID int,
	IN vbookName varchar(40),
	IN vpublisher varchar(40),
	IN vprice int
)
BEGIN
	INSERT INTO Book(bookId, bookname, publisher, price)
	VALUES (vbookID, vbookName, vpublisher, vprice);
END

-- prc_insertOrUpdateBook
CREATE PROCEDURE prc_insertOrUpdateBook(
	IN vbookID int,
	IN vbookName varchar(40),
	IN vpublisher varchar(40),
	IN vprice int
)
BEGIN
	DECLARE vcount int;
	-- 같은 책이 있는지 확인
	SELECT count(*) INTO vcount
	  FROM Book
	 WHERE bookname LIKE vbookName;

	IF vount != 0 THEN
		SET SQL_SAFE_UPDATES = 0;	-- MySQL 안전 업데이트모드를 끄는 설정
		-- 같은 데이터가 있으니 업데이트
		UPDATE Book
			SET price = vprice
			  , publisher = vpublisher
		  WHERE bookname LIKE vbookname; -- 원래 PK로 조건 필요
	ELSE 
		-- 같은 데이터가 없으니 추가
		INSERT INTO Book VALUES
		(vbookID, vbookName, vpublisher, vprice);
	END IF;
END

-- prc_getAveragePrice
CREATE PROCEDURE prc_getAveragePrice(
	OUT AverageVal int
)
BEGIN
	SELECT avg(price) INTO AverageVal
	  FROM Book
	 WHERE price IS NOT NULL;
END

-- cursor 사용 프로시저
CREATE PROCEDURE prc_getInterest()
BEGIN
	DECLARE vinterest int DEFAULT 0;	-- 총 이윤을 담을 변수
	DECLARE vprice int;	-- 커서당 Order table saleprice를 각각 담을 변수
	DECLARE endOfRow boolean DEFAULT FALSE;	-- 커서 마지막을 확인하는 변수
	DECLARE interestCursor CURSOR FOR	-- 커서 변수
		SELECT saleprice FROM Orders;	-- Orders table saleprice를 하나씩
	DECLARE CONTINUE handler	
		FOR NOT FOUND SET endOfRow=TRUE;
	
	OPEN interestCursor;	-- 커서 오픈
	cursor_loop: LOOP		-- 커서 반복
		-- Orders의 saleprice 값이 반복적으로 vprice에 할당
		FETCH interestCursor INTO vprice;
		-- 마지막에 커서 반복문 탈출(break와 동일)
		IF endOfRow THEN LEAVE cursor_loop;
		END IF;
	
		-- vprice에 들어온 값이 3만원 이상이면 10% 이윤 계산
		-- 이하면 5% 계산
		IF vprice >=30000 THEN
			SET vinterest = vinterest + vprice*0.1;
		ELSE
			SET vinterest = vinterest + vprice*0.05;
		END IF;
	END LOOP cursor_loop;
	CLOSE interestCursor;	-- 커서 종료
	
	SELECT concat('전체 이익금 = ', vinterest);
END

