-- 강사 테이블
CREATE TABLE `Instructor` (
    `Ins_No`    INT            NOT NULL,
    `Ins_Name`  VARCHAR(10)    NOT NULL,
    `Ins_Tel`   VARCHAR(13)    NULL
);

-- 학생 테이블
CREATE TABLE `Student` (
    `Std_Num`   INT            NOT NULL,
    `Std_Name`  VARCHAR(10)    NOT NULL,
    `Std_Tel`   VARCHAR(13)    NOT NULL
);

-- 과목 테이블
CREATE TABLE `Lecture` (
    `Lec_Cd`    CHAR(4)        NOT NULL,
    `Lec_Name`  VARCHAR(20)    NOT NULL,
    `Ins_No`    INT            NOT NULL
);

-- 수강 신청 테이블
CREATE TABLE `Enrollment` (
    `Std_Num`   INT            NOT NULL,
    `Lec_Cd`    CHAR(4)        NOT NULL,
    `Enr_Dt`    DATETIME       NULL    DEFAULT NOW(),
    `Grade`     VARCHAR(2)     NULL
);

-- 기본키(Primary Key) 지정
ALTER TABLE `Instructor` ADD CONSTRAINT `PK_INSTRUCTOR` PRIMARY KEY (`Ins_No`);
ALTER TABLE `Student`    ADD CONSTRAINT `PK_STUDENT`    PRIMARY KEY (`Std_Num`);
ALTER TABLE `Lecture`    ADD CONSTRAINT `PK_LECTURE`    PRIMARY KEY (`Lec_Cd`);
ALTER TABLE `Enrollment` ADD CONSTRAINT `PK_ENROLLMENT` PRIMARY KEY (`Std_Num`, `Lec_Cd`);

-- 외래키(Foreign Key) 지정
-- 1. 과목(Lecture)은 강사(Instructor)를 참조함
ALTER TABLE `Lecture` 
    ADD CONSTRAINT `FK_Instructor_TO_Lecture` 
    FOREIGN KEY (`Ins_No`) REFERENCES `Instructor` (`Ins_No`);

-- 2. 수강(Enrollment)은 학생(Student)을 참조함
ALTER TABLE `Enrollment` 
    ADD CONSTRAINT `FK_Student_TO_Enrollment` 
    FOREIGN KEY (`Std_Num`) REFERENCES `Student` (`Std_Num`);

-- 3. 수강(Enrollment)은 과목(Lecture)을 참조함
ALTER TABLE `Enrollment` 
    ADD CONSTRAINT `FK_Lecture_TO_Enrollment` 
    FOREIGN KEY (`Lec_Cd`) REFERENCES `Lecture` (`Lec_Cd`);

