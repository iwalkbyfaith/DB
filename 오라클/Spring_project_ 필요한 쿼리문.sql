-- ■ 필요한 쿼리문만 저장해 놓은 

        -- 순서
            -- ★유저★
            -- ★소설(공통)★
            -- ★토너먼트(대회)★
            -- ★토너먼트(작품)★
            -- ★토너먼트(대회/작품 유저 추천 기록)★
        



-- ★유저★
-- auto
CREATE SEQUENCE user_num;

CREATE TABLE user_tbl(
  user_num number(10,0) PRIMARY key,
  user_id varchar2(20) unique,
  user_pw varchar2(20) not null,
  user_name varchar2(10) not null,
  user_pnum varchar2(15) not null,
  user_email varchar2(30) not null,
  user_coin number(10,0) default 0,
  user_coupon number(10,0) default 0,
  user_rdate date default sysdate,
  user_auth_mdate date default sysdate,
  user_enabled char(1) default '1'
  );

-- 시퀀스 해결
alter sequence user_num nocache; 

-- 조회
SELECT * FROM user_tbl ORDER BY user_num DESC;

DELETE FROM user_tbl WHERE user_id like 'user%';

-- INSERT 예                    -아이디  - 비번   - 이름     -폰번호    -이메일
INSERT INTO user_tbl (user_num, user_id, user_pw, user_name, user_pnum, user_email) values 
                  (user_num.nextval,'id012','pw012','김십이','01012345678','test012@naver.com');
                  
commit;

-- 비밀번호 암호화를 위해 비밀번호의 자리수를 늘림
ALTER TABLE user_tbl MODIFY user_pw varchar2(100);
ALTER TABLE user_tbl MODIFY user_name varchar2(30);
commit;

-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ▲ ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■


-- ★회원등급★   
-- auto
CREATE SEQUENCE auth_num;

CREATE TABLE auth_tbl(
auth_num number(10,0) PRIMARY key,
user_id varchar2(20),-- fk
auth varchar2(20) not null
);

-- 시퀀스 해결
alter sequence auth_num nocache; 

-- 외래키 설정
alter table auth_tbl add constraint fk_auth foreign key (user_id) references user_tbl(user_id);

-- INSERT 예
INSERT INTO auth_tbl (auth_num,user_id,auth) values 
                       (auth_num.nextval,'test3','운영자');         
-- 조회
select*from auth_tbl;                  

-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ▲ ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
              
                  
-- ★소설(공통)★
-- auto
CREATE SEQUENCE novel_num;

CREATE TABLE novel_tbl(
    novel_num number(10,0) PRIMARY KEY,
    novel_writer varchar2(50) not null,
    novel_title varchar2(200) not null,
    novel_tsnum number(10,0) default 0,         -- 총 연재편수
    novel_category varchar2(10) not null,
    novel_week varchar2(10) not null,
    novel_end char(1) default '0'
);

-- ※ 변경사항) 소설 테이블에 user_id 추가하고 외래키 지정해야함.
    ALTER TABLE novel_tbl ADD user_id varchar2(20);
    ALTER TABLE novel_tbl ADD CONSTRAINT fk_novel FOREIGN KEY (user_id) REFERENCES user_tbl(user_id);

    -- 추가한 user_id에 아이디 채워줌 ( 가능 : user10~user19 )
        UPDATE novel_tbl SET user_id = 'user10' WHERE novel_num = 59;
        UPDATE novel_tbl SET user_id = 'user11' WHERE novel_num = 58;
        UPDATE novel_tbl SET user_id = 'user12' WHERE novel_num = 57;
        UPDATE novel_tbl SET user_id = 'user13' WHERE novel_num = 56;
        UPDATE novel_tbl SET user_id = 'user14' WHERE novel_num = 55;
        UPDATE novel_tbl SET user_id = 'user15' WHERE novel_num = 52;
        UPDATE novel_tbl SET user_id = 'user16' WHERE novel_num = 51;
        UPDATE novel_tbl SET user_id = 'user17' WHERE novel_num = 50;
        UPDATE novel_tbl SET user_id = 'user18' WHERE novel_num = 49;
        UPDATE novel_tbl SET user_id = 'user19' WHERE novel_num = 48;   
    
    -- 아이디 추가하고 not null로 속성 변경하기
        ALTER TABLE novel_tbl MODIFY user_id varchar2(20) NOT NULL;

    SELECT * FROM novel_tbl;
    
    commit;
    
-- 시퀀스 해결
alter sequence novel_num nocache; 

-- INSERT 예
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week, user_id) values
                        (novel_num.nextval,'작가','소설제목', 100, 'wuxia', 'Mon', 'user10');
                        
                        
-- DELETE 예
DELETE FROM novel_tbl WHERE novel_num = 2;

-- 조회
SELECT * FROM novel_mtbl;


-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ▲ ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■


-- ★무료소설★
-- auto
CREATE SEQUENCE free_num;
CREATE SEQUENCE free_snum;

CREATE TABLE free_tbl(
    free_num number(10,0) PRIMARY KEY,
    novel_num number(10,0) not null, -- fk
    free_snum number(10,0) not null,
    free_title varchar2(200) not null,
    free_content CLOB not null,
    free_rdate date default sysdate,
    free_mdate date ,
    free_hit number(10,0) default 0,
    free_rec number(10,0) default 0
    );
    
 alter table free_tbl modify free_title varchar2(200);   
 
-- 시퀀스 해결
alter sequence free_num nocache;
alter sequence free_snum nocache;

-- 외래키   
alter table free_tbl add constraint fk_free 
  foreign key (novel_num) references novel_tbl(novel_num);
  
commit;
-- INSERT 예
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '19', 1,'흑백-제1장-1화','무제'); -- free_title 20글자가 아님..?
                        
-- 조회
SELECT * FROM free_tbl;
drop table free_tbl;


SELECT free_rec FROM free_tbl;


-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ▲ ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

DROP SEQUENCE to_num;
DROP SEQUENCE towork_num;
DROP SEQUENCE torec_num;

DROP TABLE tourna_tbl;
DROP TABLE towork_tbl;
DROP TABLE torec_tbl;

 
 
-- ★토너먼트(대회)★
-- auto
CREATE SEQUENCE to_num;

CREATE TABLE tourna_tbl(
  to_num number(10,0) PRIMARY KEY,     -- 대회 번호
  to_name varchar2(50) not null,       -- 대회 이름
  to_sdate date default sysdate,       -- 시작 날짜
  to_edate date                        -- 종료 날짜
);

-- 시퀀스 해결
alter sequence to_num nocache;

--INSERT 순서
-- 1)
INSERT INTO tourna_tbl (to_num, to_name) values 
                        (to_num.nextval,'다음 대회 준비기간');
                        
-- 2)
UPDATE tourna_tbl 
    SET to_edate = to_sdate + (INTERVAL '7' DAY)
    WHERE to_num='4';

-- 데이터 삭제
DELETE FROM tourna_tbl WHERE to_num =1;

-- 데이터 수정
UPDATE tourna_tbl
    SET to_sdate = '22/05/13' WHERE to_num=3;  
    
    -- 8강 데이터 보이게
    UPDATE tourna_tbl SET to_sdate ='22/04/28', to_edate = '22/05/29' WHERE to_num=1; 
    -- 8강 되돌리기
    UPDATE tourna_tbl SET to_sdate = '22/04/27', to_edate='22/05/04' WHERE to_num=1; 
    
    -- 4강 데이터 보이게
    UPDATE tourna_tbl SET to_edate = '22/05/29' WHERE to_num=2; 
    -- 4강 되돌리기
    UPDATE tourna_tbl SET to_sdate = '22/05/05', to_edate='22/05/12' WHERE to_num=2; 
     
    -- 2강 데이터 안 보이게
    UPDATE tourna_tbl SET to_sdate = '22/05/29' WHERE to_num=3; 
    -- 2강 되돌리기
    UPDATE tourna_tbl SET to_sdate = '22/05/13', to_edate='22/05/20' WHERE to_num=3; 

    -- 휴식기
    UPDATE tourna_tbl SET to_sdate = '22/05/21', to_edate='22/05/28' WHERE to_num=4;
commit;

-- 조회
SELECT * FROM tourna_tbl;

SELECT to_sdate + (INTERVAL '1' MONTH) FROM tourna_tbl;





-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ▲ ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

-- ★토너먼트(작품)★
-- auto
CREATE SEQUENCE towork_num;

CREATE TABLE towork_tbl(
  towork_num number PRIMARY KEY,        -- 테이블 번호
  to_num number(10,0),                  -- 토너먼트 번호         fk (tourna_tbl)
  novel_num number(10,0),               -- 작품 번호             fk (novel_tbl)
  towork_rec number(10,0) default 0 
);

commit;


UPDATE towork_tbl SET towork_rec=85 WHERE towork_num=597;
UPDATE towork_tbl SET towork_rec=86 WHERE towork_num=596;

SELECT * FROM towork_tbl ORDER BY towork_num DESC;

-- 시퀀스 해결
alter sequence towork_num nocache;

-- 외래키 설정
alter table towork_tbl add constraint fk_towork
  foreign key (to_num) references tourna_tbl(to_num);
 
 alter table towork_tbl add constraint fk_towork1
  foreign key (novel_num) references novel_tbl(novel_num);
  
-- INSERT 예                        -대회번호 -작품번호
INSERT INTO towork_tbl (towork_num, to_num, novel_num) values
                        (towork_num.nextval,1,16);

DELETE FROM towork_tbl WHERE towork_num=5;
                
-- 조회
SELECT * FROM towork_tbl;
SELECT * FROM towork_tbl tt INNER JOIN novel_tbl nt ON tt.novel_num = nt.novel_num;



-- 특정 컬럼만 가져오기
SELECT tt.QCSJ_C000000000400000 as to_num, tt.to_name, tt.towork_num, nt.novel_title, nt.novel_writer, tt.towork_rec
    FROM 
        (SELECT * FROM tourna_tbl INNER JOIN towork_tbl ON tourna_tbl.to_num = towork_tbl.to_num) tt
        INNER JOIN 
        novel_tbl nt 
    ON tt.novel_num = nt.novel_num; -- WHERE tt.QCSJ_C000000000400000=2;

-- 다 가져오기
SELECT *
FROM 
    (SELECT * FROM tourna_tbl INNER JOIN towork_tbl ON tourna_tbl.to_num = towork_tbl.to_num) tt
    INNER JOIN 
    novel_tbl nt 
ON tt.novel_num = nt.novel_num ;

SELECT * FROM tourna_tbl INNER JOIN towork_tbl ON tourna_tbl.to_num = towork_tbl.to_num;
SELECT * FROM tourna_tbl INNER JOIN towork_tbl ON tourna_tbl.to_num = towork_tbl.to_num;
SELECT * FROM novel_tbl;


-- 8강에 간 작품들 4강에 갔을때도 추천수가 같도록 유지하기 (to_num이 1, 2로 다름)

    -- 1. 대회번호(to_num)이 1(8강)이고, 작품번호(novel_num)이 1인 작품의 추천수 구하기
    SELECT towork_rec FROM towork_tbl WHERE to_num =1 AND novel_num=1;
    -- 2. 작품 번호를 입력 받아, 대회번호(to_num)가 2(4강)일때, 1에서 얻어온 추천수를 업데이트 해줌
    UPDATE towork_tbl SET towork_rec = (SELECT towork_rec FROM towork_tbl WHERE to_num =1 AND novel_num=1) WHERE to_num=2 AND novel_num=1;

 
-- ▶▶▶▶ 아니면 아예 2, 4 강을 비활성화 한 다음, 버튼을 누르면 상위 2, 4개가 그 즉시 해당 테이블에 적재되는 식으로..?
    -- 1. 추천수 별로 내림차순
    SELECT * FROM towork_tbl ORDER BY towork_rec DESC;   
    -- 2. 1의 결과값에서 rownum이 4미만인(4강) 것들을 가져옴
    SELECT * FROM (SELECT * FROM towork_tbl ORDER BY towork_rec DESC) WHERE rownum <= 4;
    -- 3. 2의 결과를 테이블에 새로 적재(어쩔수 없이 towork_num은 새로 받음)
        -- 3.1 to_num에는 2(4강), 3(2강)이 들어옴
        -- 3.2 안쪽 WHERE로 to_num-1의 조건을 줌, 2(4강)일 경우 2-1(8강)에서만, 3(2강)일 경우 3-1(4강)에서만
        -- 3.3 바깥쪽 WHERE절에서는 to_num이 2(4강)일 경우 rownum이 4 이하, 3(2강)일 경우 2 이하로 줌.
    INSERT INTO towork_tbl(towork_num, to_num, novel_num, towork_rec)
        SELECT 
    towork_num.nextval, 3, novel_num, towork_rec
        FROM 
    (SELECT * FROM (SELECT * FROM towork_tbl WHERE to_num = 3 - 1 ORDER BY towork_rec DESC) WHERE rownum <= 2);
    
    
   
    commit;
    
     -- 정렬
    SELECT * FROM towork_tbl ORDER BY to_num DESC;                              -- ◀◀◀ 조회 : 대회 작품 테이블
    SELECT * FROM torec_tbl ORDER BY torec_num DESC;                            -- ◀◀◀ 조회 : 작품 추천 기록 테이블
    
    
    DELETE FROM towork_tbl WHERE to_num=2;
    DELETE FROM towork_tbl WHERE to_num=3;                                      -- ◀◀◀ 삭제 : 대회 작품 테이블
    
    DELETE FROM torec_tbl WHERE user_id = 'id012';                              -- ◀◀◀ 삭제 : 작품 추천 기록 테이블
    DELETE FROM torec_tbl WHERE to_num=1;
    DELETE FROM torec_tbl WHERE to_num=2;
    DELETE FROM torec_tbl WHERE to_num=3;

    -- !!!!!!!!!!!!!!!!!!!!!! 커밋을 생활화 하자 !!!!!!!!!!!!!!!!!!!!
    commit;
    
    
    -- 예상 우승 작품 가져오기
        -- 1.
        SELECT tt.to_num, tt.towork_num, nt.novel_title, nt.novel_writer, tt.towork_rec FROM towork_tbl tt INNER JOIN novel_tbl nt ON tt.novel_num = nt.novel_num;
        -- 2.
        SELECT * 
            FROM 
        (SELECT tt.to_num, tt.towork_num, nt.novel_title, nt.novel_writer, tt.towork_rec FROM towork_tbl tt INNER JOIN novel_tbl nt ON tt.novel_num = nt.novel_num ORDER BY towork_rec DESC) 
            WHERE 
        rownum <= 1;
       
        
    -- 2강, 4강에 오른 작품들 가져오기
        SELECT * FROM (SELECT tt.to_num, tt.towork_num, nt.novel_title, nt.novel_writer, tt.towork_rec FROM towork_tbl tt INNER JOIN novel_tbl nt ON tt.novel_num = nt.novel_num) WHERE to_num=2;
 
 
 
    -- 참여하기 버튼 누르면 무조건 적재되지 않도록하기
        -- 1. 해당 대회의 기록이 있다면 되지 않도록
        SELECT * FROM towork_tbl WHERE to_num=2;
 

 
 
 
 
 
 
 
 
 
 
 
 
-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ▲ ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 

-- ★토너먼트(대회/작품 유저 추천 기록)★

    -- 번호, 유저 아이디(유저 번호가 pk이긴 한데 아이디도 유니크니까), 토너먼트 번호, 작품 번호, 추천 날짜 
    
    -- auto
    CREATE SEQUENCE torec_num;
    
    CREATE TABLE torec_tbl(
        torec_num number PRIMARY KEY,       -- 번호
        user_id varchar2(20),               -- 유저 아이디        fk(user_tbl)
        to_num number(10,0),                -- 토너먼트 번호      fk(tourna_tbl)
        towork_num number,                  -- 토너먼트 작품 번호 fk(towork_tbl)
        rec_date date default sysdate       -- 추천일
    );
    
    -- ★ 컬럼 추가
    ALTER TABLE torec_tbl ADD novel_num number(10,0) DEFAULT 0 NOT NULL;
    alter table torec_tbl add constraint fk_torec4
        foreign key (novel_num) references novel_tbl(novel_num);
    
    -- 시퀀스 해결
    alter sequence torec_num nocache;
    
    -- 외래키 설정
    alter table torec_tbl add constraint fk_torec1
        foreign key (user_id) references user_tbl(user_id);
        
    alter table torec_tbl add constraint fk_torec2
        foreign key (to_num) references tourna_tbl(to_num);
        
    alter table torec_tbl add constraint fk_torec3
        foreign key (towork_num) references towork_tbl(towork_num);
    
    drop table torec_tbl;
    
    -- 테이블 조회
    SELECT * FROM torec_tbl ORDER BY torec_num DESC;
    
    -- 데이터 삭제
    DELETE FROM torec_tbl WHERE user_id = 'id012';
    DELETE FROM torec_tbl WHERE to_num =1;
    
    commit;
    
    -- 추천 기록 깔끔하게 보기
         -- 1. 출전작품-추천기록을 inner join 함
         SELECT tt.*, twt.novel_num, twt.towork_rec FROM torec_tbl tt INNER JOIN towork_tbl twt ON tt.towork_num = twt.towork_num;
         -- 2. 1의 결과를 노블 테이블과 inner join 함
             -- 토너먼트번호  -추천번호   - 대회참여번호 -추천아이디  - 소설번호   - 소설 제목      - 추천일
         SELECT jt.to_num, jt.torec_num, jt.towork_num, jt.user_id, jt.novel_num, nt.novel_title, jt.towork_rec as 추천수, jt.rec_date 
            FROM 
        (SELECT tt.*, twt.novel_num, twt.towork_rec FROM torec_tbl tt INNER JOIN towork_tbl twt ON tt.towork_num = twt.towork_num) jt
            INNER JOIN 
        novel_tbl nt 
            ON
        nt.novel_num = jt.novel_num
            ORDER BY
        jt.torec_num DESC;
    
    -- 적재 시도                           -토너먼트 번호 -토너먼트작품번호
    INSERT INTO torec_tbl (torec_num, user_id, to_num, towork_num) 
        VALUES (torec_num.nextval, 'id001', 1, 252);
        
    INSERT INTO torec_tbl (torec_num, user_id, to_num, towork_num) 
        VALUES (torec_num.nextval, 'id002', 1, 257);
    
     commit;
     
     
     -- 로그인한 유저가 해당 토너먼트의 추천 기록이 있는지 확인
        -- 리턴된 to_num에 1이 있다면 8강 버튼 비활성화
        -- 리턴된 to_num에 2이 있다면 4강 버튼 비활성화
        -- 리턴된 to_num에 3이 있다면 2강 버튼 비활성화
     SELECT towork_num, user_id FROM torec_tbl WHERE user_id = 'id001' AND to_num=1;
     
    SELECT towork_num, user_id FROM torec_tbl WHERE user_id = 'id001' AND to_num= 1;
    
    SELECT towork_num, user_id FROM torec_tbl WHERE to_num=1 AND user_id = 'id002';
    
    
 
 
 
 select * from tourna_tbl;
 select * from towork_tbl;
 select * from torec_tbl;
        
        
        
        
        
        
        
    
    
