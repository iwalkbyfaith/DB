-- 22.05.11 �ڵ� �α��� ('�������' ��� �̶�� �θ�)


-- ������ ����
CREATE SEQUENCE persistent_logins_num;

-- ���̺� ������
CREATE TABLE persistent_logins(
    username varchar(64) not null,
    series varchar(64) primary key,
    token varchar(64) not null,
    last_used timestamp not null
);

-- ������ �ذ�
alter sequence persistent_logins_num nocache; 

-- ��ȸ
SELECT * FROM persistent_logins;



SELECT * FROM member_tbl;