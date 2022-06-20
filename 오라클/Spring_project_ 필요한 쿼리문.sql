-- �� �ʿ��� �������� ������ ���� 

        -- ����
            -- ��������
            -- �ڼҼ�(����)��
            -- ����ʸ�Ʈ(��ȸ)��
            -- ����ʸ�Ʈ(��ǰ)��
            -- ����ʸ�Ʈ(��ȸ/��ǰ ���� ��õ ���)��
        



-- ��������
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

-- ������ �ذ�
alter sequence user_num nocache; 

-- ��ȸ
SELECT * FROM user_tbl ORDER BY user_num DESC;

DELETE FROM user_tbl WHERE user_id like 'user%';

-- INSERT ��                    -���̵�  - ���   - �̸�     -����ȣ    -�̸���
INSERT INTO user_tbl (user_num, user_id, user_pw, user_name, user_pnum, user_email) values 
                  (user_num.nextval,'id012','pw012','�����','01012345678','test012@naver.com');
                  
commit;

-- ��й�ȣ ��ȣȭ�� ���� ��й�ȣ�� �ڸ����� �ø�
ALTER TABLE user_tbl MODIFY user_pw varchar2(100);
ALTER TABLE user_tbl MODIFY user_name varchar2(30);
commit;

-- ������������������������������������� �� ��������������������������������������


-- ��ȸ����ޡ�   
-- auto
CREATE SEQUENCE auth_num;

CREATE TABLE auth_tbl(
auth_num number(10,0) PRIMARY key,
user_id varchar2(20),-- fk
auth varchar2(20) not null
);

-- ������ �ذ�
alter sequence auth_num nocache; 

-- �ܷ�Ű ����
alter table auth_tbl add constraint fk_auth foreign key (user_id) references user_tbl(user_id);

-- INSERT ��
INSERT INTO auth_tbl (auth_num,user_id,auth) values 
                       (auth_num.nextval,'test3','���');         
-- ��ȸ
select*from auth_tbl;                  

-- ������������������������������������� �� ���������������������������������������
              
                  
-- �ڼҼ�(����)��
-- auto
CREATE SEQUENCE novel_num;

CREATE TABLE novel_tbl(
    novel_num number(10,0) PRIMARY KEY,
    novel_writer varchar2(50) not null,
    novel_title varchar2(200) not null,
    novel_tsnum number(10,0) default 0,         -- �� �������
    novel_category varchar2(10) not null,
    novel_week varchar2(10) not null,
    novel_end char(1) default '0'
);

-- �� �������) �Ҽ� ���̺� user_id �߰��ϰ� �ܷ�Ű �����ؾ���.
    ALTER TABLE novel_tbl ADD user_id varchar2(20);
    ALTER TABLE novel_tbl ADD CONSTRAINT fk_novel FOREIGN KEY (user_id) REFERENCES user_tbl(user_id);

    -- �߰��� user_id�� ���̵� ä���� ( ���� : user10~user19 )
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
    
    -- ���̵� �߰��ϰ� not null�� �Ӽ� �����ϱ�
        ALTER TABLE novel_tbl MODIFY user_id varchar2(20) NOT NULL;

    SELECT * FROM novel_tbl;
    
    commit;
    
-- ������ �ذ�
alter sequence novel_num nocache; 

-- INSERT ��
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week, user_id) values
                        (novel_num.nextval,'�۰�','�Ҽ�����', 100, 'wuxia', 'Mon', 'user10');
                        
                        
-- DELETE ��
DELETE FROM novel_tbl WHERE novel_num = 2;

-- ��ȸ
SELECT * FROM novel_mtbl;


-- ������������������������������������� �� ���������������������������������������


-- �ڹ���Ҽ���
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
 
-- ������ �ذ�
alter sequence free_num nocache;
alter sequence free_snum nocache;

-- �ܷ�Ű   
alter table free_tbl add constraint fk_free 
  foreign key (novel_num) references novel_tbl(novel_num);
  
commit;
-- INSERT ��
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '19', 1,'���-��1��-1ȭ','����'); -- free_title 20���ڰ� �ƴ�..?
                        
-- ��ȸ
SELECT * FROM free_tbl;
drop table free_tbl;


SELECT free_rec FROM free_tbl;


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

--INSERT ����
-- 1)
INSERT INTO tourna_tbl (to_num, to_name) values 
                        (to_num.nextval,'���� ��ȸ �غ�Ⱓ');
                        
-- 2)
UPDATE tourna_tbl 
    SET to_edate = to_sdate + (INTERVAL '7' DAY)
    WHERE to_num='4';

-- ������ ����
DELETE FROM tourna_tbl WHERE to_num =1;

-- ������ ����
UPDATE tourna_tbl
    SET to_sdate = '22/05/13' WHERE to_num=3;  
    
    -- 8�� ������ ���̰�
    UPDATE tourna_tbl SET to_sdate ='22/04/28', to_edate = '22/05/29' WHERE to_num=1; 
    -- 8�� �ǵ�����
    UPDATE tourna_tbl SET to_sdate = '22/04/27', to_edate='22/05/04' WHERE to_num=1; 
    
    -- 4�� ������ ���̰�
    UPDATE tourna_tbl SET to_edate = '22/05/29' WHERE to_num=2; 
    -- 4�� �ǵ�����
    UPDATE tourna_tbl SET to_sdate = '22/05/05', to_edate='22/05/12' WHERE to_num=2; 
     
    -- 2�� ������ �� ���̰�
    UPDATE tourna_tbl SET to_sdate = '22/05/29' WHERE to_num=3; 
    -- 2�� �ǵ�����
    UPDATE tourna_tbl SET to_sdate = '22/05/13', to_edate='22/05/20' WHERE to_num=3; 

    -- �޽ı�
    UPDATE tourna_tbl SET to_sdate = '22/05/21', to_edate='22/05/28' WHERE to_num=4;
commit;

-- ��ȸ
SELECT * FROM tourna_tbl;

SELECT to_sdate + (INTERVAL '1' MONTH) FROM tourna_tbl;





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

commit;


UPDATE towork_tbl SET towork_rec=85 WHERE towork_num=597;
UPDATE towork_tbl SET towork_rec=86 WHERE towork_num=596;

SELECT * FROM towork_tbl ORDER BY towork_num DESC;

-- ������ �ذ�
alter sequence towork_num nocache;

-- �ܷ�Ű ����
alter table towork_tbl add constraint fk_towork
  foreign key (to_num) references tourna_tbl(to_num);
 
 alter table towork_tbl add constraint fk_towork1
  foreign key (novel_num) references novel_tbl(novel_num);
  
-- INSERT ��                        -��ȸ��ȣ -��ǰ��ȣ
INSERT INTO towork_tbl (towork_num, to_num, novel_num) values
                        (towork_num.nextval,1,16);

DELETE FROM towork_tbl WHERE towork_num=5;
                
-- ��ȸ
SELECT * FROM towork_tbl;
SELECT * FROM towork_tbl tt INNER JOIN novel_tbl nt ON tt.novel_num = nt.novel_num;



-- Ư�� �÷��� ��������
SELECT tt.QCSJ_C000000000400000 as to_num, tt.to_name, tt.towork_num, nt.novel_title, nt.novel_writer, tt.towork_rec
    FROM 
        (SELECT * FROM tourna_tbl INNER JOIN towork_tbl ON tourna_tbl.to_num = towork_tbl.to_num) tt
        INNER JOIN 
        novel_tbl nt 
    ON tt.novel_num = nt.novel_num; -- WHERE tt.QCSJ_C000000000400000=2;

-- �� ��������
SELECT *
FROM 
    (SELECT * FROM tourna_tbl INNER JOIN towork_tbl ON tourna_tbl.to_num = towork_tbl.to_num) tt
    INNER JOIN 
    novel_tbl nt 
ON tt.novel_num = nt.novel_num ;

SELECT * FROM tourna_tbl INNER JOIN towork_tbl ON tourna_tbl.to_num = towork_tbl.to_num;
SELECT * FROM tourna_tbl INNER JOIN towork_tbl ON tourna_tbl.to_num = towork_tbl.to_num;
SELECT * FROM novel_tbl;


-- 8���� �� ��ǰ�� 4���� �������� ��õ���� ������ �����ϱ� (to_num�� 1, 2�� �ٸ�)

    -- 1. ��ȸ��ȣ(to_num)�� 1(8��)�̰�, ��ǰ��ȣ(novel_num)�� 1�� ��ǰ�� ��õ�� ���ϱ�
    SELECT towork_rec FROM towork_tbl WHERE to_num =1 AND novel_num=1;
    -- 2. ��ǰ ��ȣ�� �Է� �޾�, ��ȸ��ȣ(to_num)�� 2(4��)�϶�, 1���� ���� ��õ���� ������Ʈ ����
    UPDATE towork_tbl SET towork_rec = (SELECT towork_rec FROM towork_tbl WHERE to_num =1 AND novel_num=1) WHERE to_num=2 AND novel_num=1;

 
-- �������� �ƴϸ� �ƿ� 2, 4 ���� ��Ȱ��ȭ �� ����, ��ư�� ������ ���� 2, 4���� �� ��� �ش� ���̺� ����Ǵ� ������..?
    -- 1. ��õ�� ���� ��������
    SELECT * FROM towork_tbl ORDER BY towork_rec DESC;   
    -- 2. 1�� ��������� rownum�� 4�̸���(4��) �͵��� ������
    SELECT * FROM (SELECT * FROM towork_tbl ORDER BY towork_rec DESC) WHERE rownum <= 4;
    -- 3. 2�� ����� ���̺� ���� ����(��¿�� ���� towork_num�� ���� ����)
        -- 3.1 to_num���� 2(4��), 3(2��)�� ����
        -- 3.2 ���� WHERE�� to_num-1�� ������ ��, 2(4��)�� ��� 2-1(8��)������, 3(2��)�� ��� 3-1(4��)������
        -- 3.3 �ٱ��� WHERE�������� to_num�� 2(4��)�� ��� rownum�� 4 ����, 3(2��)�� ��� 2 ���Ϸ� ��.
    INSERT INTO towork_tbl(towork_num, to_num, novel_num, towork_rec)
        SELECT 
    towork_num.nextval, 3, novel_num, towork_rec
        FROM 
    (SELECT * FROM (SELECT * FROM towork_tbl WHERE to_num = 3 - 1 ORDER BY towork_rec DESC) WHERE rownum <= 2);
    
    
   
    commit;
    
     -- ����
    SELECT * FROM towork_tbl ORDER BY to_num DESC;                              -- ������ ��ȸ : ��ȸ ��ǰ ���̺�
    SELECT * FROM torec_tbl ORDER BY torec_num DESC;                            -- ������ ��ȸ : ��ǰ ��õ ��� ���̺�
    
    
    DELETE FROM towork_tbl WHERE to_num=2;
    DELETE FROM towork_tbl WHERE to_num=3;                                      -- ������ ���� : ��ȸ ��ǰ ���̺�
    
    DELETE FROM torec_tbl WHERE user_id = 'id012';                              -- ������ ���� : ��ǰ ��õ ��� ���̺�
    DELETE FROM torec_tbl WHERE to_num=1;
    DELETE FROM torec_tbl WHERE to_num=2;
    DELETE FROM torec_tbl WHERE to_num=3;

    -- !!!!!!!!!!!!!!!!!!!!!! Ŀ���� ��Ȱȭ ���� !!!!!!!!!!!!!!!!!!!!
    commit;
    
    
    -- ���� ��� ��ǰ ��������
        -- 1.
        SELECT tt.to_num, tt.towork_num, nt.novel_title, nt.novel_writer, tt.towork_rec FROM towork_tbl tt INNER JOIN novel_tbl nt ON tt.novel_num = nt.novel_num;
        -- 2.
        SELECT * 
            FROM 
        (SELECT tt.to_num, tt.towork_num, nt.novel_title, nt.novel_writer, tt.towork_rec FROM towork_tbl tt INNER JOIN novel_tbl nt ON tt.novel_num = nt.novel_num ORDER BY towork_rec DESC) 
            WHERE 
        rownum <= 1;
       
        
    -- 2��, 4���� ���� ��ǰ�� ��������
        SELECT * FROM (SELECT tt.to_num, tt.towork_num, nt.novel_title, nt.novel_writer, tt.towork_rec FROM towork_tbl tt INNER JOIN novel_tbl nt ON tt.novel_num = nt.novel_num) WHERE to_num=2;
 
 
 
    -- �����ϱ� ��ư ������ ������ ������� �ʵ����ϱ�
        -- 1. �ش� ��ȸ�� ����� �ִٸ� ���� �ʵ���
        SELECT * FROM towork_tbl WHERE to_num=2;
 

 
 
 
 
 
 
 
 
 
 
 
 
-- ������������������������������������� �� ��������������������������������������� 

-- ����ʸ�Ʈ(��ȸ/��ǰ ���� ��õ ���)��

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
    
    drop table torec_tbl;
    
    -- ���̺� ��ȸ
    SELECT * FROM torec_tbl ORDER BY torec_num DESC;
    
    -- ������ ����
    DELETE FROM torec_tbl WHERE user_id = 'id012';
    DELETE FROM torec_tbl WHERE to_num =1;
    
    commit;
    
    -- ��õ ��� ����ϰ� ����
         -- 1. ������ǰ-��õ����� inner join ��
         SELECT tt.*, twt.novel_num, twt.towork_rec FROM torec_tbl tt INNER JOIN towork_tbl twt ON tt.towork_num = twt.towork_num;
         -- 2. 1�� ����� ��� ���̺�� inner join ��
             -- ��ʸ�Ʈ��ȣ  -��õ��ȣ   - ��ȸ������ȣ -��õ���̵�  - �Ҽ���ȣ   - �Ҽ� ����      - ��õ��
         SELECT jt.to_num, jt.torec_num, jt.towork_num, jt.user_id, jt.novel_num, nt.novel_title, jt.towork_rec as ��õ��, jt.rec_date 
            FROM 
        (SELECT tt.*, twt.novel_num, twt.towork_rec FROM torec_tbl tt INNER JOIN towork_tbl twt ON tt.towork_num = twt.towork_num) jt
            INNER JOIN 
        novel_tbl nt 
            ON
        nt.novel_num = jt.novel_num
            ORDER BY
        jt.torec_num DESC;
    
    -- ���� �õ�                           -��ʸ�Ʈ ��ȣ -��ʸ�Ʈ��ǰ��ȣ
    INSERT INTO torec_tbl (torec_num, user_id, to_num, towork_num) 
        VALUES (torec_num.nextval, 'id001', 1, 252);
        
    INSERT INTO torec_tbl (torec_num, user_id, to_num, towork_num) 
        VALUES (torec_num.nextval, 'id002', 1, 257);
    
     commit;
     
     
     -- �α����� ������ �ش� ��ʸ�Ʈ�� ��õ ����� �ִ��� Ȯ��
        -- ���ϵ� to_num�� 1�� �ִٸ� 8�� ��ư ��Ȱ��ȭ
        -- ���ϵ� to_num�� 2�� �ִٸ� 4�� ��ư ��Ȱ��ȭ
        -- ���ϵ� to_num�� 3�� �ִٸ� 2�� ��ư ��Ȱ��ȭ
     SELECT towork_num, user_id FROM torec_tbl WHERE user_id = 'id001' AND to_num=1;
     
    SELECT towork_num, user_id FROM torec_tbl WHERE user_id = 'id001' AND to_num= 1;
    
    SELECT towork_num, user_id FROM torec_tbl WHERE to_num=1 AND user_id = 'id002';
    
    
 
 
 
 select * from tourna_tbl;
 select * from towork_tbl;
 select * from torec_tbl;
        
        
        
        
        
        
        
    
    
