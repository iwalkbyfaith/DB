-- 프로젝트에서 막 날릴 쿼리문 모음

-- 토너먼트 작품 번호가 6일때, 6번 작품의 추천수 가져오기
SELECT towork_rec FROM (SELECT * FROM tourna_tbl INNER JOIN towork_tbl ON tourna_tbl.to_num = towork_tbl.to_num) tt
        INNER JOIN 
        novel_tbl nt 
    ON tt.novel_num = nt.novel_num 
    WHERE tt.towork_num =6;
    
    
SELECT towork_rec FROM towork_tbl WHERE towork_num=6;

UPDATE towork_tbl SET towork_rec = towork_rec + 1 WHERE towork_num = 6;

SELECT * FROM towork_tbl;

SELECT * FROM reply_tbl;

DELETE FROM reply_tbl WHERE rno = 1;




-- 적재용 (승곤)

INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'월요일작가','월요일 웹툰', 10, 'wuxia', 'Mon');
                        
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                    (novel_num.nextval,'화요일작가','화요일 웹툰', 10, 'romance', 'Tue');
                    
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'수요일작가','수요일 웹툰',10, 'wuxia', 'Wen');

INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'목요일작가','목요일 웹툰',10, 'fantasy', 'Thu');
                        
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'금요일작가','금요일 웹툰',10, 'fantasy', 'Fri');
                        
INSERT INTO paid_tbl (paid_num, novel_num, paid_snum, paid_title, paid_content) values
                        (paid_num.nextval, '20', 1, '월요일 웹툰 1편', '월요일 웹툰 1편 내용');
                        
INSERT INTO paid_tbl (paid_num, novel_num, paid_snum, paid_title, paid_content) values
                        (paid_num.nextval, '21', 1, '화요일 웹툰 1편', '화요일 웹툰 1편 내용');
                        
INSERT INTO paid_tbl (paid_num, novel_num, paid_snum, paid_title, paid_content) values
                        (paid_num.nextval, '22', 1, '수요일 웹툰 1편', '수요일 웹툰 1편 내용');
                        
INSERT INTO paid_tbl (paid_num, novel_num, paid_snum, paid_title, paid_content) values
                        (paid_num.nextval, '23', 1, '목요일 웹툰 1편', '목요일 웹툰 1편 내용');
                        
INSERT INTO paid_tbl (paid_num, novel_num, paid_snum, paid_title, paid_content) values
                        (paid_num.nextval, '24', 1, '금요일 웹툰 1편', '금요일 웹툰 1편 내용');
                        
                        commit;
                        
                        
                        
-- 적재용

-- ★판타지소설★ 
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'동주','내행운은 만렙이다',100, 'fantasy', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'글럼프','망나니 1왕자가 되었다',100, 'fantasy', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'추공','나 혼자만 레벨업',100, 'fantasy', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'룬드그린','악당이 살아가는법',100, 'fantasy', 'free');
-- ★로맨스소설★ 
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'최은경','현주효영',100, 'romance', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'이송','사랑을배우다',100, 'romance', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'김윤수','불면증',100, 'romance', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'박현아','사랑에 빠진 것처럼',100, 'romance', 'free');

-- ★무협소설★         
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'장영훈','절대강호',100, 'wuxia', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'태규','천라신조',100, 'wuxia', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'용대운','태극문',100, 'wuxia', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'전동조','묵향',100, 'wuxia', 'free');

-- ★추리소설★                                 
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'가와이간지','데드맨',100, 'detective', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'아오야마 고쇼','명탐정코난',100, 'detective', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'키바야시 신','소년탐정 김전일',100, 'detective', 'free');                        
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'B.A.패리스','비하인드 도어',100, 'detective', 'free');
                        
                        
    -- ★판타지 무료소설 - 행운만렙★                    
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
    (free_num.nextval, '30',1,'망나니_제1장-1화','이미 클리어한 게임 속에 갇혔다.
    그런데
    이 [운빨망겜]에서 내 행운은 만렙이다.'); 
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '30',2,'망나니_제1장-2화','[세상의 끝]
세상에서 가장 유명한 게임 중 하나 지구와 비슷하게 제작된 하나의 세계에서 수십억의 인공지능 NPC가 존재하는, 최단기 >엔딩을 보기 위해서라도 게임시간으로 10년 이상 플레이가 필요한 게임.'); 
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '30',3,'망나니_제1장-3화','꿈인가 싶었다.
게임 속으로 들어오기라도 한 건가.
모든 가능성을 제외하고 남은 하나는, 아무리 말이 되지 않는 것이라도 진실이라 생각했다.
아무리 이성적으로 생각하더라도 이곳에 갖힌게 맞는 거 같았다.
52년을 플레이하면서 이 게임의 스토리를 되다 꿰고 있다.'); 
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '30',4,'망나니_제1장-4화','끊임 없이 움직여야해

강해지고 세력을 얻고 힘을 키운다.

그래 난 썩은 물을 넘어선 석유급 플레이어니까.');                       
-- ★판타지 무료소설  - 망나니★                    
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '31',1,'망나니_제1장-1화','검으로 환생해 수백년을 살다, 덜컥 열다섯 망나니 왕자의 몸을 차지하게 되었다.'); 
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '31',2,'망나니_제1장-2화','검으로 환생해 평생을 남 뒤치다꺼리만 했다. 그러다 기회가 왔다.

망나니로 악명 높은 왕자의 몸을 차지했다. 살 뒤룩뒤룩 찐 고도비만의 몸뚱이에 재능이라고는 쥐뿔도 없었지만 그건 아무런 문제가 되지 않았다.');
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '31',3,'망나니_제1장-3화','"내가 키운 애들이 몇인데."

불패라 불리던 위대한 기사, 광룡을 쓰러뜨린 드래곤 슬레이어, 전부 내가 키웠다.'); 
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '31',4,'망나니_제1장-4화','이깟 난관 따위 내겐 아무것도 아니었다.

<망나니 1왕자가 되었다> Prologue 中');  
-- ★판타지 무료소설  - 나혼자만레벨업★                    
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '32',1,'나혼렙_제1장-1화','10년 전, 도대체 영문을 알 수 없는 “게이트”라는 것이 생겨나게 되고 그곳을 “던전”이라 부른다. 그 안에서는 “마수”라는 존재가 우글거린다. “마수들은” 인간들을 마구잡이로 죽이게 된다. 그리고 그 “마수”들을 잡는 인간들을 “헌터”라고 한다'); 
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '32',2,'나혼렙_제1장-2화','헌터의 등급은 E급부터 D급, C급, B급, A급 그리고 가장 강한 S급이 존재한다.
그런데 여기 대한민국에 일반인과 별반 다를게 없는 수준의 약한 E급 헌터, 성진우라는 청년이 있었다');
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '32',3,'나혼렙_제1장-3화','그 약한 마수인 고블린에게도 등을 다쳐 병원 신세를 지게 되고, 던전에 갇혀 식량이 떨어진 적도 있었다.
여동생의 공부와 어머니의 병원비를 위해 주변인들에게 인류 최약병기라는 놀림을 받으면서도 위험한 헌터 일을 하는 E급 헌터 성진우는'); 
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '33',4,'나혼렙_제1장-4화','별 성과도 없이 동료 주희의 도움만 받다가 헌터 하나가 찾은 이중 던전을 보고 위험할 수 있음에도 어머니를 떠올리며 이중 던전에 들어간다. 진우는 자신의 무모함에 화내는 주희에게 사과를 하는데, 이때 미안하면 밥이라도 사라며 데이트 신청을 받는다.');  

-- ★판타지 무료소설  - 악당이 살아가는법★                    
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '33',1,'악당으로살기_제1장-1화','나는 악당이다.
그것도 더럽고 비열하고 치졸하고 나약한 악당이다'); 
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '33',2,'악당으로살기_제1장-2화','그리고 나는 악당인것을 결코 부끄럽게 여기지 않는다.');
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '33',3,'악당으로살기_제1장-3화','나는 악당이다.
그것도 더럽고 비열하고 치졸하고 나약한 악당이다.'); 
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '33',4,'악당으로살기_제1장-4화','그리고 나는 악당인것을 결코 부끄럽게 여기지 않는다.');
  commit;                      
                        
                        select n.novel_title,n.novel_num from novel_tbl n WHERE n.novel_category='romance' ORDER BY n.novel_num DESC;
                        
                        
                        
                        
         select * FROM towork_tbl;               
                        
                        

-- 토너먼트 동수일 때 조회수로 비교하기
    -- 8강에서 네 작품만 올라가야하는데
        -- 일단 두 작품에만 조회수를 변경해본다.
            SELECT * FROM free_tbl;
            UPDATE free_tbl SET free_hit = 239 WHERE novel_num=30 AND free_snum=1;
            UPDATE free_tbl SET free_hit = 113 WHERE novel_num=30 AND free_snum=2;
            UPDATE free_tbl SET free_hit = 97 WHERE novel_num=30 AND free_snum=3;
            
            UPDATE free_tbl SET free_hit = 1120 WHERE novel_num=32 AND free_snum=1;
            UPDATE free_tbl SET free_hit = 339 WHERE novel_num=32 AND free_snum=2;
            UPDATE free_tbl SET free_hit = 24 WHERE novel_num=32 AND free_snum=3;
            
            UPDATE free_tbl SET free_hit = 19 WHERE novel_num=17 AND free_snum=1;
            
            UPDATE free_tbl SET free_hit = 3 WHERE novel_num=19 AND free_snum=1;
            
        -- 그룹 바이로 조회수를 묶어본다 (소설 번호로)
            SELECT novel_num, sum(free_hit) FROM free_tbl GROUP BY novel_num ORDER BY sum(free_hit) DESC;
    
        -- 여기서 상위 4개
        SELECT * FROM (SELECT novel_num, sum(free_hit) FROM free_tbl GROUP BY novel_num ORDER BY sum(free_hit) DESC) WHERE rownum <= 4 ;
        
        
        
        
        
        
        
        
        
        
        
        
        
            ALTER TABLE novel_tbl MODIFY novel_category varchar2(30);
            
    -- INSERT novel (10개 적재) 판타지, 무협, 로맨스, 미스터리                                                                       작가이름  소설제목 총편수 카테고리 요일                                   작품번호
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'허성록','클라우드', 12, '판타지', 'free');                            -- 48
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'달몽','무황의 천하 쟁패기', 28, '무협', 'free');                      -- 49
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'나노제이','뒤틀린 무협 세계에서 살아남기', 113, '무협', 'free');      -- 50
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'현실비','금요일 밤에 만나는 남자', 33, '로맨스', 'free');             -- 51
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'엔씨','위험한 결혼', 7, '로맨스', 'free');                            -- 52 
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'김케이','오렌지 칵테일', 44, '미스터리', 'free');                     -- 55
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'이새얀','생일선물',229, '미스터리', 'free');                          -- 56
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'비늘구름','회귀 신선', 22, '무협', 'free');                           -- 57
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'홍작가','로맨스를 꿈꾸는', 23, '로맨스', 'free');                     -- 58
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'츄르한잔','탑랭커의 작가지망 생활백서',56, '판타지', 'free');         -- 59
        
        SELECT * FROM novel_tbl ORDER BY novel_num DESC;
    
    -- INSERT free (2개씩 * 10 적재)                                                                                    작품번호 회차 제목            내용 
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '48', 2,'클라우드 2회', '클라우드 2회의 내용입니다', 23); 
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '49', 1,'무황의 천하 쟁패기 2회', '무황의 천하 쟁패기 2회의 내용입니다', 19);
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '50', 1,'뒤틀린 무협 2회', '뒤틀린 무협 2회의 내용입니다', 76);
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '51', 2,'금요일 밤의 남자 2회', '금요일 밤의 남자 2회의 내용입니다', 1230);
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '52', 2,'위험한 결혼 2회', '위험한 결혼 2회의 내용입니다', 280);
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '55', 2,'오렌지 칵테일 2회', '오렌지 칵테일 2회의 내용입니다', 110);
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '56', 2,'생일선물 2회', '생일선물 2회의 내용입니다', 338);
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '57', 1,'회귀 신선 1회', '회귀신선 1회의 내용입니다', 331);
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '58', 2,'로맨스를 2회', '로맨스를 2회의 내용입니다', 1340);
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '59', 2,'탑랭커의 2회', '탑랭커의 2회의 내용입니다', 998);
    
        DELETE FROM free_tbl WHERE novel_num=57;
        SELECT * FROM free_tbl;
    
    
