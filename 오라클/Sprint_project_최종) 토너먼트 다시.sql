-- 토너먼트 테이블 관련 모든 구문

-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ▼ ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

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


-- 기본 데이터 적재

    -- 1) 8강
    INSERT INTO tourna_tbl (to_num, to_name) values (to_num.nextval,'웹소설 최강자 8강전');
    UPDATE tourna_tbl SET to_sdate = '22/05/15' WHERE to_num='1'; 
    UPDATE tourna_tbl SET to_edate = to_sdate + (INTERVAL '7' DAY) WHERE to_num='1';
    
    -- 2) 4강   
    INSERT INTO tourna_tbl (to_num, to_name) values (to_num.nextval,'웹소설 최강자 4강전');
    UPDATE tourna_tbl SET to_sdate = '22/05/22' WHERE to_num='2'; 
    UPDATE tourna_tbl SET to_edate = to_sdate + (INTERVAL '7' DAY) WHERE to_num='2';
    
    -- 3) 2강   
    INSERT INTO tourna_tbl (to_num, to_name) values (to_num.nextval,'웹소설 최강자 2강전');
    UPDATE tourna_tbl SET to_sdate = '22/05/29' WHERE to_num='3'; 
    UPDATE tourna_tbl SET to_edate = to_sdate + (INTERVAL '7' DAY) WHERE to_num='3';
    
    -- 4) 다음 대회 준비 기간
    INSERT INTO tourna_tbl (to_num, to_name) values (to_num.nextval,'다음 대회 준비 기간');
    UPDATE tourna_tbl SET to_sdate = '22/06/05' WHERE to_num='4'; 
    UPDATE tourna_tbl SET to_edate = to_sdate + (INTERVAL '7' DAY) WHERE to_num='4';
    
    select * from tourna_tbl;

commit;

    -- 대회 강제 종료
    UPDATE tourna_tbl SET to_sdate = '22/05/29' WHERE to_num='4';  
        -- 되돌리기
        UPDATE tourna_tbl SET to_sdate = '22/06/05' WHERE to_num='4';  

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


-- 시퀀스 해결
alter sequence towork_num nocache;

-- 외래키 설정
alter table towork_tbl add constraint fk_towork
  foreign key (to_num) references tourna_tbl(to_num);
 
 alter table towork_tbl add constraint fk_towork1
  foreign key (novel_num) references novel_tbl(novel_num);
  
  
select * from towork_tbl;  


-- 추천수 주기 
    
    -- 순서 : 소설제목(소설번호) 총조회수
    -- 의도 : 이섭(17) 8267 > 전독시(16) 4891 
    --                      > 화산(21) 3535 > 남편이(25) 3890  
    --                                      > 나노(18) 3483 > 메모라이즈(28) 1419 > 마신(30) 510 > 셜록(31) 217
    
        -- 8강전) 추천수 : 남편이 = 나노마신 / 조회수 : 남편이 > 나노마신
        -- 4강전) 이섭 > 전독시 = 화산귀환
        -- 2강전) 이섭 > 전독시

    -- 추천수 일단 기본 세팅
    
        UPDATE towork_tbl SET towork_rec = 1190 WHERE novel_num = 17;                   -- 이섭의 연애
        UPDATE towork_tbl SET towork_rec = 1190 WHERE novel_num = 16;                   -- 전독시
        
        UPDATE towork_tbl SET towork_rec = 994 WHERE novel_num = 21;                    -- 화산귀환
        UPDATE towork_tbl SET towork_rec = 839 WHERE novel_num = 25;                    -- 남편이 돌아왔다.
        
        UPDATE towork_tbl SET towork_rec = 839 WHERE novel_num = 18;                    -- 나노마신
        UPDATE towork_tbl SET towork_rec = 401 WHERE novel_num = 28;                    -- 메모라이즈
        UPDATE towork_tbl SET towork_rec = 331 WHERE novel_num = 30;                    -- 마신전생기
        UPDATE towork_tbl SET towork_rec = 228 WHERE novel_num = 31;                    -- 셜록
    
        -- ---------------------------------------------------------------------
    
        UPDATE towork_tbl SET towork_rec = 1490 WHERE novel_num = 16 AND to_num =1;     -- 전독시(8강 수정)
    
        -- ---------------------------------------------------------------------
        
         UPDATE towork_tbl SET towork_rec = 1970 WHERE novel_num = 16 AND to_num =2;    -- 전독시(4강 수정)
         UPDATE towork_tbl SET towork_rec = 2890 WHERE novel_num = 17 AND to_num =2;    -- 이섭의 연애(4강 수정)
         UPDATE towork_tbl SET towork_rec = 1970 WHERE novel_num = 21 AND to_num =2;     -- 화산귀환(4강 수정)
         
        -- ---------------------------------------------------------------------
        
         UPDATE towork_tbl SET towork_rec = 4389 WHERE novel_num = 17 AND to_num =3;    -- 이섭의 연애(2강 수정) : 지다가 이겨야함
         UPDATE towork_tbl SET towork_rec = 4390 WHERE novel_num = 16 AND to_num =3;    -- 전독시(2강 수정)
    
    
    SELECT * FROM towork_tbl;
    commit;
    
    delete from towork_tbl;

    







  
  
-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ▲ ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
  
  
  
-- ★토너먼트(대회/작품 유저 추천 기록)★ ■ 　

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
        
    delete from torec_tbl;
    
    commit;




    
    
    
           -- 사후처리 잘 되었나 확인 (현재 1등 novel_num=17, user_id=freeWriter0)
       
            -- 1. novel_tbl에서 week
            SELECT * FROM novel_tbl;
                -- 이전 상태로 세팅
                UPDATE novel_tbl SET novel_week = 'free' WHERE novel_num=17;
                
                commit;
                delete from novel_tbl;
                
            -- 2. auth_tbl에서 등급 변경
            SELECT * FROM auth_tbl order by auth_num;
                -- 이전 상태로 세팅
                UPDATE auth_tbl SET auth='ROLE_FREE_WRITER' WHERE user_id='freeWriter0';
                
            -- 3. free_tbl에서 연재했던 데이터 삭제
            SELECT * FROM free_tbl order by novel_num;
                -- 이전 상태로 세팅
                INSERT INTO free_tbl(
                    SELECT * 
                        FROM free_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '10' MINUTE) WHERE novel_num=17
                );
                
                DELETE FROM free_tbl;
                
                  SELECT * 
                        FROM free_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '10' MINUTE) WHERE novel_num=17;
                
                
            -- 4. 토너먼트 대회 기간 업데이트 (8강, 4강, 2강, 준비기간)
            SELECT * FROM tourna_tbl;
                -- 이전 상태로 세팅
                    -- 8강 되돌리기
                    UPDATE tourna_tbl SET to_sdate = '22/05/15', to_edate='22/05/22' WHERE to_num=1;
                    
                    -- 4강 되돌리기
                    UPDATE tourna_tbl SET to_sdate = '22/05/22', to_edate='22/05/29' WHERE to_num=2; 
                    
                    -- 2강 되돌리기
                    UPDATE tourna_tbl SET to_sdate = '22/05/29', to_edate='22/06/05' WHERE to_num=3; 
                    
                    -- 휴식기
                    UPDATE tourna_tbl SET to_sdate = '22/06/05', to_edate='22/06/12' WHERE to_num=4;
                    
                    -- 휴식기 수정(종료 버튼 나오게. to_sdate를 오늘 날짜로)
                    UPDATE tourna_tbl SET to_sdate = '22/05/31', to_edate='22/06/12' WHERE to_num=4;
                    
                    commit;
                    
            -- 5. torec_tbl 데이터 삭제
            SELECT * FROM torec_tbl;
                -- 데이터 세팅
                UPDATE towork_tbl SET towork_rec=59 WHERE novel_num=16;
                SELECT * FROM towork_tbl;
                
                -- 데이터 되돌리기
                INSERT INTO torec_tbl(
                    SELECT * 
                            FROM torec_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '10' MINUTE)
                );
                
                DELETE FROM torec_tbl;
                commit;
                

            -- 6. towork_tbl 데이터 삭제 (이거 난리나서 다시 적재해야됨)
            SELECT * FROM towork_tbl;
            
                -- 이전 상태로 세팅
                INSERT INTO towork_tbl(
                    SELECT * 
                        FROM towork_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '10' MINUTE)
                );
                
                  SELECT * 
                        FROM towork_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '20' MINUTE);


    select * from use_tbl;
    delete from torec_tbl where user_id='user0';
    commit;
    
    
    

    
    select * from user_tbl;
    
    update paid_tbl set paid_price = 100;
    commit;
    update user_tbl set user_coin = 0, user_coupon =0 ;
    
    select * from charge_tbl;
    select * from use_tbl;


commit;

select * from free_tbl order by novel_num;

-- ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ ♥ 확인용 ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
    -- 3. 1과 2를 조인한 리스트
    SELECT * FROM ( -- 이게 맞는지 확인하려면 tt2.*을 *로 바꿔서 확인하면 됨
        SELECT tt1.to_num, tt1.to_name, tt1.towork_num, nt.novel_title, nt.novel_writer, tt1.towork_rec, nt.novel_num FROM
            (SELECT tt.to_num, tt.to_name, tot.towork_num, tot.towork_rec, tot.novel_num FROM
                towork_tbl tot
            LEFT JOIN
                tourna_tbl tt
            ON
                tot.to_num = tt.to_num) tt1
        LEFT JOIN
            novel_tbl nt
        ON 
            tt1.novel_num = nt.novel_num
        ) tt2
    LEFT JOIN
        (
        SELECT novel_num, sum(free_hit) as totalHit FROM free_tbl group by novel_num
        ) tt3
    ON tt2.novel_num = tt3.novel_num
    ORDER BY to_num DESC, towork_rec DESC, totalHit DESC;
    
    
    select * from torec_tbl;
    update free_tbl set free_hit = 4492 where free_num=3;
    
    commit;