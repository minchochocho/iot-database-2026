-- fnc_Interest
-- 책 가격별 이윤계산 함수
CREATE FUNCTION fnc_Interest(
	price int 
)
RETURNS INT
DETERMINISTIC
BEGIN
	-- 변수선언
	DECLARE myInterest int;
	-- 가격이 30,000원 이상이면 10%, 그 미만은 5%
	
	IF price > 30000 THEN
		SET myInterest = price*0.1;
	ELSE
		SET myInterest = price*0.05;
	END IF;
	
	RETURN myInterest;
END

-- fnc_balanceGrade
CREATE FUNCTION fnc_balanceGrade(
	balance int
)
RETURNS varchar(20)
DETERMINISTIC
BEGIN
	DECLARE grade varchar(20);

	IF balance >= 50000 THEN
		SET grade = 'VIP';
	ELSEIF balance >= 20000 THEN
		SET grade = 'GOLD';
	ELSE
		SET grade = 'SILVER';
	END IF;
	
	RETURN grade;
END