/* 1. 데이터베이스 생성 명령
DB생성시 한글을 쓸 수 있도록 -> default character set utf8;  아직 실행안함*/
create database project default character set utf8;
SET SQL_SAFE_UPDATES = 0; -- 0일때 해제, 1일때 safe -- PK 변경하려고 할떄 사용

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

-- 사용자
INSERT INTO userinfo(uid, uname, upw, upnum, uemail) VALUES('jihun', '지훈', '123', '01011111111', 'jihun@naver.com');
INSERT INTO userinfo(uid, uname, upw, upnum, uemail) VALUES('sungmin', '성민', '123', '01022222222', 'sungmin@naver.com');
INSERT INTO userinfo(uid, uname, upw, upnum, uemail) VALUES('daeun', '다은', '123', '01033333333', 'daeun@naver.com');
INSERT INTO userinfo(uid, uname, upw, upnum, uemail) VALUES('jaewon', '재원', '123', '01044444444', 'jaewon@naver.com');
INSERT INTO userinfo(uid, uname, upw, upnum, uemail) VALUES('sungwoo', '성우', '123', '01055555555', 'sungwoo@naver.com');
-- 관리자
INSERT INTO userinfo(uid, uname, upw, upnum, uemail, utype) VALUES('ict', '개발원', '123', '01077777777', 'ict@daum.net', 1);

-- 대여 버튼 클릭 시 카운팅 증가
UPDATE userinfo SET counting = counting + 1 WHERE uid = 'jihun';
-- 반납 버튼 클릭 시 카운팅 감소
UPDATE userinfo SET counting = counting - 1 WHERE uid = 'jihun';
-- 회원별 리스트 조회
SELECT * FROM userinfo WHERE uid ='jihun';

DROP TABLE userinfo;
SELECT * FROM userinfo;


-- 책 테이블
CREATE TABLE book(
bnum INT PRIMARY KEY AUTO_INCREMENT,
bname VARCHAR(20) NOT NULL, 
bwriter VARCHAR(20) NOT NULL,
bpub VARCHAR(20) NOT NULL,
bcategory VARCHAR(10) NOT NULL,
check_out BOOL DEFAULT FALSE
);

INSERT INTO book(bname, bwriter, bpub, bcategory) values('자바 이해와 활용', '김자바', '명진', '프로그래밍');
INSERT INTO book(bname, bwriter, bpub, bcategory) values('파이썬 정복', '김파이', '한빛미디어', '프로그래밍');
INSERT INTO book(bname, bwriter, bpub, bcategory) values('취업혁명', '김취업', '조선일보사', '취직');
INSERT INTO book(bname, bwriter, bpub, bcategory) values('자바의 정석', '배자바', '도우출판', '프로그래밍');
INSERT INTO book(bname, bwriter, bpub, bcategory) values('파이썬 완벽 가이드', '박파이', '인사이트', '프로그래밍');
INSERT INTO book(bname, bwriter, bpub, bcategory) values('취업과 창업', '장취업', 'MJ미디어', '취직');
INSERT INTO book(bname, bwriter, bpub, bcategory) values('주식의 역사', '이주식', '한국경제신문', '주식');
INSERT INTO book(bname, bwriter, bpub, bcategory) values('주식 투자 솔루션', '채주식', '한국경제신문', '주식');
INSERT INTO book(bname, bwriter, bpub, bcategory) values('토익 클리닉', '신토익', '위드앤위즈덤', '토익');
INSERT INTO book(bname, bwriter, bpub, bcategory) values('토익 급상승 단어장', '박토익', '반석', '토익');
INSERT INTO book(bname, bwriter, bpub, bcategory) values('스프링 부트 시작하기', '김스프', '인사이트', '프로그래밍');
INSERT INTO book(bname, bwriter, bpub, bcategory) values('스프링 입문', '박스프', '한빛미디어', '프로그래밍');

UPDATE book SET check_out = 0 WHERE bnum = 1;
INSERT INTO rental(bnum, check_out) VALUES (1, true);


SELECT * FROM book;
SELECT * FROM book WHERE bname like '%토익%';


-- 대여 버튼 클릭 시 북 다오에서 check_out을 true로 변경해주는 쿼리문
UPDATE book SET check_out = true WHERE bnum = 1;
-- 반납 버튼 클릭 시 북 다오에서 check_out을 false로 변경해주는 쿼리문
UPDATE book SET check_out = false WHERE bnum = 1;
-- 메인페이지 랜덤 도서
SELECT * FROM book ORDER BY RAND() limit 12;

DROP TABLE book;
SELECT * FROM book;


-- 대여/반납 테이블
CREATE TABLE rental(
rentnum INT PRIMARY KEY AUTO_INCREMENT,
rentdate DATE,
returndate DATE,
returnschedule DATE,
bnum INT NOT NULL,
bname VARCHAR(20) NOT NULL,
uid VARCHAR(20) NOT NULL,
check_out BOOL DEFAULT false,
overdue BOOL DEFAULT FALSE
);

INSERT INTO rental(rentdate, returnschedule, bnum, uid, check_out) VALUES (now(), DATE_ADD(NOW(), INTERVAL 14 DAY), 1, '김자바', false);

UPDATE rental SET rentdate = now(), returnschedule = DATE_ADD(NOW(), INTERVAL 14 DAY), check_out = false WHERE rentnum = 2;
UPDATE rental SET rentdate = null, returndate = now(), returnschedule = null, check_out = true WHERE rentnum = 3;
UPDATE rental SET check_out = '0' WHERE bnum = 1;

-- 대출 여부 확인하는 쿼리문
SELECT returndate, check_out FROM rental WHERE bnum = '1' ORDER BY returndate DESC limit 0,1;
-- 대여 버튼 클릭 시 렌트 다오 쿼리문
INSERT INTO rental(rentdate, returnschedule, bnum, bname, uid, check_out) VALUES (now(), DATE_ADD(NOW(), INTERVAL 14 DAY), 1, '자바', '김자바', true);
-- 반납 버튼 클릭 시 렌트 다오 쿼리문
UPDATE rental SET returndate = DATE_ADD(NOW(), INTERVAL 15 DAY), check_out = false WHERE rentnum = 1;
-- 반납 버튼 클릭 시 연체 컬럼 변경 쿼리문(if문은 서블릿에 있음)
UPDATE rental SET overdue = false;
-- 대여 정보 조회 시 해당 사용자만의 대여 목록을 보여주는 쿼리문
SELECT * FROM rental WHERE uid = '김자바';
SELECT returndate FROM rental WHERE bnum=1;
SELECT * FROM rental WHERE uid = '박자바' ORDER BY rentnum DESC limit 1, 10 ;

DROP TABLE rental;
SELECT * FROM rental;

-- 리뷰 테이블
CREATE TABLE review(
revnum INT PRIMARY KEY AUTO_INCREMENT,
bnum INT NOT NULL,
bname VARCHAR(20) NOT NULL,
uid VARCHAR(20), 
revtitle VARCHAR(50) NOT NULL,
revcontent VARCHAR(1000) NOT NULL,
revdate DATETIME DEFAULT now(),
revmdate DATETIME DEFAULT null
);

DROP TABLE review;
SELECT * FROM review;

-- 게시판 테이블
CREATE TABLE request(
	reqnum INT PRIMARY KEY AUTO_INCREMENT,
    country VARCHAR(20) NOT NULL,
    reqtitle VARCHAR(50) NOT NULL,
    bname VARCHAR(20) NOT NULL,         -- booktable
    bwriter VARCHAR(20) NOT NULL,		-- booktable
    bpub VARCHAR(20) NOT NULL,			-- booktable
    bcategory VARCHAR(10) NOT NULL,		-- booktable
    reqid VARCHAR(20) NOT NULL,
    reqcontent VARCHAR(2000) NOT NULL,
    reqstatus BOOL DEFAULT FALSE,
    reqdate DATETIME DEFAULT now(),
    reqmdate DATETIME DEFAULT NULL,
    hit INT DEFAULT 0    
);
-- 페이징 처리
SELECT * FROM request ORDER BY reqnum DESC limit 2, 10;

DROP TABLE request;
SELECT * FROM request;