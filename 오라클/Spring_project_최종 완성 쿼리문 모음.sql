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

-- ������ �ذ�
alter sequence user_num nocache; 

-- ��ȸ
SELECT * FROM user_tbl ORDER BY user_num;

-- INSERT ��
INSERT INTO user_tbl (user_num,user_id,user_pw,user_name,user_pnum,user_email) values 
                  (user_num.nextval,'test3','1234','�����','01012345678','test@naver.com');
                  
--delete from user_tbl;                  

commit;

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
select*from auth_tbl ORDER BY auth_num;  


--delete from auth_tbl;

commit;
                           

-- �ڼҼ�(����)��
-- auto
CREATE SEQUENCE novel_num;

CREATE TABLE novel_tbl(
    novel_num number(10,0) PRIMARY KEY,
    user_id varchar2(20) not null,  -- user_tbl���� user_id�� fk
    novel_writer varchar2(50) not null,
    novel_title varchar2(200) not null,
    novel_tsnum number(10,0) default 0,
    novel_category varchar2(10) not null,
    novel_week varchar2(10) not null,
    novel_end char(1) default '0'
);

-- ������ �ذ�
alter sequence novel_num nocache; 

-- INSERT ��
-- �� ���� �Ҽ� ������ ���� 
INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '�', 'paidWriter0', '��ģ �ߵ�', 10, 'romance', 'Mon');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '�鹦', 'paidWriter1', '���� ��Ų ����', 10, 'romance', 'Mon');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '������ ����մϴ�', 'paidWriter2', '������ ����մϴ�', 10, 'romance', 'Mon');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                    (novel_num.nextval,'����','paidWriter0','���̺�����', 5, 'romance', 'Tue'); 

INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                    (novel_num.nextval,'�ڼ���','paidWriter1','����', 5, 'romance', 'Tue');                     

INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                    (novel_num.nextval,'�ھ���','paidWriter2','�ı����� �����', 5, 'romance', 'Tue');                     
                    
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'�þƴ�','paidWriter1','�� ���� ����',10, 'romance', 'Wed');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'����Ÿ��Ʈ','paidWriter2','�Ϸ��� ���ڵ�',10, 'romance', 'Wed');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'������','paidWriter0','���� �¼�',10, 'romance', 'Wed');  -- �� �÷��ֽ� ���� ������ ���� ������

INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'����ȭ','paidWriter1','����� ��ȥ�ϰڽ��ϴ�',10, 'fantasy', 'Thu');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'������ȫ��', 'paidWriter2', '�Ŷ��� �ٲ� ���� ��ȥ',10, 'fantasy', 'Thu');

INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'�����','paidWriter0','��������� ó��',10, 'fantasy', 'Thu');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'�鹦','paidWriter1','���� ��Ų ����',10, 'fantasy', 'Fri');

INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'�����','paidWriter2','����� ���� �����',10, 'fantasy', 'Fri');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'������','paidWriter0','��ĳ��',10, 'fantasy', 'Fri');
                        
select * from novel_tbl;
-- ���������������������������������������������������������������������������������

-- �� ���� �Ҽ� ������ ���� 
INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '�̼�', 'freeWriter0', '������ ���� ����', 10, 'fantasy', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '�����', 'freeWriter0', '�̼��ǿ���', 10, 'romance', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '���߿���', 'freeWriter0', '���븶��', 10, 'wuxia', 'free');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                    (novel_num.nextval,'�����ó� ���̰�','freeWriter0','���̾� ��ȭ���� ����', 5, 'mystery', 'free'); 

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '�߰�', 'freeWriter1', '�� ȥ�ڸ� ������', 10, 'fantasy', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '��', 'freeWriter1', 'ȭ���ȯ', 10, 'romance', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '�찢', 'freeWriter1', '������', 10, 'wuxia', 'free');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                    (novel_num.nextval,'�ƿ��߸� ���','freeWriter1','��Ž�� �ڳ�', 5, 'mystery', 'free'); 
                    
INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '������', 'freeWriter2', '��ũ������', 10, 'fantasy', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '����ȿ', 'freeWriter2', '������ ���ƿԴ�', 10, 'romance', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '�±�', 'freeWriter2', 'õ�����', 10, 'wuxia', 'free');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                    (novel_num.nextval,'���� �Ĺ̾�','freeWriter2','�ҳ�Ž�� ������', 5, 'mystery', 'free'); 

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '�����', 'freeWriter3', '�޸������', 10, 'fantasy', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '�ڿ�', 'freeWriter3', '�ܿ﹮�汸', 10, 'romance', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '�谭��', 'freeWriter3', '����������', 10, 'wuxia', 'free');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                    (novel_num.nextval,'�Ƽ� �ڳ� ����','freeWriter3','�ȷ�Ȩ��', 5, 'mystery', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '�̱״Ͻý�', 'freeWriter4', '���¶�����', 10, 'fantasy', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '������', 'freeWriter4', '�츮�� ������� ����', 10, 'romance', 'free');

INSERT INTO novel_tbl (novel_num, novel_writer, user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval, '����ȣ', 'freeWriter4', '���밭ȣ', 10, 'wuxia', 'free');
                        
INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_tsnum, novel_category, novel_week) values
                    (novel_num.nextval,'��������','freeWriter4','Y�Ǻ��', 5, 'mystery', 'free'); 
                    

commit;
                        
-- DELETE ��
DELETE FROM novel_tbl;

-- ��ȸ
SELECT * FROM novel_tbl order by novel_num;

commit;


-- ������Ҽ���
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


-- �� ����Ҽ� ��õ ���̺�
CREATE SEQUENCE rec_num;

CREATE TABLE paid_rec_tbl(
  rec_num number(10,0) primary key,
  user_num number(10,0) not null,
  paid_num number(10,0) not null
);
-- ������ �ذ�
alter sequence rec_num nocache;

-- �ܷ�Ű
alter table paid_rec_tbl add constraint fk_user_num
  foreign key (user_num) references user_tbl(user_num);  

alter table paid_rec_tbl add constraint fk_paid_num
  foreign key (paid_num) references paid_tbl(paid_num);

commit;
-- �ڹ���Ҽ���
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


-- ���� ��õ 
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

-- 05.18 �۰� ��û �Խ��� & ���� ÷������ �Խ���


-- auto
CREATE SEQUENCE enroll_num;

-- ���̺� ����
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

-- ������ �ذ�
alter sequence enroll_num nocache;

-- �ܷ�Ű
alter table enroll_tbl add constraint fk_enroll foreign key (user_id) references user_tbl(user_id);

-- ��ȸ
SELECT * FROM enroll_tbl;

SELECT * FROM enroll_tbl WHERE enroll_num=1;

delete from enroll_tbl;

-- Ŀ��
commit;

-- ����
INSERT INTO enroll_tbl(enroll_num, novel_writer, novel_title, novel_category, user_id, enroll_intro, enroll_msg) VALUES
    (enroll_num.nextval, '�۰�1', '����1', 'romance', 'user2', '��ǰ�Ұ��Դϴ�1', '������ �޼���1');
    
INSERT INTO enroll_tbl(enroll_num, novel_writer, novel_title, novel_category, user_id, enroll_intro, enroll_msg) VALUES
    (enroll_num.nextval, '�۰�2', '����2', 'romance', 'user3', '��ǰ�Ұ��Դϴ�2', '������ �޼���2');
    
INSERT INTO enroll_tbl(enroll_num, novel_writer, novel_title, novel_category, user_id, enroll_intro, enroll_msg) VALUES
    (enroll_num.nextval, '�۰�3', '����3', 'romance', 'user4', '��ǰ�Ұ��Դϴ�3', '������ �޼���3');
    
    
    SELECT * FROM user_tbl;
    
    
-- �������������������������������������� �� ��������������������������������������


-- ÷������ ���̺�



-- ���̺� ����
-- �� �۰���û �̹��� ÷������
CREATE TABLE enroll_img_tbl(

    uuid VARCHAR(100) NOT NULL,          -- uuid
    uploadPath VARCHAR(200) NOT NULL,    -- ���� ���
    fileName VARCHAR(100) NOT NULL,      -- ���� �̸�
    fileType char(1) DEFAULT 'I',        -- �̹������� �ƴ����� ����
    enroll_num number(10)                -- enroll_tbl�� �� ��° �ۿ� �����ִ���
    
);

ALTER TABLE enroll_img_tbl ADD CONSTRAINT pk_enroll_ing_attach PRIMARY KEY (uuid);
ALTER TABLE enroll_img_tbl ADD CONSTRAINT fk_enroll_attach FOREIGN KEY(enroll_num) REFERENCES enroll_tbl(enroll_num);

select * from enroll_img_tbl;
delete from enroll_img_tbl;

-- �� ���� �Ҽ� �̹��� ÷������
SELECT * FROM paid_img_tbl;
CREATE TABLE paid_img_tbl(

    uuid VARCHAR(100) NOT NULL,          -- uuid
    uploadPath VARCHAR(200) NOT NULL,    -- ���� ���
    fileName VARCHAR(100) NOT NULL,      -- ���� �̸�
    fileType char(1) DEFAULT 'I',        -- �̹������� �ƴ����� ����
    paid_num number(10)                -- paid_tbl�� �� ��° �ۿ� �����ִ���
    
);

ALTER TABLE paid_img_tbl ADD CONSTRAINT pk_paid_ing_attach PRIMARY KEY (uuid);
ALTER TABLE paid_img_tbl ADD CONSTRAINT fk_paid_attach FOREIGN KEY(paid_num) REFERENCES paid_tbl(paid_num);


SELECT * FROM paid_img_tbl;

-- �� ���� �Ҽ� �̹��� ÷������
SELECT * FROM free_img_tbl;
CREATE TABLE free_img_tbl(

    uuid VARCHAR(100) NOT NULL,          -- uuid
    uploadPath VARCHAR(200) NOT NULL,    -- ���� ���
    fileName VARCHAR(100) NOT NULL,      -- ���� �̸�
    fileType char(1) DEFAULT 'I',        -- �̹������� �ƴ����� ����
    free_num number(10)                -- free_tbl�� �� ��° �ۿ� �����ִ���
    
);

ALTER TABLE free_img_tbl ADD CONSTRAINT pk_free_ing_attach PRIMARY KEY (uuid);
ALTER TABLE free_img_tbl ADD CONSTRAINT fk_free_attach FOREIGN KEY(free_num) REFERENCES free_tbl(free_num);


SELECT * FROM free_img_tbl;

commit;         
         
-- �� ���� �Ҽ� ���

CREATE SEQUENCE prepl_num;

CREATE TABLE paid_repl_tbl(
  prepl_num number(10,0) PRIMARY KEY,
  novel_num number(10,0) not null,-- novel_tbl novel_num�� fk
  paid_pnum number(10,0) not null, -- paid_tbl paid_num�� fk
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
  foreign key (paid_pnum) references paid_tbl(paid_num);                        -- prepl_pnum�̶�� �Ǿ��־ paid_pnum�� ������

-- �� ���� �Ҽ� ���
CREATE SEQUENCE frepl_num;

CREATE TABLE free_repl_tbl(
  frepl_num number(10,0) PRIMARY KEY,
  novel_num number(10,0) not null,-- novel_tbl novel_num�� fk
  free_num number(10,0) not null, -- free_tbl free_num�� fk
  frepl_content varchar2(1000) not null,
  user_id varchar2(50) not null,  -- user_tbl user_id�� fk
  frepl_rdate date default sysdate,
  frepl_mdate date
);

-- ������ �ذ�
alter sequence frepl_num nocache;

-- �ܷ�Ű ����

  
alter table free_repl_tbl add constraint fk_novel_num
  foreign key (novel_num) references novel_tbl(novel_num);

alter table free_repl_tbl add constraint fk_replyer
  foreign key (user_id) references user_tbl(user_id);  

alter table free_repl_tbl add constraint fk_repl_fnum
  foreign key (free_num) references free_tbl(free_num);
  
  
-- ����ʸ�Ʈ(��ȸ)��
-- auto
CREATE SEQUENCE to_num;

CREATE TABLE tourna_tbl(
  to_num number(10,0) PRIMARY KEY,
  to_name varchar2(50) not null,
  to_sdate date default sysdate,
  to_edate date
);

-- ������ �ذ�
alter sequence to_num nocache;

--INSERT ��
INSERT INTO tourna_tbl (to_num, to_name) values 
                        (to_num.nextval,'�������� �Ҽ� ��Ʋ');
-- ��ȸ
SELECT * FROM tourna_tbl;


-- ����ʸ�Ʈ(��ǰ)��
-- auto
CREATE SEQUENCE towork_num;

CREATE TABLE towork_tbl(
  towork_num number PRIMARY KEY,
  to_num number(10,0), -- fk
  novel_num number(10,0), -- fk
  towork_rec number(10,0) default 0
);

-- ������ �ذ�
alter sequence towork_num nocache;

-- �ܷ�Ű ����
alter table towork_tbl add constraint fk_towork
  foreign key (to_num) references tourna_tbl(to_num);
 
 alter table towork_tbl add constraint fk_towork1
  foreign key (novel_num) references novel_tbl(novel_num);
  
-- INSERT ��
INSERT INTO towork_tbl (towork_num, to_num, novel_num) values
                        (towork_num.nextval,1,2);
                
-- ��ȸ
SELECT * FROM towork_tbl;







-- ����ʸ�Ʈ(��ȸ/��ǰ ���� ��õ ���)��

    -- ��ȣ, ���� ���̵�(���� ��ȣ�� pk�̱� �ѵ� ���̵� ����ũ�ϱ�), ��ʸ�Ʈ ��ȣ, ��ǰ ��ȣ, ��õ ��¥ 
    
    -- auto
    CREATE SEQUENCE torec_num;
    
    CREATE TABLE torec_tbl(
        torec_num number PRIMARY KEY,       -- ��ȣ
        user_id varchar2(20),               -- ���� ���̵�        fk(user_tbl)
        to_num number(10,0),                -- ��ʸ�Ʈ ��ȣ      fk(tourna_tbl)
        towork_num number,                  -- ��ʸ�Ʈ ��ǰ ��ȣ fk(towork_tbl)
        novel_num(10,0) not null,           -- �Ҽ���ȣ 
        rec_date date default sysdate       -- ��õ��
    );

    -- ������ �ذ�
    alter sequence torec_num nocache;
    
    -- �ܷ�Ű ����
    alter table torec_tbl add constraint fk_torec1
        foreign key (user_id) references user_tbl(user_id);
        
    alter table torec_tbl add constraint fk_torec2
        foreign key (to_num) references tourna_tbl(to_num);
        
    alter table torec_tbl add constraint fk_torec3
        foreign key (towork_num) references towork_tbl(towork_num);
        
    alter table torec_tbl add constraint fk_torec4
        foreign key (novel_num) references novel_tbl(novel_num);
    
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
  
    
-- �ڼ�ȣ�ۡ�
-- auto
CREATE SEQUENCE fav_num;

CREATE TABLE favorite_tbl(
  fav_num number(10,0) PRIMARY KEY,
  novel_num number(10,0), -- novel_tbl���� novel_num fk
  user_num number(10,0) -- user_tbl���� user_num fk
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


select novel_num, count(novel_num) as fav from favorite_tbl group by novel_num order by fav desc;




-- �ڹ��� å���ǡ�
-- auto
CREATE SEQUENCE fbm_num;

CREATE TABLE free_bookmark_tbl(
  fbm_num number(10,0) PRIMARY KEY,
  fbm_free_num number(10,0), -- free_tbl���� free_num fk
  user_num number(10,0) -- fk
);
drop table free_bookmark_tbl;
-- ������ �ذ�
alter sequence fbm_num nocache;

-- �ܷ�Ű ����
 alter table free_bookmark_tbl add constraint fk_bookmark_fnum
  foreign key (fbm_free_num) references free_tbl(free_num);
  
alter table free_bookmark_tbl add constraint fk_bookmark2
  foreign key (user_num) references user_tbl(user_num);
commit;  
-- INSERT ��
INSERT INTO bookmark_tbl (fbm_num, novel_num, fbm_free_num, user_num) values
            (fbm_num.nextval, 2, 3, 1);
            
-- ��ȸ
SELECT * FROM free_bookmark_tbl;


-- �ڰ���(����->����)��
-- auto
CREATE SEQUENCE charge_num;

CREATE TABLE charge_tbl(
  charge_num number(10,0) PRIMARY KEY,
  merchant_uid varchar2(100) unique, -- �߰�
  itemname varchar2(100) not null, -- �߰�
  charge_date date default sysdate,
  user_num number(10,0), -- fk
  charge_price number(10) not null,
  charge_coin number(10),
  charge_coupon number(10)
);
select * from user_tbl;

-- ������ �ذ�
alter sequence charge_num nocache;

-- �ܷ�Ű ����
alter table charge_tbl add constraint fk_charge
  foreign key (user_num) references user_tbl(user_num);
  
commit;
  
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
  paid_num number(10,0) not null, --fk � �Ҽ��� �����ߴ��� (�߰�)
  use_type varchar2(10) not null,
  use_count number(10) not null,
  use_date date default sysdate
);
-- �ܷ�Ű ����
alter table use_tbl add constraint fk_use
  foreign key (user_num) references user_tbl(user_num);
  
alter table use_tbl add constraint fk_paidnum
  foreign key (paid_num) references paid_tbl(paid_num);
  
  drop table use_tbl;
-- INSERT 
INSERT INTO use_tbl (use_num, user_num, use_type, use_count) values
                    (use_num.nextval, 1, '����', '100');       
                    
                    commit;
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