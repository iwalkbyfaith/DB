/* 1. 데이터베이스 생성 명령
DB생성시 한글을 쓸 수 있도록 -> default character set utf8;  아직 실행안함*/
create database project default character set utf8;


-- 테이블 삭제
	drop table userinfo;
    drop table book;
    drop table rent;
	drop table returnb;
    drop table review;
    




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
	-- 데이터 적재
	INSERT INTO userinfo(uid, uname, upw, upnum, uemail) VALUES('아이디1', '이름1', '비번1', '핸드폰1', '이메일1@naver.com');
	INSERT INTO userinfo(uid, uname, upw, upnum, uemail) VALUES('아이디2', '이름2', '비번2', '핸드폰2', '이메일2@naver.com');
	INSERT INTO userinfo(uid, uname, upw, upnum, uemail) VALUES('아이디3', '이름3', '비번3', '핸드폰3', '이메일3@naver.com');

-- 책 테이블
CREATE TABLE book(
bnum INT PRIMARY KEY AUTO_INCREMENT,
bname VARCHAR(20) UNIQUE NOT NULL,
bwriter VARCHAR(20) NOT NULL,
bpub VARCHAR(20) NOT NULL,
bcategory VARCHAR(10) NOT NULL,
check_out BOOL UNIQUE DEFAULT FALSE
);

SELECT * FROM book;

	-- 데이터 적재
		INSERT INTO book VALUES(null, '책1', '저자1', '출판사1', '카테고리1', false);
		INSERT INTO book VALUES(null, '책2', '저자2', '출판사2', '카테고리2', false);
		INSERT INTO book VALUES(null, '책3', '저자3', '출판사3', '카테고리3', false);
		INSERT INTO book VALUES(null, '책4', '저자4', '출판사4', '카테고리4', false);
        
-- ---------------------------------------------------------------------------------       
-- 대여 테이블 (이전 버전)
CREATE TABLE rent(
rentnum INT PRIMARY KEY AUTO_INCREMENT,
rentdate DATETIME DEFAULT now(),
returnschedule DATETIME DEFAULT now(),
bnum INT NOT NULL,
uid VARCHAR(20) NOT NULL,
overdue BOOL DEFAULT FALSE
);

SELECT * FROM rent;
		INSERT INTO rent(bnum, uid, overdue) VALUES ('1', '아이디1', false);
		INSERT INTO rent(bnum, uid, overdue) VALUES ('2', '아이디2', false);
		INSERT INTO rent(bnum, uid, overdue) VALUES ('3', '아이디3', false);
		INSERT INTO rent(bnum, uid, overdue) VALUES ('4', '아이디4', false);
        
-- ---------------------------------------------------------------------------------       

CREATE TABLE renttest(
rentnum INT PRIMARY KEY AUTO_INCREMENT,
rentdate DATE,
returndate DATE,
returnschedule DATE,
bnum INT,
uid VARCHAR(20) NOT NULL,
check_out BOOL DEFAULT TRUE,
overdue BOOL DEFAULT FALSE,
FOREIGN KEY (uid) REFERENCES userinfo (uid) ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (bnum) REFERENCES book (bnum) ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (check_out) REFERENCES book (check_out) ON UPDATE CASCADE ON DELETE RESTRICT
);


-- 반납 테이블
CREATE TABLE returnb(
returnnum INT PRIMARY KEY AUTO_INCREMENT,
rentdate DATETIME DEFAULT now(),
returndate DATETIME DEFAULT now(),
bnum INT NOT NULL,
uid VARCHAR(20) NOT NULL
);

SELECT * FROM returnb;
	-- 데이터 적재
		INSERT INTO returnb(bnum, uid) VALUES ('1', '아이디1');
		INSERT INTO returnb(bnum, uid) VALUES ('2', '아이디2');
		INSERT INTO returnb(bnum, uid) VALUES ('3', '아이디3');
		INSERT INTO returnb(bnum, uid) VALUES ('4', '아이디4');

-- 리뷰 테이블
CREATE TABLE review(
revnum INT PRIMARY KEY AUTO_INCREMENT,
bnum INT,
uid VARCHAR(20), 
revtitle VARCHAR(50) NOT NULL,
revcontent VARCHAR(1000) NOT NULL,
revdate DATETIME DEFAULT now(),
revmdate DATETIME DEFAULT null,
FOREIGN KEY (bnum) REFERENCES book (bnum) ON UPDATE CASCADE ON DELETE RESTRICT,
FOREIGN KEY (uid) REFERENCES userinfo (uid) ON UPDATE CASCADE ON DELETE RESTRICT
);

SELECT * FROM review;
SELECT * FROM review WHERE revnum = 1;

	-- 데이터 적재
		INSERT INTO review(bnum, uid, revtitle, revcontent) VALUES ('1', '아이디1', '제목1', '내용1');
		INSERT INTO review(bnum, uid, revtitle, revcontent) VALUES ('2', '아이디2', '제목2', '내용2');
		INSERT INTO review(bnum, uid, revtitle, revcontent) VALUES ('3', '아이디3', '제목3', '내용3');
		INSERT INTO review(bnum, uid, revtitle, revcontent) VALUES ('4', '아이디4', '제목4', '내용4');
		INSERT INTO review(bnum, uid, revtitle, revcontent) VALUES ('5', '아이디5', '제목5', '내용5');
        INSERT INTO review(bnum, uid, revtitle, revcontent, revdate) VALUES ('5', '아이디5', '제목5', '내용5', '2021-03-10');
        UPDATE review SET bnum='3', uid='아이디4' WHERE revnum = '8';
        
        UPDATE review SET bnum='337', revtitle='제목인', revcontent='내용인', revmdate=now() WHERE revnum='3';


-- 수정 : 대여 반납 리뷰 테이블 PK에 auto_increment 추가,  DATE -> DATETIME DEFAULT now() 변경
-- 수정 : 책 테이블 bnum auto_increment 추가