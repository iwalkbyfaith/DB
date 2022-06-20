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
CREATE TABLE enroll_img_tbl(

    uuid VARCHAR(100) NOT NULL,          -- uuid
    uploadPath VARCHAR(200) NOT NULL,    -- ���� ���
    fileName VARCHAR(100) NOT NULL,      -- ���� �̸�
    fileType char(1) DEFAULT 'I',        -- �̹������� �ƴ����� ����
    enroll_num number(10)                -- enroll_tbl�� �� ��° �ۿ� �����ִ���
    
);

ALTER TABLE enroll_img_tbl ADD CONSTRAINT pk_enroll_ing_attach PRIMARY KEY (uuid);
ALTER TABLE enroll_img_tbl ADD CONSTRAINT fk_enroll_attach FOREIGN KEY(enroll_num) REFERENCES enroll_tbl(enroll_num);


SELECT * FROM enroll_img_tbl;

commit;

    -- ����
    INSERT INTO enroll_img_tbl (uuid, uploadPath, fileName, fileType, enroll_num)
			VALUES
		('1232313132', '��ΰ��', '�����̸�', 'I', 1);
        
        
    DELETE FROM enroll_img_tbl WHERE uuid= '1232313132';
    
    SELECT * FROM enroll_img_tbl WHERE enroll_num=1;

    
    
    

    
    
    



