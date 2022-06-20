/* �� ���� ����� ���ǻ���
 1. auto ���� -> ���̺� ���� -> nocache ����
  (auto���� �����ؾ� auto��ȣ�� 1���� ���۵�.)
 2. �Ϻ� ���̺� drop�� �ܷ�Ű ���� ���̺���� ������ (��ü ������ ���� : ���� ���� ����)
 3. ���̺� drop�� �ص� auto�� �������,
   �׷��Ƿ� drop sequence 'auto�����Ȱ�'; �� �������. (�ؿ� ���� �������)
*/

-- commit ������ �����ؾ� ��μ� �����Ͱ� ������
commit;

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
SELECT * FROM user_tbl;

-- INSERT ��
INSERT INTO user_tbl (user_num,user_id,user_pw,user_name,user_pnum,user_email) values 
                  (user_num.nextval,'test3','1234','�����','01012345678','test@naver.com');


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

-- ������ �ذ�
alter sequence novel_num nocache; 

-- INSERT ��
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'��ȫ��','��ɿ�', 45, '�߸�', 'free');
                        
                        
-- DELETE ��
DELETE FROM novel_tbl WHERE novel_num = 2;

-- ��ȸ
SELECT * FROM novel_tbl;

-- ������������������������������������� �� ���������������������������������������

-- ������Ҽ���
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
    
-- ������ �ذ�
alter sequence paid_num nocache;
alter sequence paid_snum nocache;

-- �ܷ�Ű   
alter table paid_tbl add constraint fk_paid 
  foreign key (novel_num) references novel_tbl(novel_num);

-- INSERT ��
INSERT INTO paid_tbl (paid_num, novel_num, paid_snum, paid_title, paid_content) values
                        (paid_num.nextval, '2', 10,'�����ǼҼ�1��','�����̴� �Ҽ��� ���� ����');
                        
-- ��ȸ
SELECT * FROM paid_tbl;


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
    
-- ������ �ذ�
alter sequence free_num nocache;
alter sequence free_snum nocache;

-- �ܷ�Ű   
alter table free_tbl add constraint fk_free 
  foreign key (novel_num) references novel_tbl(novel_num);

-- INSERT ��
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '3', 5,'�����ǼҼ�1��','�����̴� �Ҽ��� ���� ����'); 
                        
-- ��ȸ
SELECT * FROM free_tbl;
         
                        
-- �� ���� �Ҽ� ���

CREATE SEQUENCE prepl_num;

CREATE TABLE paid_repl_tbl(
  prepl_num number(10,0) PRIMARY KEY,
  novel_num number(10,0) not null,-- novel_tbl novel_num�� fk
  prepl_fnum number(10,0) not null, -- paid_tbl paid_num�� fk
  prepl_content varchar2(1000) not null,
  prepl_writer varchar2(50) not null,  -- user_tbl user_id�� fk
  prepl_rdate date default sysdate,
  prepl_mdate date
);

-- ������ �ذ�
alter sequence prepl_num nocache;

-- �ܷ�Ű ����

  
alter table paid_repl_tbl add constraint fk_pnovel_num
  foreign key (novel_num) references novel_tbl(novel_num);

alter table paid_repl_tbl add constraint fk_preplyer
  foreign key (prepl_writer) references user_tbl(user_id);  

alter table paid_repl_tbl add constraint fk_repl_pnum
  foreign key (prepl_fnum) references paid_tbl(paid_num);    

-- �� ���� �Ҽ� ���
CREATE SEQUENCE frepl_num;

CREATE TABLE free_repl_tbl(
  frepl_num number(10,0) PRIMARY KEY,
  novel_num number(10,0) not null,-- novel_tbl novel_num�� fk
  frepl_fnum number(10,0) not null, -- free_tbl free_num�� fk
  frepl_content varchar2(1000) not null,
  frepl_writer varchar2(50) not null,  -- user_tbl user_id�� fk
  frepl_rdate date default sysdate,
  frepl_mdate date
);

-- ������ �ذ�
alter sequence frepl_num nocache;

-- �ܷ�Ű ����

  
alter table free_repl_tbl add constraint fk_novel_num
  foreign key (novel_num) references novel_tbl(novel_num);

alter table free_repl_tbl add constraint fk_replyer
  foreign key (frepl_writer) references user_tbl(user_id);  

alter table free_repl_tbl add constraint fk_repl_fnum
  foreign key (frepl_fnum) references free_tbl(free_num);

-- ������������������������������������� �� ���������������������������������������

  
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
                        (to_num.nextval,'���Ҽ� �ְ��� �����');
-- 2)
UPDATE tourna_tbl 
    SET to_edate = to_sdate + (INTERVAL '7' DAY)
    WHERE to_num='3';

-- ������ ����
DELETE FROM tourna_tbl WHERE to_num =1;

-- ������ ����
UPDATE tourna_tbl
    SET to_sdate = '22/05/13' WHERE to_num=3;

-- ��ȸ
SELECT * FROM tourna_tbl;

SELECT to_sdate + (INTERVAL '1' MONTH) FROM tourna_tbl;


-- ����ʸ�Ʈ(��ǰ)��
-- auto
CREATE SEQUENCE towork_num;

CREATE TABLE towork_tbl(
  towork_num number PRIMARY KEY,        -- ���̺� ��ȣ
  to_num number(10,0),                  -- ��ʸ�Ʈ ��ȣ         fk (tourna_tbl)
  novel_num number(10,0),               -- ��ǰ ��ȣ             fk (novel_tbl)
  towork_rec number(10,0) default 0     -- ��õ��
);

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
    SELECT * FROM towork_tbl ORDER BY towork_rec DESC;   -- 2. 1�� ��������� rownum�� 4�̸���(4��) �͵��� ������
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
    
    
    -- ����
    SELECT * FROM towork_tbl ORDER BY to_num DESC;
    
    DELETE FROM towork_tbl WHERE to_num=2;

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
    


-- ������������������������������������� �� ���������������������������������������


    
-- �ڼ�ȣ�ۡ�
-- auto
CREATE SEQUENCE fav_num;

CREATE TABLE favorite_tbl(
  fav_num number(10,0) PRIMARY KEY,
  novel_num number(10,0), -- fk
  user_num number(10,0) -- fk
);

-- ������ �ذ�
alter sequence fav_num nocache;

-- �ܷ�Ű ����
alter table favorite_tbl add constraint fk_favorite
  foreign key (novel_num) references novel_tbl(novel_num);
  
alter table favorite_tbl add constraint fk_favorite1
  foreign key (user_num) references user_tbl(user_num);
  
-- INSERT ��
INSERT INTO favorite_tbl (fav_num, novel_num, user_num) values
                          (fav_num.nextval,2,1);
-- ��ȸ
SELECT * FROM favorite_tbl;


-- ��å���ǡ�
-- auto
CREATE SEQUENCE bm_num;

CREATE TABLE bookmark_tbl(
  bm_num number(10,0) PRIMARY KEY,
  novel_num number(10,0), -- fk
  bm_novel_num number(10,0),
  user_num number(10,0) -- fk
);

-- ������ �ذ�
alter sequence bm_num nocache;

-- �ܷ�Ű ����
alter table bookmark_tbl add constraint fk_bookmark
  foreign key (novel_num) references novel_tbl(novel_num);
  
alter table bookmark_tbl add constraint fk_bookmark1
  foreign key (user_num) references user_tbl(user_num);
  
-- INSERT ��
INSERT INTO bookmark_tbl (bm_num, novel_num, bm_novel_num, user_num) values
            (bm_num.nextval, 2, 3, 1);
            
-- ��ȸ
SELECT * FROM bookmark_tbl;


-- �ڰ���(����->����)��
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

-- ������ �ذ�
alter sequence charge_num nocache;

-- �ܷ�Ű ����
alter table charge_tbl add constraint fk_charge
  foreign key (user_num) references user_tbl(user_num);
  
-- INSERT ��
INSERT INTO charge_tbl (charge_num, user_num, charge_price) values
                      (charge_num.nextval, 1, 500);          
                      
-- ��ȸ
SELECT * FROM charge_tbl;


-- ��������
-- auto
CREATE SEQUENCE coupon_num;

CREATE TABLE coupon_tbl(
  coupon_num number(10,0) PRIMARY KEY,
  coupon_value varchar2(20) not null
);

-- ������ �ذ�
alter sequence coupon_num nocache;
--INSERT ��
INSERT INTO coupon_tbl (coupon_num,coupon_value) values
                      (coupon_num.nextval,'1000������');
-- ��ȸ
SELECT * FROM coupon_tbl;


-- �ڻ�볻��(����->��ǰ����)��
-- auto
CREATE SEQUENCE use_num;

CREATE TABLE use_tbl(
  use_num number(10,0) PRIMARY KEY,
  user_num number(10,0), -- fk
  use_type varchar2(10) not null,
  use_count number(10) not null,
  use_date date default sysdate
);

-- ������ �ذ�
alter sequence use_num nocache;

-- �ܷ�Ű ����
alter table use_tbl add constraint fk_use
  foreign key (user_num) references user_tbl(user_num);
  
-- INSERT 
INSERT INTO use_tbl (use_num, user_num, use_type, use_count) values
                    (use_num.nextval, 1, '����', '100');       
                    
-- ��ȸ
SELECT * FROM use_tbl;


-------------------------------------------------

-- �����̺� ������(�������� ����)�� 15
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


-- �ؽ�����(auto)������ 17
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