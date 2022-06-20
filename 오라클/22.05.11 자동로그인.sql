-- 22.05.11 자동 로그인 ('리멤버미' 기능 이라고 부름)


-- 시퀀스 생성
CREATE SEQUENCE persistent_logins_num;

-- 테이블 생성문
CREATE TABLE persistent_logins(
    username varchar(64) not null,
    series varchar(64) primary key,
    token varchar(64) not null,
    last_used timestamp not null
);

-- 시퀀스 해결
alter sequence persistent_logins_num nocache; 

-- 조회
SELECT * FROM persistent_logins;



SELECT * FROM member_tbl;