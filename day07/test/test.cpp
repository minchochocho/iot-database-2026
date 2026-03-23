// legacy JDBC API 방식 MySQL 연동
#include <iostream>

#include<mysql_driver.h>
#include<mysql_connection.h>

#include<cppconn/exception.h>

using namespace std;

int main() {
	sql::mysql::MySQL_Driver* driver = nullptr;
	sql::Connection* conn = nullptr;
	try {
		// 1. MySQL 드라이버 객체 생성
		sql::mysql::MySQL_Driver* driver = sql::mysql::get_mysql_driver_instance();
		// 2. DB 접속 실행
		unique_ptr<sql::Connection> conn(
			driver->connect("tcp://127.0.0.1:3306", "madang", "madang")
		);
		// 3. DB 선택
		conn->setSchema("madangdb");

		cout << "MySQL 연결 성공! " << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "SQL 예외 발생" << endl;
		cerr << "MySQL 연결 실패 : " << e.what() << endl;
		cerr << "Error Code : " << e.getErrorCode() << endl;
		cerr << "SQLState : " << e.getSQLState() << endl;
	}
	catch (exception& e) {

		cerr << "일반 예외 : " << e.what() << endl;

	}
	return 0;
}