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
  user_pw varchar2(100) not null,
  user_name varchar2(30) not null,
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
SELECT * FROM user_tbl ORDER BY user_num;

-- INSERT 예
INSERT INTO user_tbl (user_num,user_id,user_pw,user_name,user_pnum,user_email) values 
                  (user_num.nextval,'test3','1234','김대현','01012345678','test@naver.com');
                  
--delete from user_tbl;                  

commit;

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
select*from auth_tbl ORDER BY auth_num;  


--delete from auth_tbl;

commit;
                           

-- ★소설(공통)★
-- auto
CREATE SEQUENCE novel_num;

CREATE TABLE novel_tbl(
    novel_num number(10,0) PRIMARY KEY,
    user_id varchar2(20) not null,  -- user_tbl에서 user_id를 fk
    novel_writer varchar2(50) not null,
    novel_title varchar2(200) not null,
    novel_tsnum number(10,0) default 0,
    novel_category varchar2(10) not null,
    novel_week varchar2(10) not null,
    novel_end char(1) default '0'
);

-- 시퀀스 해결
alter sequence novel_num nocache; 

-- INSERT 예
-- ★ 유료 소설 데이터 적재 
INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '놀마', 'paidWriter0', '미친 중독', 10, 'romance', 'Mon');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '백묘', 'paidWriter1', '꽃이 삼킨 짐승', 10, 'romance', 'Mon');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '죽음을 희망합니다', 'paidWriter2', '죽음을 희망합니다', 10, 'romance', 'Mon');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                    (novel_num.nextval,'이흰','paidWriter0','베이비폭군', 5, 'romance', 'Tue'); 

INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                    (novel_num.nextval,'박수정','paidWriter1','어린상사', 5, 'romance', 'Tue');                     

INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                    (novel_num.nextval,'코양희','paidWriter2','후궁으로 깨어나다', 5, 'romance', 'Tue');                     
                    
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'플아다','paidWriter1','날 닮은 아이',10, 'romance', 'Wed');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'알파타르트','paidWriter2','하렘의 남자들',10, 'romance', 'Wed');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'빠양이','paidWriter0','강제 맞선',10, 'romance', 'Wed');  -- ※ 올려주신 더미 데이터 보고 수정함

INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'오윤화','paidWriter1','남편과 이혼하겠습니다',10, 'fantasy', 'Thu');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'달콤한홍차', 'paidWriter2', '신랑이 바뀐 나의 영혼',10, 'fantasy', 'Thu');

INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'로즈빈','paidWriter0','사랑같은건 처음',10, 'fantasy', 'Thu');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'백묘','paidWriter1','꽃이 삼킨 짐승',10, 'fantasy', 'Fri');

INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'문백경','paidWriter2','역대급 영지 설계사',10, 'fantasy', 'Fri');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'꽃제이','paidWriter0','더캐슬',10, 'fantasy', 'Fri');
                        
select * from novel_tbl;
-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

-- ★ 무료 소설 데이터 적재 
INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '싱숑', 'freeWriter0', '전지적 독자 시점', 10, 'fantasy', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '김언희', 'freeWriter0', '이섭의연애', 10, 'romance', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '한중월야', 'freeWriter0', '나노마신', 10, 'wuxia', 'free');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                    (novel_num.nextval,'히가시노 게이고','freeWriter0','나미야 잡화점의 기적', 5, 'mystery', 'free'); 

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '추공', 'freeWriter1', '나 혼자만 레벨업', 10, 'fantasy', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '비가', 'freeWriter1', '화산귀환', 10, 'romance', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '우각', 'freeWriter1', '십전제', 10, 'wuxia', 'free');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                    (novel_num.nextval,'아오야마 고쇼','freeWriter1','명탐정 코난', 5, 'mystery', 'free'); 
                    
INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '김정률', 'freeWriter2', '다크메이지', 10, 'fantasy', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '문지효', 'freeWriter2', '남편이 돌아왔다', 10, 'romance', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '태규', 'freeWriter2', '천라신조', 10, 'wuxia', 'free');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                    (novel_num.nextval,'사토 후미야','freeWriter2','소년탐정 김전일', 5, 'mystery', 'free'); 

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '료우진', 'freeWriter3', '메모라이즈', 10, 'fantasy', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '박영', 'freeWriter3', '겨울문방구', 10, 'romance', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '김강현', 'freeWriter3', '마신전생기', 10, 'wuxia', 'free');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                    (novel_num.nextval,'아서 코난 도일','freeWriter3','셜록홈즈', 5, 'mystery', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '이그니시스', 'freeWriter4', '리셋라이프', 10, 'fantasy', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '서혜은', 'freeWriter4', '우리가 헤어지는 이유', 10, 'romance', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '강영호', 'freeWriter4', '절대강호', 10, 'wuxia', 'free');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                    (novel_num.nextval,'엘러리퀸','freeWriter4','Y의비극', 5, 'mystery', 'free'); 
                    

commit;
                        
-- DELETE 예
DELETE FROM novel_tbl;

-- 조회
SELECT * FROM novel_tbl order by novel_num;

commit;


-- ★유료소설★
-- auto
CREATE SEQUENCE paid_num;
CREATE SEQUENCE paid_snum;

CREATE TABLE paid_tbl(
    paid_num number(10,0) PRIMARY KEY,
    novel_num number(10,0) not null, -- fk
    paid_snum number(10,0) not null,
    paid_title varchar2(200) not null,
    paid_content1 CLOB not null,
    paid_content2 CLOB,
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


-- ★ 유료소설 추천 테이블
CREATE SEQUENCE rec_num;

CREATE TABLE paid_rec_tbl(
  rec_num number(10,0) primary key,
  user_num number(10,0) not null,
  paid_num number(10,0) not null
);
-- 시퀀스 해결
alter sequence rec_num nocache;

-- 외래키
alter table paid_rec_tbl add constraint fk_user_num
  foreign key (user_num) references user_tbl(user_num);  

alter table paid_rec_tbl add constraint fk_paid_num
  foreign key (paid_num) references paid_tbl(paid_num);

commit;
-- ★무료소설★
-- auto
CREATE SEQUENCE free_num;
CREATE SEQUENCE free_snum;

CREATE TABLE free_tbl(
    free_num number(10,0) PRIMARY KEY,
    novel_num number(10,0) not null, -- fk
    free_snum number(10,0) not null,
    free_title varchar2(200) not null,
    free_content1 CLOB not null,
    free_content2 CLOB,
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


-- 무료 추천 
create sequence rec_num;

CREATE TABLE free_rec_tbl(
rec_num number(10,0) primary key,
free_num number(10,0) not null,
user_id varchar(20) not null
);

alter sequence rec_num nocache;

alter table free_rec_tbl add constraint fk_user foreign key (user_id) references user_tbl(user_id);

alter table free_rec_tbl add constraint fk_free_num foreign key (free_num) references free_tbl(free_num);

commit;

-- 05.18 작가 신청 게시판 & 딸린 첨부파일 게시판


-- auto
CREATE SEQUENCE enroll_num;

-- 테이블 생성
CREATE TABLE enroll_tbl(

    enroll_num number(10,0) PRIMARY KEY,
    novel_writer varchar2(50) not null,
    novel_title varchar2(200) not null,
    novel_category varchar2(10) not null,
    user_id varchar2(20) not null, 
    enroll_intro varchar2(2000) not null,
    enroll_result number(10,0) default 0,
    enroll_msg varchar2(1000)
);

-- 시퀀스 해결
alter sequence enroll_num nocache;

-- 외래키
alter table enroll_tbl add constraint fk_enroll foreign key (user_id) references user_tbl(user_id);

-- 조회
SELECT * FROM enroll_tbl;

SELECT * FROM enroll_tbl WHERE enroll_num=1;

delete from enroll_tbl;

-- 커밋
commit;

-- 적재
INSERT INTO enroll_tbl(enroll_num, novel_writer, novel_title, novel_category, user_id, enroll_intro, enroll_msg) VALUES
    (enroll_num.nextval, '작가1', '제목1', 'romance', 'user2', '작품소개입니다1', '관리자 메세지1');
    
INSERT INTO enroll_tbl(enroll_num, novel_writer, novel_title, novel_category, user_id, enroll_intro, enroll_msg) VALUES
    (enroll_num.nextval, '작가2', '제목2', 'romance', 'user3', '작품소개입니다2', '관리자 메세지2');
    
INSERT INTO enroll_tbl(enroll_num, novel_writer, novel_title, novel_category, user_id, enroll_intro, enroll_msg) VALUES
    (enroll_num.nextval, '작가3', '제목3', 'romance', 'user4', '작품소개입니다3', '관리자 메세지3');
    
    
    SELECT * FROM user_tbl;
    
    
-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ▼ ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■


-- 첨부파일 테이블



-- 테이블 생성
-- ■ 작가신청 이미지 첨부파일
CREATE TABLE enroll_img_tbl(

    uuid VARCHAR(100) NOT NULL,          -- uuid
    uploadPath VARCHAR(200) NOT NULL,    -- 파일 경로
    fileName VARCHAR(100) NOT NULL,      -- 파일 이름
    fileType char(1) DEFAULT 'I',        -- 이미지인지 아닌지의 여부
    enroll_num number(10)                -- enroll_tbl의 몇 번째 글에 딸려있는지
    
);

ALTER TABLE enroll_img_tbl ADD CONSTRAINT pk_enroll_ing_attach PRIMARY KEY (uuid);
ALTER TABLE enroll_img_tbl ADD CONSTRAINT fk_enroll_attach FOREIGN KEY(enroll_num) REFERENCES enroll_tbl(enroll_num);

select * from enroll_img_tbl;
delete from enroll_img_tbl;

-- ■ 유료 소설 이미지 첨부파일
SELECT * FROM paid_img_tbl;
CREATE TABLE paid_img_tbl(

    uuid VARCHAR(100) NOT NULL,          -- uuid
    uploadPath VARCHAR(200) NOT NULL,    -- 파일 경로
    fileName VARCHAR(100) NOT NULL,      -- 파일 이름
    fileType char(1) DEFAULT 'I',        -- 이미지인지 아닌지의 여부
    paid_num number(10)                -- paid_tbl의 몇 번째 글에 딸려있는지
    
);

ALTER TABLE paid_img_tbl ADD CONSTRAINT pk_paid_ing_attach PRIMARY KEY (uuid);
ALTER TABLE paid_img_tbl ADD CONSTRAINT fk_paid_attach FOREIGN KEY(paid_num) REFERENCES paid_tbl(paid_num);


SELECT * FROM paid_img_tbl;

-- ■ 무료 소설 이미지 첨부파일
SELECT * FROM free_img_tbl;
CREATE TABLE free_img_tbl(

    uuid VARCHAR(100) NOT NULL,          -- uuid
    uploadPath VARCHAR(200) NOT NULL,    -- 파일 경로
    fileName VARCHAR(100) NOT NULL,      -- 파일 이름
    fileType char(1) DEFAULT 'I',        -- 이미지인지 아닌지의 여부
    free_num number(10)                -- free_tbl의 몇 번째 글에 딸려있는지
    
);

ALTER TABLE free_img_tbl ADD CONSTRAINT pk_free_ing_attach PRIMARY KEY (uuid);
ALTER TABLE free_img_tbl ADD CONSTRAINT fk_free_attach FOREIGN KEY(free_num) REFERENCES free_tbl(free_num);


SELECT * FROM free_img_tbl;

commit;         
         
-- ★ 유료 소설 댓글

CREATE SEQUENCE prepl_num;

CREATE TABLE paid_repl_tbl(
  prepl_num number(10,0) PRIMARY KEY,
  novel_num number(10,0) not null,-- novel_tbl novel_num을 fk
  paid_pnum number(10,0) not null, -- paid_tbl paid_num을 fk
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
  foreign key (paid_pnum) references paid_tbl(paid_num);                        -- prepl_pnum이라고 되어있어서 paid_pnum로 수정함

-- ★ 무료 소설 댓글
CREATE SEQUENCE frepl_num;

CREATE TABLE free_repl_tbl(
  frepl_num number(10,0) PRIMARY KEY,
  novel_num number(10,0) not null,-- novel_tbl novel_num을 fk
  free_num number(10,0) not null, -- free_tbl free_num을 fk
  frepl_content varchar2(1000) not null,
  user_id varchar2(50) not null,  -- user_tbl user_id를 fk
  frepl_rdate date default sysdate,
  frepl_mdate date
);

-- 시퀀스 해결
alter sequence frepl_num nocache;

-- 외래키 설정

  
alter table free_repl_tbl add constraint fk_novel_num
  foreign key (novel_num) references novel_tbl(novel_num);

alter table free_repl_tbl add constraint fk_replyer
  foreign key (user_id) references user_tbl(user_id);  

alter table free_repl_tbl add constraint fk_repl_fnum
  foreign key (free_num) references free_tbl(free_num);
  
  
-- ★토너먼트(대회)★
-- auto
CREATE SEQUENCE to_num;

CREATE TABLE tourna_tbl(
  to_num number(10,0) PRIMARY KEY,
  to_name varchar2(50) not null,
  to_sdate date default sysdate,
  to_edate date
);

-- 시퀀스 해결
alter sequence to_num nocache;

--INSERT 예
INSERT INTO tourna_tbl (to_num, to_name) values 
                        (to_num.nextval,'스프링배 소설 배틀');
-- 조회
SELECT * FROM tourna_tbl;


-- ★토너먼트(작품)★
-- auto
CREATE SEQUENCE towork_num;

CREATE TABLE towork_tbl(
  towork_num number PRIMARY KEY,
  to_num number(10,0), -- fk
  novel_num number(10,0), -- fk
  towork_rec number(10,0) default 0
);

-- 시퀀스 해결
alter sequence towork_num nocache;

-- 외래키 설정
alter table towork_tbl add constraint fk_towork
  foreign key (to_num) references tourna_tbl(to_num);
 
 alter table towork_tbl add constraint fk_towork1
  foreign key (novel_num) references novel_tbl(novel_num);
  
-- INSERT 예
INSERT INTO towork_tbl (towork_num, to_num, novel_num) values
                        (towork_num.nextval,1,2);
                
-- 조회
SELECT * FROM towork_tbl;







-- ★토너먼트(대회/작품 유저 추천 기록)★

    -- 번호, 유저 아이디(유저 번호가 pk이긴 한데 아이디도 유니크니까), 토너먼트 번호, 작품 번호, 추천 날짜 
    
    -- auto
    CREATE SEQUENCE torec_num;
    
    CREATE TABLE torec_tbl(
        torec_num number PRIMARY KEY,       -- 번호
        user_id varchar2(20),               -- 유저 아이디        fk(user_tbl)
        to_num number(10,0),                -- 토너먼트 번호      fk(tourna_tbl)
        towork_num number,                  -- 토너먼트 작품 번호 fk(towork_tbl)
        novel_num(10,0) not null,           -- 소설번호 
        rec_date date default sysdate       -- 추천일
    );

    -- 시퀀스 해결
    alter sequence torec_num nocache;
    
    -- 외래키 설정
    alter table torec_tbl add constraint fk_torec1
        foreign key (user_id) references user_tbl(user_id);
        
    alter table torec_tbl add constraint fk_torec2
        foreign key (to_num) references tourna_tbl(to_num);
        
    alter table torec_tbl add constraint fk_torec3
        foreign key (towork_num) references towork_tbl(towork_num);
        
    alter table torec_tbl add constraint fk_torec4
        foreign key (novel_num) references novel_tbl(novel_num);
    
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
  
    
-- ★선호작★
-- auto
CREATE SEQUENCE fav_num;

CREATE TABLE favorite_tbl(
  fav_num number(10,0) PRIMARY KEY,
  novel_num number(10,0), -- novel_tbl에서 novel_num fk
  user_num number(10,0) -- user_tbl에서 user_num fk
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


select novel_num, count(novel_num) as fav from favorite_tbl group by novel_num order by fav desc;




-- ★무료 책갈피★
-- auto
CREATE SEQUENCE fbm_num;

CREATE TABLE free_bookmark_tbl(
  fbm_num number(10,0) PRIMARY KEY,
  fbm_free_num number(10,0), -- free_tbl에서 free_num fk
  user_num number(10,0) -- fk
);
drop table free_bookmark_tbl;
-- 시퀀스 해결
alter sequence fbm_num nocache;

-- 외래키 설정
 alter table free_bookmark_tbl add constraint fk_bookmark_fnum
  foreign key (fbm_free_num) references free_tbl(free_num);
  
alter table free_bookmark_tbl add constraint fk_bookmark2
  foreign key (user_num) references user_tbl(user_num);
commit;  
-- INSERT 예
INSERT INTO bookmark_tbl (fbm_num, novel_num, fbm_free_num, user_num) values
            (fbm_num.nextval, 2, 3, 1);
            
-- 조회
SELECT * FROM free_bookmark_tbl;


-- ★결제(현금->코인)★
-- auto
CREATE SEQUENCE charge_num;

CREATE TABLE charge_tbl(
  charge_num number(10,0) PRIMARY KEY,
  merchant_uid varchar2(100) unique, -- 추가
  itemname varchar2(100) not null, -- 추가
  charge_date date default sysdate,
  user_num number(10,0), -- fk
  charge_price number(10) not null,
  charge_coin number(10),
  charge_coupon number(10)
);
select * from user_tbl;

-- 시퀀스 해결
alter sequence charge_num nocache;

-- 외래키 설정
alter table charge_tbl add constraint fk_charge
  foreign key (user_num) references user_tbl(user_num);
  
commit;
  
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
  paid_num number(10,0) not null, --fk 어떤 소설을 구매했는지 (추가)
  use_type varchar2(10) not null,
  use_count number(10) not null,
  use_date date default sysdate
);
-- 외래키 설정
alter table use_tbl add constraint fk_use
  foreign key (user_num) references user_tbl(user_num);
  
alter table use_tbl add constraint fk_paidnum
  foreign key (paid_num) references paid_tbl(paid_num);
  
  drop table use_tbl;
-- INSERT 
INSERT INTO use_tbl (use_num, user_num, use_type, use_count) values
                    (use_num.nextval, 1, '코인', '100');       
                    
                    commit;
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