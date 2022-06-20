-- 05.26 ���� ������ ��ȸ��, ��ȣ�� �� ����Ʈ �Ѹ���

    -- �ʿ��� �� : ��� ��ȣ, �Ҽ� �̸�, �� ��ȸ��, �� ��ȣ��
    
    
    select * from novel_tbl;
    commit;
    
    -- �� ��ȸ��(����)
    select * from free_tbl;
    
        -- 1. free_tbl���� �̾ƿ� ��� ��ȣ�� �� ��ȸ��
        SELECT 
            novel_num, total_view 
        FROM 
            (SELECT novel_num, sum(free_hit) as total_view  FROM free_tbl Group By novel_num order by total_view DESC)
        WHERE
            rownum <= 5;
            
        -- 2. 1�� novel_tbl�� left join ��
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
            
            
            
     -- �� ��õ��(����)
        -- 1. free_tbl���� �̾ƿ� ��� ��ȣ�� �� ��õ��
            SELECT
                novel_num, total_rec
            FROM 
                (SELECT novel_num, sum(free_rec) as total_rec  FROM free_tbl Group By novel_num order by total_rec DESC)
            WHERE
                rownum <= 5;
                
         -- 2. 1�� novel_tbl�� left join ��
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
                
                
        
        -- ���� ��ȸ�� ����Ʈ
        
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
            
            
            
        -- ���� ��õ�� ����Ʈ
        
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
         
         
         