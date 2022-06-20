/* 1. 데이터베이스 생성 명령
DB생성시 한글을 쓸 수 있도록 -> default character set utf8;  아직 실행안함*/
create database project default character set utf8;
SET SQL_SAFE_UPDATES = 0; -- 0일때 해제, 1일때 safe -- PK 변경하려고 할떄 사용

DROP TABLE book;
DROP TABLE rental;
DROP TABLE review;
DROP TABLE userinfo;
DROP TABLE request;




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
		INSERT INTO userinfo(uid, uname, upw, upnum, uemail) VALUES ('아이디11', '이름1', '비번11', '01000000001', 'email1@naver.com');
		INSERT INTO userinfo(uid, uname, upw, upnum, uemail) VALUES ('아이디22', '이름2', '비번22', '01000000002', 'email2@naver.com');

	-- 관리자 데이터 적재
		INSERT INTO userinfo(uid, uname, upw, upnum, uemail, utype) VALUES('아이디0', '관리자1', '비번0', '01000000000', 'email0@naver.com', '1');
		INSERT INTO userinfo(uid, uname, upw, upnum, uemail, utype) VALUES('아이디00', '관리자2', '비번00', '01000000000', 'email0@naver.com', '1');


INSERT INTO userinfo(uid, uname, upw, upnum, uemail) VALUES('김자바', 'ㅇㅇㅇ', '123', '0102222', '12312@qwe');
INSERT INTO userinfo(uid, uname, upw, upnum, uemail) VALUES('박자바', 'ㅇㅇㅇ', '123', '0102222', '12312@qwe');

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
        
		INSERT INTO book(bname, bwriter, bpub, bcategory) VALUES('자바왕의 자바 일기', '저자1', '출판사1', '스릴러');
		INSERT INTO book(bname, bwriter, bpub, bcategory) VALUES('자바지입으렴', '저자2', '출판사2', '로맨스');

INSERT INTO book(bname, bwriter, bpub, bcategory) values('자바', '김자바', '이클립스', 'java');
INSERT INTO book(bname, bwriter, bpub, bcategory) values('파이썬', '김파이', '파이썬', 'python');
UPDATE book SET check_out = 0 WHERE bnum = 1;
INSERT INTO rental(bnum, check_out) VALUES (1, true);

-- 대여 버튼 클릭 시 북 다오에서 check_out을 true로 변경해주는 쿼리문
UPDATE book SET check_out = true WHERE bnum = 1;
INSERT INTO book(bname, bwriter, bpub, bcategory) values('자바', '김자바', '이클립스', 'java') ON DUPLICATE KEY UPDATE check_out = true;
-- 반납 버튼 클릭 시 북 다오에서 check_out을 false로 변경해주는 쿼리문
UPDATE book SET check_out = false WHERE bnum = 2;

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



SELECT * FROM rental;
SELECT * FROM rental WHERE uid='아이디1' AND bnum='4';

	-- 렌탈 데이터 적재
INSERT INTO rental(rentdate, returnschedule, bnum, bname, uid, check_out) VALUES (now(), DATE_ADD(NOW(), INTERVAL 14 DAY), 1, '자바자바', '김자바', true);
INSERT INTO rental(rentdate, returnschedule, bnum, bname, uid, check_out) VALUES (now(), DATE_ADD(NOW(), INTERVAL 14 DAY), 2, '2런2런', '김자바', true);
INSERT INTO rental(rentdate, returnschedule, bnum, bname, uid, check_out) VALUES (now(), DATE_ADD(NOW(), INTERVAL 14 DAY), 3, '오징어볶음 만들기', '김자바', true);
INSERT INTO rental(rentdate, returnschedule, bnum, bname, uid, check_out) VALUES (now(), DATE_ADD(NOW(), INTERVAL 14 DAY), 4, '태국 코끼리 밥 주는 방법', '아이디1', true);
INSERT INTO rental(rentdate, returnschedule, bnum, bname, uid, check_out) VALUES (now(), DATE_ADD(NOW(), INTERVAL 14 DAY), 5, '비건 아이스크림', '아이디1', true);

SELECT check_out FROM rental WHERE bnum = ? ORDER BY rentdate DESC limit 0, 1;


UPDATE rental SET rentdate = now(), returnschedule = DATE_ADD(NOW(), INTERVAL 14 DAY), check_out = false WHERE rentnum = 2;
UPDATE rental SET rentdate = null, returndate = now(), returnschedule = null, check_out = true WHERE rentnum = 3;
UPDATE rental SET check_out = '0' WHERE bnum = 1;

-- 대출 여부 확인하는 쿼리문
SELECT returndate, check_out FROM rental WHERE bnum = '1' ORDER BY returndate DESC limit 0,1;

-- 대여 버튼 클릭 시 렌트 다오 쿼리문
INSERT INTO rental(rentdate, returnschedule, bnum, uid, check_out) VALUES (now(), DATE_ADD(NOW(), INTERVAL 14 DAY), 1, '김자바', true);
-- 반납 버튼 클릭 시 렌트 다오 쿼리문
UPDATE rental SET returndate = now(), check_out = false WHERE rentnum = 1;
-- 반납 버튼 클릭 시 연체 컬럼 변경 쿼리문(if문은 서블릿에 있음)
UPDATE rental SET overdue = false;
-- 대여 정보 조회 시 해당 사용자만의 대여 목록을 보여주는 쿼리문
SELECT * FROM rental WHERE uid = '김자바';
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

SELECT * FROM review;

	-- 리뷰 테이블 적재
	INSERT INTO review(bnum, bname, uid, revtitle, revcontent) VALUES('1', '책1', '아이디1', '제목1', '내용1');
	INSERT INTO review(bnum, bname, uid, revtitle, revcontent) VALUES('2', '책2', '아이디1', '제목1', '내용1');
	INSERT INTO review(bnum, bname, uid, revtitle, revcontent) VALUES('3', '책3', '아이디1', '제목1', '내용1');
	INSERT INTO review(bnum, bname, uid, revtitle, revcontent) VALUES('4', '책4', '아이디1', '제목1', '내용1');
	INSERT INTO review(bnum, bname, uid, revtitle, revcontent) VALUES('5', '책5', '아이디1', '제목1', '내용1');
	INSERT INTO review(bnum, bname, uid, revtitle, revcontent) VALUES('1', '책1', '아이디1', '제목2', '내용1');

DROP TABLE review;
SELECT * FROM review;

SELECT * FROM review WHERE revtitle LIKE '%제목%';
SELECT * FROM review WHERE bname LIKE '%자바%';
SELECT * FROM review WHERE revtitle LIKE '%자바%';
SELECT * FROM review WHERE bname like '%자바%';

SELECT * FROM review WHERE uid ='아이디2';

-- 희망 도서 신청
-- 글번호, 국가(선택), 제목, 도서명, 저자, 신청사유(내용), 신청 상태(대기중, 구매완료), 작성일, 수정일, 조회수




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

SELECT * FROM request;
SELECT * FROM book;
SELECT * FROM userinfo;

INSERT INTO request(country, reqtitle, bname, bwriter, bpub, bcategory, reqid, reqcontent) 
	VALUES ('영미', '요청제목1', '책이름1', '저자1', '출판사1', '카테고리1', '아이디1', '내용1');
    
UPDATE request SET country='나라', reqtitle='제목', bname='책', bwriter='저자', bpub='출판사', bcategory='출판사', reqcontent='내용', reqmdate=now() WHERE reqnum='2';

UPDATE request SET hit = (hit + 1) WHERE reqnum = 1;

DELETE FROM request WHERE reqnum = 1;

UPDATE request SET reqstatus = true WHERE reqnum = 4;
