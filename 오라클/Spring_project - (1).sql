/* ※ 구문 실행시 주의사항
 1. auto 설정 -> 테이블 생성 -> nocache 실행
  (auto부터 실행해야 auto번호가 1부터 시작됨.)
 2. 일부 테이블 drop시 외래키 잡은 테이블부터 날리기 (전체 날리기 구문 : 밑의 구문 역순)
 3. 테이블 drop을 해도 auto는 살아있음,
   그러므로 drop sequence 'auto설정된값'; 을 해줘야함. (밑에 구문 적어놓음)
*/

-- commit 구문을 실행해야 비로소 데이터가 박제됨
commit;

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
SELECT * FROM user_tbl;

-- INSERT 예
INSERT INTO user_tbl (user_num,user_id,user_pw,user_name,user_pnum,user_email) values 
                  (user_num.nextval,'test3','1234','김대현','01012345678','test@naver.com');


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
   
-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ▼ ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

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

-- 시퀀스 해결
alter sequence novel_num nocache; 

-- INSERT 예
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'윤홍기','배심원', 45, '추리', 'free');
                        
                        
-- DELETE 예
DELETE FROM novel_tbl WHERE novel_num = 2;

-- 조회
SELECT * FROM novel_tbl;

-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ▲ ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

-- ★유료소설★
-- auto
CREATE SEQUENCE paid_num;
CREATE SEQUENCE paid_snum;

CREATE TABLE paid_tbl(
    paid_num number(10,0) PRIMARY KEY,
    novel_num number(10,0) not null, -- fk
    paid_snum number(10,0) not null,
    paid_title varchar2(200) not null,
    paid_content CLOB not null,
    paid_rdate date default sysdate,
    paid_mdate date ,
    paid_hit number(10,0) default 0,
    paid_rec number(10,0) default 0,
    paid_price number(10,0) default 1
    );
    
-- 시퀀스 해결
alter sequence paid_num nocache;
alter sequence paid_snum nocache;

-- 외래키   
alter table paid_tbl add constraint fk_paid 
  foreign key (novel_num) references novel_tbl(novel_num);

-- INSERT 예
INSERT INTO paid_tbl (paid_num, novel_num, paid_snum, paid_title, paid_content) values
                        (paid_num.nextval, '2', 10,'대현의소설1편','대현이는 소설을 정말 못써');
                        
-- 조회
SELECT * FROM paid_tbl;


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
    
-- 시퀀스 해결
alter sequence free_num nocache;
alter sequence free_snum nocache;

-- 외래키   
alter table free_tbl add constraint fk_free 
  foreign key (novel_num) references novel_tbl(novel_num);

-- INSERT 예
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '3', 5,'은총의소설1편','은총이는 소설을 정말 못써'); 
                        
-- 조회
SELECT * FROM free_tbl;
         
                        
-- ★ 유료 소설 댓글

CREATE SEQUENCE prepl_num;

CREATE TABLE paid_repl_tbl(
  prepl_num number(10,0) PRIMARY KEY,
  novel_num number(10,0) not null,-- novel_tbl novel_num을 fk
  prepl_fnum number(10,0) not null, -- paid_tbl paid_num을 fk
  prepl_content varchar2(1000) not null,
  prepl_writer varchar2(50) not null,  -- user_tbl user_id를 fk
  prepl_rdate date default sysdate,
  prepl_mdate date
);

-- 시퀀스 해결
alter sequence prepl_num nocache;

-- 외래키 설정

  
alter table paid_repl_tbl add constraint fk_pnovel_num
  foreign key (novel_num) references novel_tbl(novel_num);

alter table paid_repl_tbl add constraint fk_preplyer
  foreign key (prepl_writer) references user_tbl(user_id);  

alter table paid_repl_tbl add constraint fk_repl_pnum
  foreign key (prepl_fnum) references paid_tbl(paid_num);    

-- ★ 무료 소설 댓글
CREATE SEQUENCE frepl_num;

CREATE TABLE free_repl_tbl(
  frepl_num number(10,0) PRIMARY KEY,
  novel_num number(10,0) not null,-- novel_tbl novel_num을 fk
  frepl_fnum number(10,0) not null, -- free_tbl free_num을 fk
  frepl_content varchar2(1000) not null,
  frepl_writer varchar2(50) not null,  -- user_tbl user_id를 fk
  frepl_rdate date default sysdate,
  frepl_mdate date
);

-- 시퀀스 해결
alter sequence frepl_num nocache;

-- 외래키 설정

  
alter table free_repl_tbl add constraint fk_novel_num
  foreign key (novel_num) references novel_tbl(novel_num);

alter table free_repl_tbl add constraint fk_replyer
  foreign key (frepl_writer) references user_tbl(user_id);  

alter table free_repl_tbl add constraint fk_repl_fnum
  foreign key (frepl_fnum) references free_tbl(free_num);

-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ▼ ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

  
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
                        (to_num.nextval,'웹소설 최강자 결승전');
-- 2)
UPDATE tourna_tbl 
    SET to_edate = to_sdate + (INTERVAL '7' DAY)
    WHERE to_num='3';

-- 데이터 삭제
DELETE FROM tourna_tbl WHERE to_num =1;

-- 데이터 수정
UPDATE tourna_tbl
    SET to_sdate = '22/05/13' WHERE to_num=3;

-- 조회
SELECT * FROM tourna_tbl;

SELECT to_sdate + (INTERVAL '1' MONTH) FROM tourna_tbl;


-- ★토너먼트(작품)★
-- auto
CREATE SEQUENCE towork_num;

CREATE TABLE towork_tbl(
  towork_num number PRIMARY KEY,        -- 테이블 번호
  to_num number(10,0),                  -- 토너먼트 번호         fk (tourna_tbl)
  novel_num number(10,0),               -- 작품 번호             fk (novel_tbl)
  towork_rec number(10,0) default 0     -- 추천수
);

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
    SELECT * FROM towork_tbl ORDER BY towork_rec DESC;   -- 2. 1의 결과값에서 rownum이 4미만인(4강) 것들을 가져옴
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
    
    
    -- 정렬
    SELECT * FROM towork_tbl ORDER BY to_num DESC;
    
    DELETE FROM towork_tbl WHERE to_num=2;

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
    


-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ▲ ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■


    
-- ★선호작★
-- auto
CREATE SEQUENCE fav_num;

CREATE TABLE favorite_tbl(
  fav_num number(10,0) PRIMARY KEY,
  novel_num number(10,0), -- fk
  user_num number(10,0) -- fk
);

-- 시퀀스 해결
alter sequence fav_num nocache;

-- 외래키 설정
alter table favorite_tbl add constraint fk_favorite
  foreign key (novel_num) references novel_tbl(novel_num);
  
alter table favorite_tbl add constraint fk_favorite1
  foreign key (user_num) references user_tbl(user_num);
  
-- INSERT 예
INSERT INTO favorite_tbl (fav_num, novel_num, user_num) values
                          (fav_num.nextval,2,1);
-- 조회
SELECT * FROM favorite_tbl;


-- ★책갈피★
-- auto
CREATE SEQUENCE bm_num;

CREATE TABLE bookmark_tbl(
  bm_num number(10,0) PRIMARY KEY,
  novel_num number(10,0), -- fk
  bm_novel_num number(10,0),
  user_num number(10,0) -- fk
);

-- 시퀀스 해결
alter sequence bm_num nocache;

-- 외래키 설정
alter table bookmark_tbl add constraint fk_bookmark
  foreign key (novel_num) references novel_tbl(novel_num);
  
alter table bookmark_tbl add constraint fk_bookmark1
  foreign key (user_num) references user_tbl(user_num);
  
-- INSERT 예
INSERT INTO bookmark_tbl (bm_num, novel_num, bm_novel_num, user_num) values
            (bm_num.nextval, 2, 3, 1);
            
-- 조회
SELECT * FROM bookmark_tbl;


-- ★결제(현금->코인)★
-- auto
CREATE SEQUENCE charge_num;

CREATE TABLE charge_tbl(
  charge_num number(10,0) PRIMARY KEY,
  charge_date date default sysdate,
  user_num number(10,0), -- fk
  charge_price number(10) not null,
  charge_coin number(10),
  charge_coupon number(10)
);

-- 시퀀스 해결
alter sequence charge_num nocache;

-- 외래키 설정
alter table charge_tbl add constraint fk_charge
  foreign key (user_num) references user_tbl(user_num);
  
-- INSERT 예
INSERT INTO charge_tbl (charge_num, user_num, charge_price) values
                      (charge_num.nextval, 1, 500);          
                      
-- 조회
SELECT * FROM charge_tbl;


-- ★쿠폰★
-- auto
CREATE SEQUENCE coupon_num;

CREATE TABLE coupon_tbl(
  coupon_num number(10,0) PRIMARY KEY,
  coupon_value varchar2(20) not null
);

-- 시퀀스 해결
alter sequence coupon_num nocache;
--INSERT 예
INSERT INTO coupon_tbl (coupon_num,coupon_value) values
                      (coupon_num.nextval,'1000원쿠폰');
-- 조회
SELECT * FROM coupon_tbl;


-- ★사용내역(코인->작품구매)★
-- auto
CREATE SEQUENCE use_num;

CREATE TABLE use_tbl(
  use_num number(10,0) PRIMARY KEY,
  user_num number(10,0), -- fk
  use_type varchar2(10) not null,
  use_count number(10) not null,
  use_date date default sysdate
);

-- 시퀀스 해결
alter sequence use_num nocache;

-- 외래키 설정
alter table use_tbl add constraint fk_use
  foreign key (user_num) references user_tbl(user_num);
  
-- INSERT 
INSERT INTO use_tbl (use_num, user_num, use_type, use_count) values
                    (use_num.nextval, 1, '코인', '100');       
                    
-- 조회
SELECT * FROM use_tbl;


-------------------------------------------------

-- ※테이블 날리기(역순으로 실행)※ 15
DROP TABLE user_tbl;
DROP TABLE auth_tbl;
DROP TABLE novel_tbl;
DROP TABLE paid_tbl;
DROP TABLE free_tbl;
DROP TABLE free_board_tbl;
DROP TABLE repl_sort_tbl;
DROP TABLE repl_tbl;
DROP TABLE tourna_tbl;
DROP TABLE towork_tbl;
DROP TABLE favorite_tbl;
DROP TABLE bookmark_tbl;
DROP TABLE charge_tbl;
DROP TABLE coupon_tbl;
DROP TABLE use_tbl;


-- ※시퀀스(auto)삭제※ 17
DROP SEQUENCE user_num;
DROP SEQUENCE auth_num;
DROP SEQUENCE novel_num;
DROP SEQUENCE paid_num;
DROP SEQUENCE paid_snum;
DROP SEQUENCE free_num;
DROP SEQUENCE free_snum;
DROP SEQUENCE free_board_num;
DROP SEQUENCE repl_sort_num;
DROP SEQUENCE repl_num;
DROP SEQUENCE to_num;
DROP SEQUENCE towork_num;
DROP SEQUENCE fav_num;
DROP SEQUENCE bm_num;
DROP SEQUENCE charge_num;
DROP SEQUENCE coupon_num;
DROP SEQUENCE use_num;