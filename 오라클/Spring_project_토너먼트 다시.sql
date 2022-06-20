-- ��ʸ�Ʈ,,, ���ο� �������� ����


    -- ���� novel, free, paid, towork, torec �ٷ� ������ ����(������ x)

-- Ű���� : order by ��������

    -- 0. 8�� ���̺� ����
        -- ���� �Ҽ� ��, �� ��õ��*10 + �� ��ȸ���� 8���� towork_tbl�� ����
        -- �� ��õ���� �� ��ȸ���� novel_num���� �׷�����Ͽ� ���´�
        
            -- ���� free ���̺��� �ش� ���ǿ� �´� ���� ��ȸ
            SELECT * FROM free_tbl fb ;
            SELECT fb.novel_num, sum(fb.free_rec) ,sum(fb.free_hit) FROM free_tbl fb GROUP BY fb.novel_num;
            SELECT fb.novel_num, sum(fb.free_rec) ,sum(fb.free_hit), sum(fb.free_rec)*10 + sum(fb.free_hit) FROM free_tbl fb GROUP BY fb.novel_num ORDER BY sum(fb.free_rec)*10 + sum(fb.free_hit) DESC;
            
            -- �ű⼭ ���� 8���� �߸�
            SELECT * FROM (SELECT fb.novel_num, sum(fb.free_rec) ,sum(fb.free_hit), sum(fb.free_rec)*10 + sum(fb.free_hit) FROM free_tbl fb GROUP BY fb.novel_num ORDER BY sum(fb.free_rec)*10 + sum(fb.free_hit) DESC) WHERE rownum <= 8;
            
            -- �� (8��)������ �������� novel_num�� ������ ��
            SELECT novel_num FROM (SELECT fb.novel_num FROM free_tbl fb GROUP BY fb.novel_num ORDER BY sum(fb.free_rec)*10 + sum(fb.free_hit) DESC) WHERE rownum <= 8;
            commit;
        
            -- �� towork_tbl�� 8���� �ڷḦ TournamentMapper�� insert select�� ����ؼ� ���� ���̴� (���̺�ѹ�ai, ��ʸ�Ʈ ��ȣ, ��ǰ ��ȣ)
            
            
            SELECT * FROM towork_tbl;
            SELECT * FROM tourna_tbl;
            
    -- 1. 4���� �����ϱ� (ORDER BY ���� �ɱ� ��� : ��õ�� -> �� ��ȸ��)
                -- 1. group by�� ����ؼ� free_tbl���� �� ��ȸ���� novel_num�� �����´�.
                     SELECT fb.novel_num, sum(fb.free_hit) FROM free_tbl fb GROUP BY fb.novel_num;
                -- 2. towork_tbl�� �����Ѵ�. => ��ȸ��ǰ��ȣ, ��ȸ��ȣ, ��ǰ��ȣ, ��õ��, ����ȸ��
                     SELECT tot.towork_num, tot.to_num, tot.novel_num, tot.towork_rec, jt.hit_total_sum FROM towork_tbl tot     -- towork_tbl
                        LEFT JOIN 
                    (SELECT fb.novel_num, sum(fb.free_hit) as hit_total_sum FROM free_tbl fb GROUP BY fb.novel_num) jt          -- free_tbl(�� ��ȸ�� ����)
                        ON
                    tot.novel_num = jt.novel_num
                        ORDER BY towork_rec DESC, hit_total_sum DESC ;                                                          -- ��õ�� -> ����ȸ���� ����
                        
                -- 3. towork_rec�� 0�̾ ����� ���� �𸣰����ϱ� �����ؼ� ���غ� (2. �� �����ؼ� Ȯ�� �Ϸ�)
                    UPDATE towork_tbl SET towork_rec = 50 WHERE towork_num=683;
                    UPDATE towork_tbl SET towork_rec = 40 WHERE towork_num=684;
                    UPDATE towork_tbl SET towork_rec = 50 WHERE towork_num=682;
                    UPDATE towork_tbl SET towork_rec = 60 WHERE towork_num=685;
                    UPDATE towork_tbl SET towork_rec = 40 WHERE towork_num=599;

                    
                -- 4. 2�� ������� ���� 4���� �ڸ���
                    --SELECT to_num, novel_num, towork_rec, hit_total_sum FROM
                    SELECT to_num, novel_num, towork_rec, hit_total_sum FROM
                    (SELECT tot.towork_num, tot.to_num, tot.novel_num, tot.towork_rec, jt.hit_total_sum FROM towork_tbl tot                    -- towork_tbl
                        LEFT JOIN 
                    (SELECT fb.novel_num, sum(fb.free_hit) as hit_total_sum FROM free_tbl fb GROUP BY fb.novel_num) jt       -- free_tbl(�� ��ȸ�� ����)
                        ON
                    tot.novel_num = jt.novel_num
                        ORDER BY towork_rec DESC, hit_total_sum DESC)
                    WHERE
                        to_num=1 AND rownum <= 4;
                        
                -- 5. �� 4�� ����� towork_num ���̺� �����Ѵ�.(to_num���� +1 ���ش�)
                    -- towork_tbl�� �� ��õ�� �÷� �߰��ؾ��ϳ� �;��µ� �׳� �׶��׶� ������ �� �ִ��� Ȯ��
                    INSERT INTO towork_tbl(towork_num, to_num, novel_num, towork_rec)
                        SELECT towork_num.nextval, to_num+1, novel_num, towork_rec FROM
                    (SELECT tot.towork_num, tot.to_num, tot.novel_num, tot.towork_rec, jt.hit_total_sum FROM towork_tbl tot     -- towork_tbl
                        LEFT JOIN 
                    (SELECT fb.novel_num, sum(fb.free_hit) as hit_total_sum FROM free_tbl fb GROUP BY fb.novel_num) jt          -- free_tbl(�� ��ȸ�� ����)
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
                            (SELECT fb.novel_num, sum(fb.free_hit) as hit_total_sum FROM free_tbl fb GROUP BY fb.novel_num) jt          -- free_tbl(�� ��ȸ�� ����)
                        ON
                             tot.novel_num = jt.novel_num
                        ORDER BY towork_rec DESC, hit_total_sum DESC)
                        WHERE
                            to_num=1 AND rownum <= 4;
                        
                -- 6. towork_tbl�� �� ���� �Ǿ��� Ȯ�� (�Ϸ�)
                    SELECT * FROM towork_tbl;
                    
                -- 7. 2���� �����ϱ� ���� �̹����� ��ȸ���� �����غ� (58 > 59 > 55 > 52)
                    -- ���� ��ǰ��ȣ 58, 59�� ��õ���� �����ϰ� ��ȸ���� 58>59
                    -- ���� ��ǰ��ȣ 55, 52�� ��õ���� �����ϰ� ��ȸ���� 55>52
                    
                    -- �� �� ��ȸ������ ���ϰ� ���ϱ� ���ؼ� �ٽ� �׷���̷� �����ͼ� Ȯ���ϱ�
                        SELECT tot.towork_num, tot.to_num, tot.novel_num, tot.towork_rec, jt.hit_total_sum FROM (SELECT * FROM towork_tbl WHERE to_num=2) tot   
                            LEFT JOIN 
                        (SELECT fb.novel_num, sum(fb.free_hit) as hit_total_sum FROM free_tbl fb GROUP BY fb.novel_num) jt          -- free_tbl(�� ��ȸ�� ����)
                            ON
                        tot.novel_num = jt.novel_num
                            ORDER BY towork_rec DESC, hit_total_sum DESC ;
                    
                    -- 59�� 52�� ��ȸ���� �� ���� �ٲپ�� ��.
                        SELECT * FROM free_tbl WHERE novel_num=59;
                            UPDATE free_tbl SET free_hit = 2024 WHERE free_num=43;
                            UPDATE free_tbl SET free_hit = 3000 WHERE free_num=44;
                        SELECT * FROM free_tbl WHERE novel_num=52;
                            UPDATE free_tbl SET free_hit = 2024 WHERE free_num=30;
                            UPDATE free_tbl SET free_hit = 3000 WHERE free_num=31;
                            
                -- 8. �ٽ� 7.�� �����ϸ� Ȯ���ϸ� ���� ������ 59 > 58 > 52 > 55 �� ���� �� �� ����.
    
    -- 3. 2���� �����ϱ�
                -- 3.1 �� 1.8�� ������� ���� 2���� �����Ѵ�
                    INSERT INTO towork_tbl(towork_num, to_num, novel_num, towork_rec)
                        SELECT towork_num.nextval, to_num+1, novel_num, towork_rec FROM
                    (SELECT tot.towork_num, tot.to_num, tot.novel_num, tot.towork_rec, jt.hit_total_sum FROM towork_tbl tot     -- towork_tbl
                        LEFT JOIN 
                    (SELECT fb.novel_num, sum(fb.free_hit) as hit_total_sum FROM free_tbl fb GROUP BY fb.novel_num) jt          -- free_tbl(�� ��ȸ�� ����)
                        ON
                    tot.novel_num = jt.novel_num
                        ORDER BY towork_rec DESC, hit_total_sum DESC)
                    WHERE
                        to_num=2 AND rownum <= 2;
                        
                        
                -- 3.2 Ȯ�� (59, 58�� ����Ǿ�� ��)
                    SELECT * FROM towork_tbl;
                    DELETE FROM towork_tbl WHERe to_num=3;
                    
                    
                    delete from towork_tbl WHERE towork_num=615;
                    
            
      
      -- 4. �ٽ� �غ���
        DELETE FROM towork_tbl WHERE to_num=1;
        DELETE FROM towork_tbl WHERE to_num=2;    -- 52, 55, 58, 59  
        DELETE FROM towork_tbl WHERE to_num=3;    -- 55, 59
        
        SELECT * FROM towork_tbl;
        commit;
        
        
        
        
        
        
    -- TournamentJoinVO (��ʸ�Ʈ �ѹ�, ��ʸ�Ʈ �̸�, ����ȣ, ��ʸ�Ʈ ��ǰ ��ȣ, �Ҽ� ����, �۰�, ��õ��)
        SELECT tt.QCSJ_C000000000400000 as to_num, tt.to_name, tt.towork_num, nt.novel_title, nt.novel_writer, tt.towork_rec
	    FROM 
	        (SELECT * FROM tourna_tbl INNER JOIN towork_tbl ON tourna_tbl.to_num = towork_tbl.to_num) tt
	    INNER JOIN 
	        novel_tbl nt 
	    ON tt.novel_num = nt.novel_num WHERE tt.QCSJ_C000000000400000 = 3;
        
        -- tourna_tbl & towork_tbl�� ������ -> ������ �Ϳ� novel_tbl�� ������ (��ȸ��ȣ, ��ȸ�̸�, ����ȣ, ��ȸ��ǰ��ȣ, ��ǰ��õ��)
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
        
        
        
        
        
        -- ��ʸ�Ʈ ��ȸ ��¥ �����ϱ�
        
    -- 8�� ������ ���̰�
    UPDATE tourna_tbl SET to_sdate ='22/04/28', to_edate = '22/05/29' WHERE to_num=1; 
    -- 8�� �ǵ�����
    UPDATE tourna_tbl SET to_sdate = '22/05/06', to_edate='22/05/13' WHERE to_num=1; 
    
    -- 4�� ������ ���̰�
    UPDATE tourna_tbl SET to_edate = '22/05/29' WHERE to_num=2; 
    -- 4�� �ǵ�����
    UPDATE tourna_tbl SET to_sdate = '22/05/13', to_edate='22/05/20' WHERE to_num=2; 
     
    -- 2�� ������ �� ���̰�
    UPDATE tourna_tbl SET to_sdate = '22/05/29' WHERE to_num=3; 
    -- 2�� �ǵ�����
    UPDATE tourna_tbl SET to_sdate = '22/05/20', to_edate='22/05/27' WHERE to_num=3; 
        
    SELECT * FROM tourna_tbl;
    
    commit;
    
    SELECT * FROM towork_tbl;
    SELECT * FROM torec_tbl;
    --delete from torec_tbl;
    
    SELECT * FROM free_tbl;
    SELECT * FROM novel_tbl;
    
    -- ���� ��� ��ǰ
    
    SELECT * 
        FROM 
    (SELECT tt.to_num, tt.towork_num, nt.novel_title, nt.novel_writer, tt.towork_rec FROM towork_tbl tt INNER JOIN novel_tbl nt ON tt.novel_num = nt.novel_num ORDER BY towork_rec DESC, to_num DESC) 
        WHERE 
    rownum <= 1;
    
    SELECT tt.to_num, tt.towork_num, nt.novel_title, nt.novel_writer, tt.towork_rec FROM towork_tbl tt INNER JOIN novel_tbl nt ON tt.novel_num = nt.novel_num ORDER BY to_num DESC, towork_rec DESC ;
    
    
    -- ��õ���� ���� ��� �� ��ȸ������ �����ϵ��� ����
    
            -- ���� ���� ����(��Ŭ����)
                SELECT * 
                    FROM 
                (SELECT tt.to_num, tt.towork_num, nt.novel_title, nt.novel_writer, tt.towork_rec FROM towork_tbl tt INNER JOIN novel_tbl nt ON tt.novel_num = nt.novel_num ORDER BY towork_rec DESC, to_num DESC) 
                    WHERE 
                rownum <= 1;
                    
                    commit;
                    

    -- towork_tbl, tourna_tbl, novel_tbl, free_tbl

    -- 1. joinVO�� �ʿ��� �÷� ����
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
    
    -- 2. �Ҽ���ȣ�� �� ��ȸ�� ������
    SELECT novel_num, sum(free_hit) FROM free_tbl group by novel_num;
    
    
    -- ��������������������������������� Ȯ�ο� ���������������������������������
    -- 3. 1�� 2�� ������ ����Ʈ
    SELECT * FROM ( -- �̰� �´��� Ȯ���Ϸ��� tt2.*�� *�� �ٲ㼭 Ȯ���ϸ� ��
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
    
    
    
    -- 4. 3�� ������� �ֻ��� ���� �߶�
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
       
       
       
       -- ��ʸ�Ʈ�� ������ 1���� ���� �� �ٽ� ��ʸ�Ʈ �����ϵ���
            -- 1. tourna_tbl�� 4��° �Ⱓ�� �����Ѵ�.
            SELECT * FROM tourna_tbl;
            
                --INSERT ����
                -- 1)
                INSERT INTO tourna_tbl (to_num, to_name) values 
                                        (to_num.nextval,'���� ��ȸ �غ�Ⱓ');
                -- 2)
                UPDATE tourna_tbl 
                    SET to_edate = to_sdate + (INTERVAL '7' DAY)
                    WHERE to_num='4';
                    
                -- ��� ����
                UPDATE tourna_tbl SET to_sdate = '22/05/21' WHERE to_num = 4;
                
            -- 2. ��ʸ�Ʈ�� ������ ������ ��ǰ�� �������� �����Ѵ�.
                -- 2.1 novel_tbl���� week�� �ٲپ��־�� ��.
                    -- ���߿��� novel_week ��� ������ ( �ڵ����� ������ ����� �ٲ��� ) ���ؾ���.
                SELECT * FROM novel_tbl; 
                commit;
                
                UPDATE novel_tbl SET novel_week = 'sun' WHERE novel_num=59;
                -- 2.2 free_tbl���� �缱�� ��ǰ�� ȸ������ ��� ����
                DELETE FROM free_tbl where novel_num = 59;
                SELECT * FROM free_tbl;
                
                        -- �ߡߡ� ������ �����͸� �������� �� �����ϱ� �ߡߡ�
                            -- �� ������ ���
                            INSERT INTO free_tbl (
                                SELECT * 
                                FROM free_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '10' MINUTE)
                            );
                            -- �Ϻ� row ������ ���
                            INSERT INTO free_tbl(
                                SELECT * 
                                    FROM free_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '100' MINUTE) WHERE novel_num=59
                            );
                        
                -- 2.3 �ش� �۰��� ����� �÷��ش�.
                
                    -- ��ʸ�Ʈ �� ����� row���� novel_num�� ������
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
                        
                    -- �ش� novel_num�� �ۼ��� user_id ������ ( ��� : user10 )
                        -- row 1�� �������� select������ .getnovel_num �ؼ� ������ ������
                        -- SELECT user_id FROM novel_tbl WHERE novel_num = #{novel_num} ���� �ϳ� ���� �ص� �Ǳ� �Ǵµ� 
                        -- �Ʒ� ���� ����� ��.
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
                
                
                -- �ڵ尡 �ʹ� �� ���̱�
                    -- ��ǥ : ���� �ʿ��Ѱ� towork_tbl�� �ֻ��� row�� ���õ� user_id��
                        -- 1. �� ��ȸ���� �����;� �ϴϱ� towork_tbl�� free_tbl(�� ��ȸ�� ����)�� �����Ѵ�.
                        -- 2. ������ �����͸� order by�� 1) ��ȸ��ȣ �������� 2) ��õ�� �������� 3) ����ȸ�� �������� �Ѵ�.
                        SELECT * FROM (
                            SELECT * FROM towork_tbl tot
                                LEFT JOIN
                            (SELECT novel_num, sum(free_hit) as totalrec FROM free_tbl group by novel_num) ft
                                ON tot.novel_num = ft.novel_num
                        )
                        ORDER BY to_num DESC, towork_rec DESC, totalrec DESC;
                        
                        SELECT * FROM free_tbl WHERE novel_num= 59;
                        
                        
                        -- 3. �� �ֻ��� row �ϳ��� ��󳽴� -> *�� tt2.novel_num���� �ٲٸ� => �ֻ��� row�� novel_num�� ������
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
                        
                        
                        -- 4. �� 3���� ���� ��� ��ǰ ��ȣ�� novel_tbl���� ���͸��� �ؼ� �ش� '���� ���̵�' ������ ( ��� : user10 ) 
                        
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
                            
                        -- 5. �� �ش� ������ ����� �ٲپ��ش�. ( ROLE_FREE_WRITER -> ROLE_PAID_WRITER )
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
        
        
        
    
    
    -- ��ȸ ����� ���� ��, ��ʸ�Ʈ ��¥ �����ϱ�
    
        -- ��ȸ
        SELECT * FROM tourna_tbl;
        
        -- ���� �õ�
        
        UPDATE tourna_tbl 
            SET to_edate = to_sdate + (INTERVAL '7' DAY)
            WHERE to_num='4';
            
        SELECT to_sdate FROM tourna_tbl WHERE to_num='1';
        
        
        -- �غ� �������� ��������
            -- 8��   : ����(��+0)  / ����(��+7)
            -- 4��   : ����(��+7)  / ����(��+14)
            -- 2��   : ����(��+14) / ����(��+21)
            -- �غ�  : ����(��+21) / ����(��+28)
            
            -- �غ� ������
            SELECT to_edate FROM tourna_tbl WHERE to_num=4;
            
            -- �� 8�� ������Ʈ
            UPDATE 
                tourna_tbl 
            SET 
                to_sdate = (SELECT to_edate FROM tourna_tbl WHERE to_num=4) +0,
                to_edate = (SELECT to_edate FROM tourna_tbl WHERE to_num=4) +7
            WHERE
                to_num=1;
                
            -- �� 4�� ������Ʈ
            UPDATE 
                tourna_tbl 
            SET 
                to_sdate = (SELECT to_edate FROM tourna_tbl WHERE to_num=4) +7,
                to_edate = (SELECT to_edate FROM tourna_tbl WHERE to_num=4) +14
            WHERE
                to_num=2;
                
            -- �� 2�� ������Ʈ
            UPDATE 
                tourna_tbl 
            SET 
                to_sdate = (SELECT to_edate FROM tourna_tbl WHERE to_num=4) +14,
                to_edate = (SELECT to_edate FROM tourna_tbl WHERE to_num=4) +21
            WHERE
                to_num=3;
                
            -- �� ��ȸ ������Ʈ
            UPDATE 
                tourna_tbl 
            SET 
                to_sdate = (SELECT to_edate FROM tourna_tbl WHERE to_num=4) +21,
                to_edate = (SELECT to_edate FROM tourna_tbl WHERE to_num=4) +28
            WHERE
                to_num=4;
                
                
                
     -- torec_tbl(��õ ���)�� �����͸� �����
        SELECT * FROM torec_tbl;
        delete from torec_tbl;
        
        commit;
        
        -- ������ ����
        INSERT INTO torec_tbl(
            SELECT * 
                FROM torec_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '100' MINUTE) -- WHERE novel_num=59
        );
        
        DELETE FROM torec_tbl;
        
    -- towork_tbl(��ȸ ���� ���)�� �����͸� �����
        SELECT * FROM towork_tbl;
        commit;
        
        -- ������ ����
        DELETE FROM towork_tbl;
        
        -- ������ ����
        INSERT INTO towork_tbl(
            SELECT * 
                FROM towork_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '100' MINUTE) -- WHERE novel_num=59
        );
        
        
        SELECT * FROM tourna_tbl;
        
        
        SELECT * FROM tourna_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '100' MINUTE);
                
            
        
        SELECT * FROM novel_tbl;
        
        
        -- �ءءءءءءءءءءءءءءءءءءءءءءءءءءء� ��� towork_tbl ����Ʈ Ȯ�� �ءءءءءءءءءءءءءءءءءءءءءءءءءءءءءءءءءء�
        
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
       
       
       
       
       -- ����ó�� �� �Ǿ��� Ȯ�� (���� 1�� novel_num=59, user_id=user10)
       
            -- 1. novel_tbl���� week
            SELECT * FROM novel_tbl;
                -- ���� ���·� ����
                UPDATE novel_tbl SET novel_week = 'free' WHERE novel_num=17;
                
                delete from novel_tbl;
                
            -- 2. auth_tbl���� ��� ����
            SELECT * FROM auth_tbl;
                -- ���� ���·� ����
                UPDATE auth_tbl SET auth='ROLE_FREE_WRITER' WHERE user_id='freeWriter0';
                
            -- 3. free_tbl���� �����ߴ� ������ ����
            SELECT * FROM free_tbl;
                -- ���� ���·� ����
                INSERT INTO free_tbl(
                    SELECT * 
                        FROM free_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '10' MINUTE) WHERE novel_num=17
                );
                
                DELETE FROM free_tbl;
                
                  SELECT * 
                        FROM free_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '10' MINUTE) WHERE novel_num=17;
                
                
            -- 4. ��ʸ�Ʈ ��ȸ �Ⱓ ������Ʈ (8��, 4��, 2��, �غ�Ⱓ)
            SELECT * FROM tourna_tbl;
                -- ���� ���·� ����
                    -- 8�� �ǵ�����
                    UPDATE tourna_tbl SET to_sdate = '22/05/15', to_edate='22/05/22' WHERE to_num=1;
                    
                    -- 4�� �ǵ�����
                    UPDATE tourna_tbl SET to_sdate = '22/05/22', to_edate='22/05/29' WHERE to_num=2; 
                    
                    -- 2�� �ǵ�����
                    UPDATE tourna_tbl SET to_sdate = '22/05/29', to_edate='22/06/05' WHERE to_num=3; 
                    
                    -- �޽ı�
                    UPDATE tourna_tbl SET to_sdate = '22/05/29', to_edate='22/06/12' WHERE to_num=4;
                    
                    -- �޽ı� ����(���� ��ư ������. to_sdate�� ���� ��¥��)
                    UPDATE tourna_tbl SET to_sdate = '22/05/30', to_edate='22/05/28' WHERE to_num=4;
                    
                    commit;
                    
            -- 5. torec_tbl ������ ����
            SELECT * FROM torec_tbl;
                -- ������ ����
                UPDATE towork_tbl SET towork_rec=59 WHERE novel_num=16;
                SELECT * FROM towork_tbl;
                DELETE FROM torec_tbl;
                commit;

            -- 6. towork_tbl ������ ���� (�̰� �������� �ٽ� �����ؾߵ�)
            SELECT * FROM towork_tbl;
                -- ���� ���·� ����
                INSERT INTO towork_tbl(
                    SELECT * 
                        FROM towork_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '20' MINUTE)
                );
                
                  SELECT * 
                        FROM towork_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '20' MINUTE);
            
                DELETE FROM towork_tbl ;
                
                -- towork_tbl�� �� ������ ���� �� ��õ�� �ֱ�
                UPDATE towork_tbl SET towork_rec = 59 WHERE novel_num= 16;
                UPDATE towork_tbl SET towork_rec = 60 WHERE novel_num= 17;
                UPDATE towork_tbl SET towork_rec = 40 WHERE novel_num= 18 or novel_num =21 or novel_num=25;
                UPDATE towork_tbl SET towork_rec = 20 WHERE novel_num= 28 or novel_num =30 or novel_num=31;
            
            commit;
            
        
            
            
        -- total ��õ������ Ȯ���ϱ�
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
        
        
        
        
        
        -- �ʱ�ȭ ��ư ��Ȱ��ȭ �ϱ�
        SELECT * FROM tourna_tbl;
            -- ��Ȱ��ȭ �ϴ� ����(���÷� ����)
            UPDATE tourna_tbl SET to_sdate = '22/05/19' WHERE to_num=4;
            -- �ǵ�����
            UPDATE tourna_tbl SET to_sdate = '22/05/21' WHERE to_num=4;
            
            commit;
        
        
        
        
                
      
                    
        
    
        