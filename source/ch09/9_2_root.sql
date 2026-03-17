CREATE USER mdguest2 IDENTIFIED BY 'mdguest2';
# mdguest2 사용자 생성은 USER 테이블을 통해 확인한다.
SELECT * FROM mysql.User WHERE User LIKE 'mdguest2';