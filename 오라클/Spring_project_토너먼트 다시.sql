-- 토너먼트,,, 새로운 마음으로 시작


    -- 현재 novel, free, paid, towork, torec 바로 생성한 상태(데이터 x)

-- 키워드 : order by 다중정렬

    -- 0. 8강 테이블에 적재
        -- 무료 소설 중, 총 추천수*10 + 총 조회수로 8강에 towork_tbl에 적재
        -- 총 추천수와 총 조회수는 novel_num으로 그룹바이하여 묶는다
        
            -- 먼저 free 테이블에서 해당 조건에 맞는 것을 조회
            SELECT * FROM free_tbl fb ;
            SELECT fb.novel_num, sum(fb.free_rec) ,sum(fb.free_hit) FROM free_tbl fb GROUP BY fb.novel_num;
            SELECT fb.novel_num, sum(fb.free_rec) ,sum(fb.free_hit), sum(fb.free_rec)*10 + sum(fb.free_hit) FROM free_tbl fb GROUP BY fb.novel_num ORDER BY sum(fb.free_rec)*10 + sum(fb.free_hit) DESC;
            
            -- 거기서 상위 8개만 추림
            SELECT * FROM (SELECT fb.novel_num, sum(fb.free_rec) ,sum(fb.free_hit), sum(fb.free_rec)*10 + sum(fb.free_hit) FROM free_tbl fb GROUP BY fb.novel_num ORDER BY sum(fb.free_rec)*10 + sum(fb.free_hit) DESC) WHERE rownum <= 8;
            
            -- ▶ (8강)적재할 버전에는 novel_num만 있으면 됨
            SELECT novel_num FROM (SELECT fb.novel_num FROM free_tbl fb GROUP BY fb.novel_num ORDER BY sum(fb.free_rec)*10 + sum(fb.free_hit) DESC) WHERE rownum <= 8;
            commit;
        
            -- ▶ towork_tbl에 8개의 자료를 TournamentMapper에 insert select를 사용해서 넣을 것이다 (테이블넘버ai, 토너먼트 번호, 작품 번호)
            
            
            SELECT * FROM towork_tbl;
            SELECT * FROM tourna_tbl;
            
    -- 1. 4강에 적재하기 (ORDER BY 다중 걸기 사용 : 추천수 -> 총 조회수)
                -- 1. group by를 사용해서 free_tbl에서 총 조회수와 novel_num을 가져온다.
                     SELECT fb.novel_num, sum(fb.free_hit) FROM free_tbl fb GROUP BY fb.novel_num;
                -- 2. towork_tbl과 조인한다. => 대회작품번호, 대회번호, 작품번호, 추천수, 총조회수
                     SELECT tot.towork_num, tot.to_num, tot.novel_num, tot.towork_rec, jt.hit_total_sum FROM towork_tbl tot     -- towork_tbl
                        LEFT JOIN 
                    (SELECT fb.novel_num, sum(fb.free_hit) as hit_total_sum FROM free_tbl fb GROUP BY fb.novel_num) jt          -- free_tbl(총 조회수 포함)
                        ON
                    tot.novel_num = jt.novel_num
                        ORDER BY towork_rec DESC, hit_total_sum DESC ;                                                          -- 추천수 -> 총조회수로 정렬
                        
                -- 3. towork_rec이 0이어서 제대로 된지 모르겠으니까 적재해서 비교해봄 (2. 를 실행해서 확인 완료)
                    UPDATE towork_tbl SET towork_rec = 50 WHERE towork_num=683;
                    UPDATE towork_tbl SET towork_rec = 40 WHERE towork_num=684;
                    UPDATE towork_tbl SET towork_rec = 50 WHERE towork_num=682;
                    UPDATE towork_tbl SET towork_rec = 60 WHERE towork_num=685;
                    UPDATE towork_tbl SET towork_rec = 40 WHERE towork_num=599;

                    
                -- 4. 2의 결과에서 상위 4개만 자른다
                    --SELECT to_num, novel_num, towork_rec, hit_total_sum FROM
                    SELECT to_num, novel_num, towork_rec, hit_total_sum FROM
                    (SELECT tot.towork_num, tot.to_num, tot.novel_num, tot.towork_rec, jt.hit_total_sum FROM towork_tbl tot                    -- towork_tbl
                        LEFT JOIN 
                    (SELECT fb.novel_num, sum(fb.free_hit) as hit_total_sum FROM free_tbl fb GROUP BY fb.novel_num) jt       -- free_tbl(총 조회수 포함)
                        ON
                    tot.novel_num = jt.novel_num
                        ORDER BY towork_rec DESC, hit_total_sum DESC)
                    WHERE
                        to_num=1 AND rownum <= 4;
                        
                -- 5. ▶ 4의 결과를 towork_num 테이블에 적재한다.(to_num에는 +1 해준다)
                    -- towork_tbl에 총 추천수 컬럼 추가해야하나 싶었는데 그냥 그때그때 가져올 수 있는지 확인
                    INSERT INTO towork_tbl(towork_num, to_num, novel_num, towork_rec)
                        SELECT towork_num.nextval, to_num+1, novel_num, towork_rec FROM
                    (SELECT tot.towork_num, tot.to_num, tot.novel_num, tot.towork_rec, jt.hit_total_sum FROM towork_tbl tot     -- towork_tbl
                        LEFT JOIN 
                    (SELECT fb.novel_num, sum(fb.free_hit) as hit_total_sum FROM free_tbl fb GROUP BY fb.novel_num) jt          -- free_tbl(총 조회수 포함)
                        ON
                    tot.novel_num = jt.novel_num
                        ORDER BY towork_rec DESC, hit_total_sum DESC)
                    WHERE
                        to_num=1 AND rownum <= 4;
                        
                        
                        -- test
                        --INSERT INTO towork_tbl(towork_num, to_num, novel_num, towork_rec)
                        SELECT towork_num.nextval, to_num+1, novel_num, towork_rec FROM
                            (SELECT tot.towork_num, tot.to_num, tot.novel_num, tot.towork_rec, jt.hit_total_sum FROM towork_tbl tot     -- towork_tbl
                        LEFT JOIN 
                            (SELECT fb.novel_num, sum(fb.free_hit) as hit_total_sum FROM free_tbl fb GROUP BY fb.novel_num) jt          -- free_tbl(총 조회수 포함)
                        ON
                             tot.novel_num = jt.novel_num
                        ORDER BY towork_rec DESC, hit_total_sum DESC)
                        WHERE
                            to_num=1 AND rownum <= 4;
                        
                -- 6. towork_tbl에 잘 적재 되었나 확인 (완료)
                    SELECT * FROM towork_tbl;
                    
                -- 7. 2강에 적재하기 위해 이번에는 조회수를 변경해봄 (58 > 59 > 55 > 52)
                    -- 현재 작품번호 58, 59가 추천수가 동일하고 조회수는 58>59
                    -- 현재 작품번호 55, 52의 추천수가 동일하고 조회수는 55>52
                    
                    -- ♥ 총 조회수까지 편하게 비교하기 위해서 다시 그룹바이로 가져와서 확인하기
                        SELECT tot.towork_num, tot.to_num, tot.novel_num, tot.towork_rec, jt.hit_total_sum FROM (SELECT * FROM towork_tbl WHERE to_num=2) tot   
                            LEFT JOIN 
                        (SELECT fb.novel_num, sum(fb.free_hit) as hit_total_sum FROM free_tbl fb GROUP BY fb.novel_num) jt          -- free_tbl(총 조회수 포함)
                            ON
                        tot.novel_num = jt.novel_num
                            ORDER BY towork_rec DESC, hit_total_sum DESC ;
                    
                    -- 59와 52의 조회수를 더 높게 바꾸어야 함.
                        SELECT * FROM free_tbl WHERE novel_num=59;
                            UPDATE free_tbl SET free_hit = 2024 WHERE free_num=43;
                            UPDATE free_tbl SET free_hit = 3000 WHERE free_num=44;
                        SELECT * FROM free_tbl WHERE novel_num=52;
                            UPDATE free_tbl SET free_hit = 2024 WHERE free_num=30;
                            UPDATE free_tbl SET free_hit = 3000 WHERE free_num=31;
                            
                -- 8. 다시 7.을 실행하면 확인하면 이제 순위가 59 > 58 > 52 > 55 인 것을 볼 수 있음.
    
    -- 3. 2강에 적재하기
                -- 3.1 ▶ 1.8의 결과에서 상위 2개만 적재한다
                    INSERT INTO towork_tbl(towork_num, to_num, novel_num, towork_rec)
                        SELECT towork_num.nextval, to_num+1, novel_num, towork_rec FROM
                    (SELECT tot.towork_num, tot.to_num, tot.novel_num, tot.towork_rec, jt.hit_total_sum FROM towork_tbl tot     -- towork_tbl
                        LEFT JOIN 
                    (SELECT fb.novel_num, sum(fb.free_hit) as hit_total_sum FROM free_tbl fb GROUP BY fb.novel_num) jt          -- free_tbl(총 조회수 포함)
                        ON
                    tot.novel_num = jt.novel_num
                        ORDER BY towork_rec DESC, hit_total_sum DESC)
                    WHERE
                        to_num=2 AND rownum <= 2;
                        
                        
                -- 3.2 확인 (59, 58이 적재되어야 함)
                    SELECT * FROM towork_tbl;
                    DELETE FROM towork_tbl WHERe to_num=3;
                    
                    
                    delete from towork_tbl WHERE towork_num=615;
                    
            
      
      -- 4. 다시 해보기
        DELETE FROM towork_tbl WHERE to_num=1;
        DELETE FROM towork_tbl WHERE to_num=2;    -- 52, 55, 58, 59  
        DELETE FROM towork_tbl WHERE to_num=3;    -- 55, 59
        
        SELECT * FROM towork_tbl;
        commit;
        
        
        
        
        
        
    -- TournamentJoinVO (토너먼트 넘버, 토너먼트 이름, 노블번호, 토너먼트 작품 번호, 소설 제목, 작가, 추천수)
        SELECT tt.QCSJ_C000000000400000 as to_num, tt.to_name, tt.towork_num, nt.novel_title, nt.novel_writer, tt.towork_rec
	    FROM 
	        (SELECT * FROM tourna_tbl INNER JOIN towork_tbl ON tourna_tbl.to_num = towork_tbl.to_num) tt
	    INNER JOIN 
	        novel_tbl nt 
	    ON tt.novel_num = nt.novel_num WHERE tt.QCSJ_C000000000400000 = 3;
        
        -- tourna_tbl & towork_tbl을 조인함 -> 조인한 것에 novel_tbl을 조인함 (대회번호, 대회이름, 노블번호, 대회작품번호, 작품추천수)
        SELECT tt1.*, nt.novel_title, nt.novel_writer
            FROM
            (SELECT tt.to_num, tt.to_name, tot.towork_num, tot.novel_num, tot.towork_rec FROM towork_tbl tot
                LEFT JOIN tourna_tbl tt
                ON tt.to_num = tot.to_num) tt1
            LEFT JOIN
                novel_tbl nt
            ON tt1.novel_num = nt.novel_num
            WHERE tt1.to_num=3;
            
            
        --     
        UPDATE towork_tbl SET towork_rec =60 WHERE novel_num=55;
        UPDATE towork_tbl SET towork_rec= 50 WHERE novel_num=59 or novel_num=52;
        UPDATE towork_tbl SET towork_rec= 40 WHERE novel_num=58;
        UPDATE towork_tbl SET towork_rec= 20 WHERE novel_num=57 or novel_num=56 or novel_num=50 or novel_num=49;
        SELECT * FROM towork_tbl;
        
        
        
        
        
        -- 토너먼트 대회 날짜 변경하기
        
    -- 8강 데이터 보이게
    UPDATE tourna_tbl SET to_sdate ='22/04/28', to_edate = '22/05/29' WHERE to_num=1; 
    -- 8강 되돌리기
    UPDATE tourna_tbl SET to_sdate = '22/05/06', to_edate='22/05/13' WHERE to_num=1; 
    
    -- 4강 데이터 보이게
    UPDATE tourna_tbl SET to_edate = '22/05/29' WHERE to_num=2; 
    -- 4강 되돌리기
    UPDATE tourna_tbl SET to_sdate = '22/05/13', to_edate='22/05/20' WHERE to_num=2; 
     
    -- 2강 데이터 안 보이게
    UPDATE tourna_tbl SET to_sdate = '22/05/29' WHERE to_num=3; 
    -- 2강 되돌리기
    UPDATE tourna_tbl SET to_sdate = '22/05/20', to_edate='22/05/27' WHERE to_num=3; 
        
    SELECT * FROM tourna_tbl;
    
    commit;
    
    SELECT * FROM towork_tbl;
    SELECT * FROM torec_tbl;
    --delete from torec_tbl;
    
    SELECT * FROM free_tbl;
    SELECT * FROM novel_tbl;
    
    -- 예상 우승 작품
    
    SELECT * 
        FROM 
    (SELECT tt.to_num, tt.towork_num, nt.novel_title, nt.novel_writer, tt.towork_rec FROM towork_tbl tt INNER JOIN novel_tbl nt ON tt.novel_num = nt.novel_num ORDER BY towork_rec DESC, to_num DESC) 
        WHERE 
    rownum <= 1;
    
    SELECT tt.to_num, tt.towork_num, nt.novel_title, nt.novel_writer, tt.towork_rec FROM towork_tbl tt INNER JOIN novel_tbl nt ON tt.novel_num = nt.novel_num ORDER BY to_num DESC, towork_rec DESC ;
    
    
    -- 추천수가 같은 경우 총 조회수까지 포함하도록 변경
    
            -- 이전 구문 복사(이클립스)
                SELECT * 
                    FROM 
                (SELECT tt.to_num, tt.towork_num, nt.novel_title, nt.novel_writer, tt.towork_rec FROM towork_tbl tt INNER JOIN novel_tbl nt ON tt.novel_num = nt.novel_num ORDER BY towork_rec DESC, to_num DESC) 
                    WHERE 
                rownum <= 1;
                    
                    commit;
                    

    -- towork_tbl, tourna_tbl, novel_tbl, free_tbl

    -- 1. joinVO에 필요한 컬럼 생성
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
    ORDER BY to_num DESC;
    
    -- 2. 소설번호랑 총 조회수 가져옴
    SELECT novel_num, sum(free_hit) FROM free_tbl group by novel_num;
    
    
    -- ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ 확인용 ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
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
        SELECT novel_num, sum(free_hit) as totalrec FROM free_tbl group by novel_num
        ) tt3
    ON tt2.novel_num = tt3.novel_num
    ORDER BY to_num DESC, towork_rec DESC, totalrec DESC;
    
    
    
    -- 4. 3의 결과에서 최상위 값을 잘라냄
    SELECT * FROM (
        SELECT tt2.* FROM ( 
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
            SELECT novel_num, sum(free_hit) as totalrec FROM free_tbl group by novel_num
            ) tt3
        ON tt2.novel_num = tt3.novel_num
        ORDER BY to_num DESC, towork_rec DESC, totalrec DESC
       )
       WHERE rownum <= 1;
       
       commit;
       
       
       
       -- 토너먼트가 끝나면 1주일 공백 후 다시 토너먼트 시작하도록
            -- 1. tourna_tbl에 4번째 기간을 적재한다.
            SELECT * FROM tourna_tbl;
            
                --INSERT 순서
                -- 1)
                INSERT INTO tourna_tbl (to_num, to_name) values 
                                        (to_num.nextval,'다음 대회 준비기간');
                -- 2)
                UPDATE tourna_tbl 
                    SET to_edate = to_sdate + (INTERVAL '7' DAY)
                    WHERE to_num='4';
                    
                -- 잠깐 수정
                UPDATE tourna_tbl SET to_sdate = '22/05/21' WHERE to_num = 4;
                
            -- 2. 토너먼트가 끝나면 선정된 작품의 변경점을 적용한다.
                -- 2.1 novel_tbl에서 week를 바꾸어주어야 함.
                    -- 나중에는 novel_week 어떻게 정할지 ( 자동으로 해줄지 수기로 바꿀지 ) 정해야함.
                SELECT * FROM novel_tbl; 
                commit;
                
                UPDATE novel_tbl SET novel_week = 'sun' WHERE novel_num=59;
                -- 2.2 free_tbl에서 당선된 작품의 회차들을 모두 삭제
                DELETE FROM free_tbl where novel_num = 59;
                SELECT * FROM free_tbl;
                
                        -- ◆◆◆ 실제로 데이터를 삭제했을 때 복구하기 ◆◆◆
                            -- 다 삭제한 경우
                            INSERT INTO free_tbl (
                                SELECT * 
                                FROM free_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '10' MINUTE)
                            );
                            -- 일부 row 삭제한 경우
                            INSERT INTO free_tbl(
                                SELECT * 
                                    FROM free_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '100' MINUTE) WHERE novel_num=59
                            );
                        
                -- 2.3 해당 작가의 등급을 올려준다.
                
                    -- 토너먼트 최 상단의 row에서 novel_num을 가져옴
                       SELECT novel_num FROM (
                            SELECT tt2.* FROM ( 
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
                                SELECT novel_num, sum(free_hit) as totalrec FROM free_tbl group by novel_num
                                ) tt3
                            ON tt2.novel_num = tt3.novel_num
                            ORDER BY to_num DESC, towork_rec DESC, totalrec DESC
                           )
                        WHERE rownum <= 1;
                        
                    -- 해당 novel_num을 작성한 user_id 가져옴 ( 결과 : user10 )
                        -- row 1개 가져오는 select문에서 .getnovel_num 해서 가져온 다음에
                        -- SELECT user_id FROM novel_tbl WHERE novel_num = #{novel_num} 매퍼 하나 만들어서 해도 되긴 되는데 
                        -- 아래 구문 사용할 듯.
                    SELECT user_id FROM novel_tbl WHERE novel_num = (
                         SELECT novel_num FROM (
                            SELECT tt2.* FROM ( 
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
                                SELECT novel_num, sum(free_hit) as totalrec FROM free_tbl group by novel_num
                                ) tt3
                            ON tt2.novel_num = tt3.novel_num
                            ORDER BY to_num DESC, towork_rec DESC, totalrec DESC
                           )
                        WHERE rownum <= 1
                    );
                    
                SELECT * FROM auth_tbl WHERE user_id = 'user10';   
                UPDATE auth_tbl SET auth = 'ROLE_PAID_WRITER' WHERE user_id = 'user10';
                SELECT * FROM auth_tbl WHERE user_id = 'user10';  
                
                
                -- 코드가 너무 길어서 줄이기
                    -- 목표 : 내가 필요한건 towork_tbl의 최상위 row와 관련된 user_id임
                        -- 1. 총 조회수를 가져와야 하니까 towork_tbl과 free_tbl(총 조회수 포함)을 조인한다.
                        -- 2. 조인한 데이터를 order by로 1) 대회번호 내림차순 2) 추천수 내림차순 3) 총조회수 내림차순 한다.
                        SELECT * FROM (
                            SELECT * FROM towork_tbl tot
                                LEFT JOIN
                            (SELECT novel_num, sum(free_hit) as totalrec FROM free_tbl group by novel_num) ft
                                ON tot.novel_num = ft.novel_num
                        )
                        ORDER BY to_num DESC, towork_rec DESC, totalrec DESC;
                        
                        SELECT * FROM free_tbl WHERE novel_num= 59;
                        
                        
                        -- 3. ▶ 최상위 row 하나를 골라낸다 -> *을 tt2.novel_num으로 바꾸면 => 최상위 row의 novel_num을 가져옴
                        SELECT tt2.novel_num FROM(
                                SELECT tt1.* FROM (
                                    SELECT tot.*, ft.totalrec FROM towork_tbl tot
                                        LEFT JOIN
                                    (SELECT novel_num, sum(free_hit) as totalrec FROM free_tbl group by novel_num) ft
                                        ON tot.novel_num = ft.novel_num
                                ) tt1
                                ORDER BY 
                                    to_num DESC, towork_rec DESC, totalrec DESC
                            ) tt2
                        WHERE rownum <= 1;
                        
                        
                        -- 4. ▶ 3에서 얻어온 우승 작품 번호를 novel_tbl에서 필터링을 해서 해당 '유저 아이디' 얻어오기 ( 결과 : user10 ) 
                        
                        SELECT user_id FROM novel_tbl 
                            WHERE novel_num = 
                            (
                                SELECT tt2.novel_num FROM(
                                    SELECT tt1.* FROM (
                                        SELECT tot.*, ft.totalrec FROM towork_tbl tot
                                            LEFT JOIN
                                        (SELECT novel_num, sum(free_hit) as totalrec FROM free_tbl group by novel_num) ft
                                            ON tot.novel_num = ft.novel_num
                                    ) tt1
                                    ORDER BY 
                                        to_num DESC, towork_rec DESC, totalrec DESC
                                ) tt2
                                WHERE rownum <= 1
                            );
                            
                        -- 5. ▶ 해당 유저의 등급을 바꾸어준다. ( ROLE_FREE_WRITER -> ROLE_PAID_WRITER )
                        SELECT * FROM auth_tbl WHERE user_id = 'user10';
                        UPDATE auth_tbl SET auth = 'ROLE_FREE_WRITER' WHERE user_id = 'user10';
                        
                        commit;
                        
                        
        commit;
        
        
         SELECT tt2.novel_num FROM(
                SELECT tt1.* FROM (
                    SELECT tot.*, ft.totalrec FROM towork_tbl tot
                        LEFT JOIN
                    (SELECT novel_num, sum(free_hit) as totalrec FROM free_tbl group by novel_num) ft
                        ON tot.novel_num = ft.novel_num
                ) tt1
                ORDER BY 
                    to_num DESC, towork_rec DESC, totalrec DESC
            ) tt2
        WHERE rownum <= 1;
        
        
        
    
    
    -- 대회 우승자 선정 후, 토너먼트 날짜 변경하기
    
        -- 조회
        SELECT * FROM tourna_tbl;
        
        -- 변경 시도
        
        UPDATE tourna_tbl 
            SET to_edate = to_sdate + (INTERVAL '7' DAY)
            WHERE to_num='4';
            
        SELECT to_sdate FROM tourna_tbl WHERE to_num='1';
        
        
        -- 준비 종료일을 기준으로
            -- 8강   : 시작(종+0)  / 종료(종+7)
            -- 4강   : 시작(종+7)  / 종료(종+14)
            -- 2강   : 시작(종+14) / 종료(종+21)
            -- 준비  : 시작(종+21) / 종료(종+28)
            
            -- 준비 종료일
            SELECT to_edate FROM tourna_tbl WHERE to_num=4;
            
            -- ▶ 8강 업데이트
            UPDATE 
                tourna_tbl 
            SET 
                to_sdate = (SELECT to_edate FROM tourna_tbl WHERE to_num=4) +0,
                to_edate = (SELECT to_edate FROM tourna_tbl WHERE to_num=4) +7
            WHERE
                to_num=1;
                
            -- ▶ 4강 업데이트
            UPDATE 
                tourna_tbl 
            SET 
                to_sdate = (SELECT to_edate FROM tourna_tbl WHERE to_num=4) +7,
                to_edate = (SELECT to_edate FROM tourna_tbl WHERE to_num=4) +14
            WHERE
                to_num=2;
                
            -- ▶ 2강 업데이트
            UPDATE 
                tourna_tbl 
            SET 
                to_sdate = (SELECT to_edate FROM tourna_tbl WHERE to_num=4) +14,
                to_edate = (SELECT to_edate FROM tourna_tbl WHERE to_num=4) +21
            WHERE
                to_num=3;
                
            -- ▶ 대회 업데이트
            UPDATE 
                tourna_tbl 
            SET 
                to_sdate = (SELECT to_edate FROM tourna_tbl WHERE to_num=4) +21,
                to_edate = (SELECT to_edate FROM tourna_tbl WHERE to_num=4) +28
            WHERE
                to_num=4;
                
                
                
     -- torec_tbl(추천 기록)의 데이터를 비워줌
        SELECT * FROM torec_tbl;
        delete from torec_tbl;
        
        commit;
        
        -- 데이터 복구
        INSERT INTO torec_tbl(
            SELECT * 
                FROM torec_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '100' MINUTE) -- WHERE novel_num=59
        );
        
        DELETE FROM torec_tbl;
        
    -- towork_tbl(대회 출전 기록)의 데이터를 비워줌
        SELECT * FROM towork_tbl;
        commit;
        
        -- 데이터 삭제
        DELETE FROM towork_tbl;
        
        -- 데이터 복구
        INSERT INTO towork_tbl(
            SELECT * 
                FROM towork_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '100' MINUTE) -- WHERE novel_num=59
        );
        
        
        SELECT * FROM tourna_tbl;
        
        
        SELECT * FROM tourna_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '100' MINUTE);
                
            
        
        SELECT * FROM novel_tbl;
        
        
        -- ※※※※※※※※※※※※※※※※※※※※※※※※※※※※ 모든 towork_tbl 리스트 확인 ※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※
        
        SELECT * FROM (
	        SELECT * FROM (  -- tt2.*
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
	            SELECT novel_num, sum(free_hit) as totalrec FROM free_tbl group by novel_num
	            ) tt3
	        ON tt2.novel_num = tt3.novel_num
	        ORDER BY to_num DESC, towork_rec DESC, totalrec DESC
	       );
       --WHERE rownum <= 1;
       
       select * FROM novel_tbl;
       
       
       
       
       -- 사후처리 잘 되었나 확인 (현재 1등 novel_num=59, user_id=user10)
       
            -- 1. novel_tbl에서 week
            SELECT * FROM novel_tbl;
                -- 이전 상태로 세팅
                UPDATE novel_tbl SET novel_week = 'free' WHERE novel_num=17;
                
                delete from novel_tbl;
                
            -- 2. auth_tbl에서 등급 변경
            SELECT * FROM auth_tbl;
                -- 이전 상태로 세팅
                UPDATE auth_tbl SET auth='ROLE_FREE_WRITER' WHERE user_id='freeWriter0';
                
            -- 3. free_tbl에서 연재했던 데이터 삭제
            SELECT * FROM free_tbl;
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
                    UPDATE tourna_tbl SET to_sdate = '22/05/29', to_edate='22/06/12' WHERE to_num=4;
                    
                    -- 휴식기 수정(종료 버튼 나오게. to_sdate를 오늘 날짜로)
                    UPDATE tourna_tbl SET to_sdate = '22/05/30', to_edate='22/05/28' WHERE to_num=4;
                    
                    commit;
                    
            -- 5. torec_tbl 데이터 삭제
            SELECT * FROM torec_tbl;
                -- 데이터 세팅
                UPDATE towork_tbl SET towork_rec=59 WHERE novel_num=16;
                SELECT * FROM towork_tbl;
                DELETE FROM torec_tbl;
                commit;

            -- 6. towork_tbl 데이터 삭제 (이거 난리나서 다시 적재해야됨)
            SELECT * FROM towork_tbl;
                -- 이전 상태로 세팅
                INSERT INTO towork_tbl(
                    SELECT * 
                        FROM towork_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '20' MINUTE)
                );
                
                  SELECT * 
                        FROM towork_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '20' MINUTE);
            
                DELETE FROM towork_tbl ;
                
                -- towork_tbl에 새 데이터 적재 후 추천수 넣기
                UPDATE towork_tbl SET towork_rec = 59 WHERE novel_num= 16;
                UPDATE towork_tbl SET towork_rec = 60 WHERE novel_num= 17;
                UPDATE towork_tbl SET towork_rec = 40 WHERE novel_num= 18 or novel_num =21 or novel_num=25;
                UPDATE towork_tbl SET towork_rec = 20 WHERE novel_num= 28 or novel_num =30 or novel_num=31;
            
            commit;
            
        
            
            
        -- total 추천수까지 확인하기
        SELECT * FROM (
	        SELECT * FROM ( -- tt2.*
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
	            SELECT novel_num, sum(free_hit) as totalrec FROM free_tbl group by novel_num
	            ) tt3
	        ON tt2.novel_num = tt3.novel_num
	        ORDER BY to_num DESC, towork_rec DESC, totalrec DESC
	       );
       --WHERE rownum <= 1;

            
            
        commit;
        
        
        
        
        
        -- 초기화 버튼 비활성화 하기
        SELECT * FROM tourna_tbl;
            -- 비활성화 하는 구문(오늘로 세팅)
            UPDATE tourna_tbl SET to_sdate = '22/05/19' WHERE to_num=4;
            -- 되돌리기
            UPDATE tourna_tbl SET to_sdate = '22/05/21' WHERE to_num=4;
            
            commit;
        
        
        
        
                
      
                    
        
    
        