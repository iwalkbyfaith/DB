-- Spring_project �۰���û�Խ��� ������ ����


SELECT * FROM enroll_tbl WHERE user_id='user0' AND enroll_result=0;

select * from novel_tbl order by novel_num desc ;
delete from novel_tbl where novel_num > 36;


commit;
delete from enroll_tbl where enroll_result = 0;
select * from auth_tbl order by auth_num;
select * from novel_tbl order by novel_num desc;

select * from enroll_tbl ;
delete from enroll_tbl;

SELECT * FROM enroll_tbl WHERE user_id = 'user0' ORDER BY enroll_num DESC;


select * from enroll_tbl;

commit;

-- ��ȸ
    SELECT * FROM enroll_tbl order by enroll_num desc;
    select * from novel_tbl;
    delete from enroll_tbl where enroll_num=52;
    commit;

-- �۾��� ���� �Է��� ������ �����ϱ�
    INSERT INTO enroll_tbl(enroll_num, novel_title, novel_writer, novel_category, user_id, enroll_intro)
        VALUES
    (enroll_num.nextval, '����', '����', 'fantasy', 'user0', '�ó��¼��');
    
    
    
    commit;
    

-- ������ '����' ��ư ������ �� update �ϱ�
UPDATE enroll_tbl SET enroll_result = 2 WHERE enroll_num=8;


-- ������ '����' ��ư�� ������ �� enroll_result�� 2(���� ����)�ΰ�� novel_tbl�� insert ����
            
    
    
    
    
    INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_category, novel_week) values
                        (novel_num.nextval,'�þƴ�','paidWriter1','�� ���� ����','romance', 'free');
                        
    select * from novel_tbl order by novel_num desc; --where novel_num=37;
    
    
    delete from novel_tbl where novel_num=38;
    
    
    -- ������Ʈ�ϱ� (�Ϲ� ������ '���� ���'�� Ȯ���� �� �ֱ� ������, ������ '�������','�ź�' ���� ������� ����� ������Ʈ�� ���Ѵ�)

    UPDATE 
        enroll_tbl 
    SET 
        novel_title='Ÿ��Ʋ����re', novel_writer='�ʸ���re', novel_category='wuxia', enroll_intro='��������re' 
    WHERE 
        user_id='admin0' AND enroll_num=12;
        
        
    -- �����ϱ�
    DELETE FROM enroll_tbl WHERE enroll_num=9;
    
    
    
    -- �۰���û ��ư Ŭ���� '���δ��'���� �����Ͱ� �������� ������ �ϱ�
        -- 1. DB���� user_id=���̵� and enroll_result=0�� ����� �޾ƿ�
        SELECT * FROM enroll_tbl WHERE user_id='admin0' AND enroll_result=0 ;
        commit;
        
        
        
    -- �������̵� �޾Ƽ� ������ free_writer�� ����
    select * from auth_tbl order by auth_num;
    
    UPDATE auth_tbl SET auth='ROLE_FREE_WRITER' WHERE user_id = 'user0' AND auth = 'ROLE_USER';
    UPDATE auth_tbl SET auth='ROLE_USER' WHERE user_id = 'user0';
    
    commit;
    
    
    
    
    select * from novel_tbl order by novel_num desc;
    
    delete from novel_tbl where novel_num > 35;
    
    commit;

    select * from torec_tbl;
    delete from torec_tbl;
        
        
        
    select * from novel_tbl order by novel_num desc;
    
    select * from auth_tbl order by auth_num ;
    
    update auth_tbl set auth = 'ROLE_USER' WHERE user_id='user0' or user_id='user1' or user_id='user2' or user_id='user3' or user_id='user7';
    commit;
    
    
    
    
    