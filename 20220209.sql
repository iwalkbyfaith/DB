
-- 테이블을 만들어주세요
-- 테이블 이름 : userinfo
-- name 7글자 회원이름
-- uid 20글자 회원아이디 primary key
-- upw 20글자 회원 비밀번호
-- uemail 20글자 회원이메일


CREATE TABLE userinfo(
		uname VARCHAR(7),
		uid VARCHAR(20) primary key,
		upw VARCHAR(20),
        uemail VARCHAR(20)
	);

-- 잘못 만들어서 테이블 날림
	drop table userinfo;

-- 유저 4명을 입력해주세요
-- 2명은 이메일 O, 2명은 X

	INSERT INTO userinfo VALUES ('김민지', 'id119', 'bangbang', 'id119@naver.com');
	INSERT INTO userinfo VALUES ('박만득', 'lovelovelove', 'love', 'love333@gmail.com');

-- 이메일 안 넣기 방법 1) 컬럼명 적어주기
	INSERT INTO userinfo(uname, uid, upw) VALUES ('신세령', 'mjmmjz', 'serrry');
-- 이메일 안 넣기 방법 2) null 처리
	INSERT INTO userinfo VALUES ('최혜빈', 'hbhhb', 'hb1234', null);

-- 전체 조회
select * from userinfo;
-- 조회
select * from userinfo where uid='fdsfef';
-- 적재
INSERT INTO userinfo VALUES ('name', 'id', 'password', 'email');
INSERT INTO userinfo VALUES ('진짜수정됨', 'javajsp', '1234', 'realup@date.com');
-- 삭제
DELETE FROM userinfo WHERE uid='아이디에요';
-- 수정
UPDATE userinfo SET uname ='마제리' WHERE uid='mjmmj';
UPDATE userinfo SET uname ='name1', upw='pw1', uemail='email1' WHERE uid='id';
