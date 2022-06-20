-- ��ʸ�Ʈ ���̺� ���� ��� ����

-- ������������������������������������� �� ���������������������������������������

DROP SEQUENCE to_num;
DROP SEQUENCE towork_num;
DROP SEQUENCE torec_num;

DROP TABLE tourna_tbl;
DROP TABLE towork_tbl;
DROP TABLE torec_tbl;

 
 
-- ����ʸ�Ʈ(��ȸ)��
-- auto
CREATE SEQUENCE to_num;

CREATE TABLE tourna_tbl(
  to_num number(10,0) PRIMARY KEY,     -- ��ȸ ��ȣ
  to_name varchar2(50) not null,       -- ��ȸ �̸�
  to_sdate date default sysdate,       -- ���� ��¥
  to_edate date                        -- ���� ��¥
);

-- ������ �ذ�
alter sequence to_num nocache;


-- �⺻ ������ ����

    -- 1) 8��
    INSERT INTO tourna_tbl (to_num, to_name) values (to_num.nextval,'���Ҽ� �ְ��� 8����');
    UPDATE tourna_tbl SET to_sdate = '22/05/15' WHERE to_num='1'; 
    UPDATE tourna_tbl SET to_edate = to_sdate + (INTERVAL '7' DAY) WHERE to_num='1';
    
    -- 2) 4��   
    INSERT INTO tourna_tbl (to_num, to_name) values (to_num.nextval,'���Ҽ� �ְ��� 4����');
    UPDATE tourna_tbl SET to_sdate = '22/05/22' WHERE to_num='2'; 
    UPDATE tourna_tbl SET to_edate = to_sdate + (INTERVAL '7' DAY) WHERE to_num='2';
    
    -- 3) 2��   
    INSERT INTO tourna_tbl (to_num, to_name) values (to_num.nextval,'���Ҽ� �ְ��� 2����');
    UPDATE tourna_tbl SET to_sdate = '22/05/29' WHERE to_num='3'; 
    UPDATE tourna_tbl SET to_edate = to_sdate + (INTERVAL '7' DAY) WHERE to_num='3';
    
    -- 4) ���� ��ȸ �غ� �Ⱓ
    INSERT INTO tourna_tbl (to_num, to_name) values (to_num.nextval,'���� ��ȸ �غ� �Ⱓ');
    UPDATE tourna_tbl SET to_sdate = '22/06/05' WHERE to_num='4'; 
    UPDATE tourna_tbl SET to_edate = to_sdate + (INTERVAL '7' DAY) WHERE to_num='4';
    
    select * from tourna_tbl;

commit;

    -- ��ȸ ���� ����
    UPDATE tourna_tbl SET to_sdate = '22/05/29' WHERE to_num='4';  
        -- �ǵ�����
        UPDATE tourna_tbl SET to_sdate = '22/06/05' WHERE to_num='4';  

-- ������������������������������������� �� ���������������������������������������

-- ����ʸ�Ʈ(��ǰ)��
-- auto
CREATE SEQUENCE towork_num;

CREATE TABLE towork_tbl(
  towork_num number PRIMARY KEY,        -- ���̺� ��ȣ
  to_num number(10,0),                  -- ��ʸ�Ʈ ��ȣ         fk (tourna_tbl)
  novel_num number(10,0),               -- ��ǰ ��ȣ             fk (novel_tbl)
  towork_rec number(10,0) default 0 
);


-- ������ �ذ�
alter sequence towork_num nocache;

-- �ܷ�Ű ����
alter table towork_tbl add constraint fk_towork
  foreign key (to_num) references tourna_tbl(to_num);
 
 alter table towork_tbl add constraint fk_towork1
  foreign key (novel_num) references novel_tbl(novel_num);
  
  
select * from towork_tbl;  


-- ��õ�� �ֱ� 
    
    -- ���� : �Ҽ�����(�Ҽ���ȣ) ����ȸ��
    -- �ǵ� : �̼�(17) 8267 > ������(16) 4891 
    --                      > ȭ��(21) 3535 > ������(25) 3890  
    --                                      > ����(18) 3483 > �޸������(28) 1419 > ����(30) 510 > �ȷ�(31) 217
    
        -- 8����) ��õ�� : ������ = ���븶�� / ��ȸ�� : ������ > ���븶��
        -- 4����) �̼� > ������ = ȭ���ȯ
        -- 2����) �̼� > ������

    -- ��õ�� �ϴ� �⺻ ����
    
        UPDATE towork_tbl SET towork_rec = 1190 WHERE novel_num = 17;                   -- �̼��� ����
        UPDATE towork_tbl SET towork_rec = 1190 WHERE novel_num = 16;                   -- ������
        
        UPDATE towork_tbl SET towork_rec = 994 WHERE novel_num = 21;                    -- ȭ���ȯ
        UPDATE towork_tbl SET towork_rec = 839 WHERE novel_num = 25;                    -- ������ ���ƿԴ�.
        
        UPDATE towork_tbl SET towork_rec = 839 WHERE novel_num = 18;                    -- ���븶��
        UPDATE towork_tbl SET towork_rec = 401 WHERE novel_num = 28;                    -- �޸������
        UPDATE towork_tbl SET towork_rec = 331 WHERE novel_num = 30;                    -- ����������
        UPDATE towork_tbl SET towork_rec = 228 WHERE novel_num = 31;                    -- �ȷ�
    
        -- ---------------------------------------------------------------------
    
        UPDATE towork_tbl SET towork_rec = 1490 WHERE novel_num = 16 AND to_num =1;     -- ������(8�� ����)
    
        -- ---------------------------------------------------------------------
        
         UPDATE towork_tbl SET towork_rec = 1970 WHERE novel_num = 16 AND to_num =2;    -- ������(4�� ����)
         UPDATE towork_tbl SET towork_rec = 2890 WHERE novel_num = 17 AND to_num =2;    -- �̼��� ����(4�� ����)
         UPDATE towork_tbl SET towork_rec = 1970 WHERE novel_num = 21 AND to_num =2;     -- ȭ���ȯ(4�� ����)
         
        -- ---------------------------------------------------------------------
        
         UPDATE towork_tbl SET towork_rec = 4389 WHERE novel_num = 17 AND to_num =3;    -- �̼��� ����(2�� ����) : ���ٰ� �̰ܾ���
         UPDATE towork_tbl SET towork_rec = 4390 WHERE novel_num = 16 AND to_num =3;    -- ������(2�� ����)
    
    
    SELECT * FROM towork_tbl;
    commit;
    
    delete from towork_tbl;

    







  
  
-- ������������������������������������� �� ���������������������������������������
  
  
  
-- ����ʸ�Ʈ(��ȸ/��ǰ ���� ��õ ���)�� �� ��

    -- ��ȣ, ���� ���̵�(���� ��ȣ�� pk�̱� �ѵ� ���̵� ����ũ�ϱ�), ��ʸ�Ʈ ��ȣ, ��ǰ ��ȣ, ��õ ��¥ 
    
    -- auto
    CREATE SEQUENCE torec_num;
    
    CREATE TABLE torec_tbl(
        torec_num number PRIMARY KEY,       -- ��ȣ
        user_id varchar2(20),               -- ���� ���̵�        fk(user_tbl)
        to_num number(10,0),                -- ��ʸ�Ʈ ��ȣ      fk(tourna_tbl)
        towork_num number,                  -- ��ʸ�Ʈ ��ǰ ��ȣ fk(towork_tbl)
        rec_date date default sysdate       -- ��õ��
    );
    
    -- �� �÷� �߰�
    ALTER TABLE torec_tbl ADD novel_num number(10,0) DEFAULT 0 NOT NULL;
    alter table torec_tbl add constraint fk_torec4
        foreign key (novel_num) references novel_tbl(novel_num);
    
    -- ������ �ذ�
    alter sequence torec_num nocache;
    
    -- �ܷ�Ű ����
    alter table torec_tbl add constraint fk_torec1
        foreign key (user_id) references user_tbl(user_id);
        
    alter table torec_tbl add constraint fk_torec2
        foreign key (to_num) references tourna_tbl(to_num);
        
    alter table torec_tbl add constraint fk_torec3
        foreign key (towork_num) references towork_tbl(towork_num);
        
    delete from torec_tbl;
    
    commit;




    
    
    
           -- ����ó�� �� �Ǿ��� Ȯ�� (���� 1�� novel_num=17, user_id=freeWriter0)
       
            -- 1. novel_tbl���� week
            SELECT * FROM novel_tbl;
                -- ���� ���·� ����
                UPDATE novel_tbl SET novel_week = 'free' WHERE novel_num=17;
                
                commit;
                delete from novel_tbl;
                
            -- 2. auth_tbl���� ��� ����
            SELECT * FROM auth_tbl order by auth_num;
                -- ���� ���·� ����
                UPDATE auth_tbl SET auth='ROLE_FREE_WRITER' WHERE user_id='freeWriter0';
                
            -- 3. free_tbl���� �����ߴ� ������ ����
            SELECT * FROM free_tbl order by novel_num;
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
                    UPDATE tourna_tbl SET to_sdate = '22/06/05', to_edate='22/06/12' WHERE to_num=4;
                    
                    -- �޽ı� ����(���� ��ư ������. to_sdate�� ���� ��¥��)
                    UPDATE tourna_tbl SET to_sdate = '22/05/31', to_edate='22/06/12' WHERE to_num=4;
                    
                    commit;
                    
            -- 5. torec_tbl ������ ����
            SELECT * FROM torec_tbl;
                -- ������ ����
                UPDATE towork_tbl SET towork_rec=59 WHERE novel_num=16;
                SELECT * FROM towork_tbl;
                
                -- ������ �ǵ�����
                INSERT INTO torec_tbl(
                    SELECT * 
                            FROM torec_tbl AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '10' MINUTE)
                );
                
                DELETE FROM torec_tbl;
                commit;
                

            -- 6. towork_tbl ������ ���� (�̰� �������� �ٽ� �����ؾߵ�)
            SELECT * FROM towork_tbl;
            
                -- ���� ���·� ����
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

-- ��������������������������������� �� Ȯ�ο� ���������������������������������
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
        SELECT novel_num, sum(free_hit) as totalHit FROM free_tbl group by novel_num
        ) tt3
    ON tt2.novel_num = tt3.novel_num
    ORDER BY to_num DESC, towork_rec DESC, totalHit DESC;
    
    
    select * from torec_tbl;
    update free_tbl set free_hit = 4492 where free_num=3;
    
    commit;