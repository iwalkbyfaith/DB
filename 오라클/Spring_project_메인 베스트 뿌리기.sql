-- 05.26 메인 페이지 조회수, 선호작 별 베스트 뿌리기

    -- 필요한 것 : 노블 번호, 소설 이름, 총 조회수, 총 선호작
    
    
    select * from novel_tbl;
    commit;
    
    -- 총 조회수(무료)
    select * from free_tbl;
    
        -- 1. free_tbl에서 뽑아온 노블 번호와 총 조회수
        SELECT 
            novel_num, total_view 
        FROM 
            (SELECT novel_num, sum(free_hit) as total_view  FROM free_tbl Group By novel_num order by total_view DESC)
        WHERE
            rownum <= 5;
            
        -- 2. 1을 novel_tbl과 left join 함
        SELECT
            nt.novel_num, nt.novel_title, ft.total_view
        FROM
                (SELECT 
                novel_num, total_view 
            FROM 
                (SELECT novel_num, sum(free_hit) as total_view  FROM free_tbl Group By novel_num order by total_view DESC)
            WHERE
                rownum <= 5) ft
        LEFT JOIN 
            novel_tbl nt
        ON 
            ft.novel_num = nt.novel_num;
            
            
            
     -- 총 추천수(무료)
        -- 1. free_tbl에서 뽑아온 노블 번호와 총 추천수
            SELECT
                novel_num, total_rec
            FROM 
                (SELECT novel_num, sum(free_rec) as total_rec  FROM free_tbl Group By novel_num order by total_rec DESC)
            WHERE
                rownum <= 5;
                
         -- 2. 1을 novel_tbl과 left join 함
             SELECT
                nt.novel_num, nt.novel_title, ft.total_rec
            FROM
                (SELECT 
                     novel_num, total_rec
                FROM 
                    (SELECT novel_num, sum(free_rec) as total_rec  FROM free_tbl Group By novel_num order by total_rec DESC)
                WHERE
                    rownum <= 5) ft
            LEFT JOIN 
                novel_tbl nt
            ON 
                ft.novel_num = nt.novel_num;
                
                
        
        -- 유료 조회수 베스트
        
        SELECT
            nt.novel_num, nt.novel_title, ft.total_view
        FROM
            (SELECT 
                novel_num, total_view 
            FROM 
                (SELECT novel_num, sum(paid_hit) as total_view  FROM paid_tbl Group By novel_num order by total_view DESC)
            WHERE
                rownum <= 5) ft
        LEFT JOIN 
            novel_tbl nt
        ON 
            ft.novel_num = nt.novel_num;
            
            
            
        -- 유료 추천수 베스트
        
        SELECT
            nt.novel_num, nt.novel_title, ft.total_rec
        FROM
            (SELECT 
                novel_num, total_rec
            FROM 
                (SELECT novel_num, sum(paid_rec) as total_rec  FROM paid_tbl Group By novel_num order by total_rec DESC)
             WHERE
                    rownum <= 5) ft
        LEFT JOIN 
            novel_tbl nt
        ON 
            ft.novel_num = nt.novel_num;

        commit; 
         
         
         