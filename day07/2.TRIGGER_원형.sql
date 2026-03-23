-- 트리거 원본
delimiter $$
CREATE TRIGGER trg_AfterInsertBook
 AFTER INSERT ON Book FOR EACH ROW
BEGIN
	INSERT INTO Book_log(
		bookid_l ,
		bookname_l,
		publisher_l,
		price_l,
		dml_type
	)
	-- NEW.컬럼명 : 새로들어온 데이터(INSERT), OLD.컬럼명 이전값(UPDATE,DELETE)
	VALUES (NEW.bookid, NEW.bookname, NEW.publisher, NEW.price, 'INSERT');
	
	
END;
$$
delimiter ;
-- Alt + x로 전체실행

-- 수정 트리거, 수정은 NEW, OLD 모두 사용가능
-- But, OLD 사용추천
DELIMITER $$

CREATE TRIGGER trg_AfterUpdateBook
AFTER UPDATE ON Book
FOR EACH ROW
BEGIN
    INSERT INTO Book_log
        (bookid_l, bookname_l, publisher_l, price_l, dml_type)
    VALUES
        (NEW.bookid, NEW.bookname, NEW.publisher, NEW.price, 'UPDATE');
END;
$$
DELIMITER $$;

-- 삭제 트리거
DELIMITER $$

CREATE TRIGGER trg_AfterDeleteBook
AFTER DELETE ON Book
FOR EACH ROW
BEGIN
    INSERT INTO Book_log
        (bookid_l, bookname_l, publisher_l, price_l, dml_type)
    VALUES
        (OLD.bookid, OLD.bookname, OLD.publisher, OLD.price, 'DELETE');
END
$$
DELIMITER $$;