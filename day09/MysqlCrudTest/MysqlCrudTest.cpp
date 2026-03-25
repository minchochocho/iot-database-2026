// MySQL CRUD
#define NOMINMAX	// Windows 매크로 충돌
#include<iostream>
#include<mysql.h>
#include<Windows.h>
#include<clocale>
#include<string>
#include<limits>
#include <iomanip>
#include<cstdlib>


using namespace std;

void clearScreen() {
	system("pause");
	system("cls"); 
}

int getVisualLength(string str) {
	int len = 0;
	for (int i = 0; i < str.length(); i++) {
		if (str[i] & 0x80) {
			len += 2;
			i += 2;
		}
		else {
			len += 1;
		}
	}
	return len;
}

void printLeft(string str, int width) {
	int visualLen = getVisualLength(str);
	cout << str;
	for (int i = 0; i < (width - visualLen); i++) {
		cout << " ";
	}
}

// 메뉴 출력
void printMenu() {
	cout << "========================================\n";
	cout <<	"            MySQL CRUD 예제\n";
	cout << "========================================\n";
	cout << "1. 조회\n";
	cout << "2. 삽입\n";
	cout << "3. 수정\n";
	cout << "4. 삭제\n";
	cout << "5. 종료\n";
	cout << "선택 >";
}

// 입력 버퍼 클리어
void clearInput() {
	cin.clear();
	cin.ignore(numeric_limits<streamsize>::max(), '\n');

}

// MySQL 접속
MYSQL* connectDB() {
	MYSQL* conn = mysql_init(NULL);	// 초기화 인자는 옵션
	// 초기화 실패
	if (conn == NULL) {
		cerr << "MySQL 초기화 실패" << endl;
		return NULL;	// 함수 탈출
	}
	// 접속 시도
	conn = mysql_real_connect(
		conn, 
		"127.0.0.1", 
		"madang",
		"madang",
		"madangdb", 
		3306,
		NULL,
		0
	);
	// 접속 실패

	if (conn == NULL) {
		cerr << "MySQL 접속 실패 : "<<mysql_error(conn) << endl;
		return NULL;	// 함수 탈출
	}
	// MySQL 서버 문자셋 생략

	return conn;
}

// SELECT 조회함수
void selectBook(MYSQL* conn) {
	const char* query="SELECT bookid, bookname, publisher, price FROM Book";

	if (mysql_query(conn,query)!= 0) {
		cerr << "SELECT error : " << mysql_error(conn) << endl;
		return;
	}

	MYSQL_RES* result = mysql_store_result(conn);
	if (result == NULL) {
		cerr << "RESULT error : " << mysql_error(conn) << endl;
		return;
	}

	MYSQL_ROW row;

	cout << "\n========================================\n";
	cout << "               도서정보\n";
	cout << "\n========================================\n";
	printLeft("BookID",10);
	printLeft("BookName",26);
	printLeft("Publisher",20);
	printLeft("Price",10);
	cout << "\n--------------------------------------------------------------\n";

	while ((row = mysql_fetch_row(result)) != NULL) {
		// cout << row[0] << "\t" << row[1] << "\t\t" << row[2] << "\t" << (row[3] ? row[3] : "0") << "\t" << endl;
		printLeft((row[0] ? row[0]:""), 10);
		printLeft((row[1] ? row[1]:""), 26);
		printLeft((row[2] ? row[2]:""), 20);
		printLeft((row[3] ? row[3]:"0"), 10);
		cout << endl;
	}

	cout << endl;

	mysql_free_result(result);
}

// INSERT 실행함수
void insertBook(MYSQL* conn) {
	string bookid;		// PK가 Auto면 안해도댐
	string bookname;
	string publisher;
	string price;

	clearInput();
	cout << "\nbookid > ";
	getline(cin, bookid);
	cout << "bookname > ";
	getline(cin, bookname);
	cout << "publisher > ";
	getline(cin, publisher);
	cout << "price > ";
	getline(cin, price);


	string query = "INSERT INTO Book VALUES('" + bookid + "', '" + bookname + "', '" + publisher + "', '" +price+ "')";


	if (mysql_query(conn, query.c_str()) != 0) {
		cerr << "INSERT 에러 : " << mysql_error(conn) << endl;
		return;
	}

}

void updateBook(MYSQL* conn) {
	string bookid;
	string bookname;
	string publisher;
	string price;

	clearInput();
	cout << "\nbookid > ";
	getline(cin, bookid);
	cout << "bookname > ";
	getline(cin, bookname);
	cout << "publisher > ";
	getline(cin, publisher);
	cout << "price > ";
	getline(cin, price);

	string query = "UPDATE madangdb.Book " 
				   " SET bookname = '"+bookname+
				"', publisher = '"+publisher+
				"', price = '"+price+
				"'  WHERE bookid ='"+bookid+"'";

	// 쿼리 실행
	if (mysql_query(conn, query.c_str()) != 0) {
		cerr << "UPDATE 에러 : " << mysql_error(conn) << endl;
		return;
	}

	uint16_t count = mysql_affected_rows(conn);

	if (count == 0) {
		cout << "해당 bookid 데이터가 없습니다.\n\n";
	}
	else {
		cout << "건 UPDATE 완료" << endl;
	}
}

void deleteBook(MYSQL* conn) {
	string bookid;

	clearInput();
	cout << "\nbookid > ";
	getline(cin, bookid);

	string query = "DELETE FROM Book WHERE bookid = " + bookid;

	if (mysql_query(conn, query.c_str()) != 0) {
		cerr << "DELETE 에러 : " << mysql_error(conn) << endl;
		return;
	}

	uint16_t count = mysql_affected_rows(conn);

	if (count == 0) {
		cout << "해당 bookid 데이터가 없습니다.\n\n";
	}
	else {
		cout << "건 DELETE 완료" << endl;
	}
}

int main() {
	SetConsoleOutputCP(CP_UTF8);
	SetConsoleCP(CP_UTF8);
	setlocale(LC_ALL, ".UTF8");
	// DB연결
	MYSQL* conn = connectDB();
	if (conn == NULL) {
		return 1;
	}
	cout << "MySQL 연결 성공!" << endl;

	int menu;
	while (true) {
		// 메뉴출력
		printMenu();
		cin >> menu;
		// 숫자이외의 잘못된 입력
		if (cin.fail()) {
			clearInput();
			cout << "메뉴는 숫자로 입력\n\n";
			continue;
		}

		switch (menu) {
		case 1:
			// SELECT
			selectBook(conn);
			clearScreen();
			break;
		case 2:
			// INSERT 
			insertBook(conn);
			clearScreen();
			break;
		case 3:
			// UPDATE
			updateBook(conn);
			clearScreen();
			break;
		case 4:
			// DELETE
			deleteBook(conn);
			clearScreen();
			break;
		case 5: // 프로그램 종료
			cout << "프로그램 종료" << endl;
			return 0;
		default:
			cout << "잘못된 메뉴\n\n";
			clearScreen();
			break;
		}
	}

	// 연결　종료

	mysql_close(conn);


	return 0;
}