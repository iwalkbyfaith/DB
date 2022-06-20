/* 1. 데이터베이스 생성 명령
DB생성시 한글을 쓸 수 있도록 -> default character set utf8;  아직 실행안함*/
create database project default character set utf8;

DROP TABLE book;
DROP TABLE rental;
DROP TABLE review;
DROP TABLE userinfo;

DROP TABLE renttest;
DROP TABLE boardinfo;



-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

-- 유저 테이블
CREATE TABLE userinfo(
uid VARCHAR(20) PRIMARY KEY,
uname VARCHAR(10) NOT NULL,
upw VARCHAR(20) NOT NULL,
upnum VARCHAR(20) NOT NULL,
uemail VARCHAR(20) NOT NULL,
utype BOOL DEFAULT FALSE,
counting INT DEFAULT 0
);


SELECT * FROM userinfo;

	SELECT * FROM userinfo ORDER BY utype desc;
	
    -- 데이터 적재
		INSERT INTO userinfo(uid, uname, upw, upnum, uemail) VALUES ('아이디1', '이름1', '비번1', '01000000001', 'email1@naver.com');
		INSERT INTO userinfo(uid, uname, upw, upnum, uemail) VALUES ('아이디2', '이름2', '비번2', '01000000002', 'email2@naver.com');

	-- 관리자 데이터 적재
		INSERT INTO userinfo(uid, uname, upw, upnum, uemail, utype) VALUES('아이디0', '관리자1', '비번0', '01000000000', 'email0@naver.com', '1');
		INSERT INTO userinfo(uid, uname, upw, upnum, uemail, utype) VALUES('아이디00', '관리자2', '비번00', '01000000000', 'email0@naver.com', '1');
        
        
	-- 데이터 삭제
		DELETE FROM userinfo WHERE uid='아이디1';

-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

-- 책 테이블
CREATE TABLE book(
bnum INT PRIMARY KEY AUTO_INCREMENT,
bname VARCHAR(20) NOT NULL,
bwriter VARCHAR(20) NOT NULL,
bpub VARCHAR(20) NOT NULL,
bcategory VARCHAR(10) NOT NULL,
check_out BOOL DEFAULT FALSE
);

SELECT * FROM book;
	
    -- 책 적재
		INSERT INTO book(bname, bwriter, bpub, bcategory) VALUES('책1', '저자1', '출판사1', '스릴러');
		INSERT INTO book(bname, bwriter, bpub, bcategory) VALUES('책2', '저자2', '출판사2', '로맨스');
		INSERT INTO book(bname, bwriter, bpub, bcategory) VALUES('책3', '저자3', '출판사3', '사회/과학');
		INSERT INTO book(bname, bwriter, bpub, bcategory) VALUES('책4', '저자4', '출판사4', '개발');
		INSERT INTO book(bname, bwriter, bpub, bcategory) VALUES('책5', '저자5', '출판사5', '요리');
		INSERT INTO book(bname, bwriter, bpub, bcategory) VALUES('책6', '저자6', '출판사6', '개발');
		INSERT INTO book(bname, bwriter, bpub, bcategory, check_out) VALUES('책6', '저자6', '출판사6', '개발', '1');
		INSERT INTO book(bname, bwriter, bpub, bcategory, check_out) VALUES('책6', '저자6', '출판사6', '개발', '1');


-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

-- 대여/반납 테이블
CREATE TABLE renttest(
rentnum INT PRIMARY KEY AUTO_INCREMENT,
rentdate DATETIME DEFAULT now(),
returndate DATE,
returnschedule DATE,
bnum INT NOT NULL,
uid VARCHAR(20) NOT NULL,
check_out BOOL DEFAULT TRUE,
overdue BOOL DEFAULT FALSE,
FOREIGN KEY (uid) REFERENCES userinfo (uid) ON UPDATE CASCADE ON DELETE RESTRICT
-- FOREIGN KEY (bnum) REFERENCES book (bnum) ON UPDATE CASCADE ON DELETE RESTRICT
);

SELECT * FROM renttest;

	-- 대여 적재
    INSERT INTO renttest(bnum, uid) VALUES('1', '아이디1');
    INSERT INTO renttest(bnum, uid) VALUES('2', '아이디1');
    INSERT INTO renttest(bnum, uid) VALUES('3', '아이디1');
    INSERT INTO renttest(bnum, uid) VALUES('4', '아이디2');
    INSERT INTO renttest(bnum, uid) VALUES('5', '아이디3');
    INSERT INTO renttest(bnum, uid) VALUES('6', '아이디4');

-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

-- 리뷰 테이블
CREATE TABLE review(
revnum INT PRIMARY KEY AUTO_INCREMENT,
bnum INT NOT NULL,
bname VARCHAR(20) NOT NULL,
uid VARCHAR(20), 
revtitle VARCHAR(50) NOT NULL,
revcontent VARCHAR(1000) NOT NULL,
revdate DATETIME DEFAULT now(),
revmdate DATETIME DEFAULT null,
FOREIGN KEY (bnum) REFERENCES book (bnum) ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (bname) REFERENCES book (bname) ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (uid) REFERENCES userinfo (uid) ON UPDATE CASCADE ON DELETE RESTRICT
);

SELECT * FROM review;











-- 조인 도전

SELECT * FROM userinfo INNER JOIN renttest ON userinfo.uid = renttest.uid; 

SELECT * FROM book INNER JOIN renttest ON book.bnum = renttest.bnum; 

-- 책 테이블의 bnum, bname / 대여 테이블의 uid, check_out, rentdate
SELECT book.bnum, book.bname, renttest.uid, renttest.check_out, renttest.rentdate FROM book INNER JOIN renttest ON book.bnum = renttest.bnum; 

-- 책 테이블 bnum과 대여 테이블의 check_out만 (-> 대여 버튼을 눌렀을 시, 책 테이블의 대여 정보를 업데이트 해주는 구문)
SELECT book.bnum, renttest.check_out FROM book INNER JOIN renttest ON book.bnum = renttest.bnum; 