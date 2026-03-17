CREATE USER mdguest@'localhost' IDENTIFIED BY 'mdguest';
# mdguest 사용자 생성은 User 테이블을 통해 확인한다.
SELECT * FROM mysql.User WHERE User LIKE 'mdguest';