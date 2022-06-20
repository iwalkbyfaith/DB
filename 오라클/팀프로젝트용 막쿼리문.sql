-- ������Ʈ���� �� ���� ������ ����

-- ��ʸ�Ʈ ��ǰ ��ȣ�� 6�϶�, 6�� ��ǰ�� ��õ�� ��������
SELECT towork_rec FROM (SELECT * FROM tourna_tbl INNER JOIN towork_tbl ON tourna_tbl.to_num = towork_tbl.to_num) tt
        INNER JOIN 
        novel_tbl nt 
    ON tt.novel_num = nt.novel_num 
    WHERE tt.towork_num =6;
    
    
SELECT towork_rec FROM towork_tbl WHERE towork_num=6;

UPDATE towork_tbl SET towork_rec = towork_rec + 1 WHERE towork_num = 6;

SELECT * FROM towork_tbl;

SELECT * FROM reply_tbl;

DELETE FROM reply_tbl WHERE rno = 1;




-- ����� (�°�)

INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'�������۰�','������ ����', 10, 'wuxia', 'Mon');
                        
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                    (novel_num.nextval,'ȭ�����۰�','ȭ���� ����', 10, 'romance', 'Tue');
                    
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'�������۰�','������ ����',10, 'wuxia', 'Wen');

INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'������۰�','����� ����',10, 'fantasy', 'Thu');
                        
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'�ݿ����۰�','�ݿ��� ����',10, 'fantasy', 'Fri');
                        
INSERT INTO paid_tbl (paid_num, novel_num, paid_snum, paid_title, paid_content) values
                        (paid_num.nextval, '20', 1, '������ ���� 1��', '������ ���� 1�� ����');
                        
INSERT INTO paid_tbl (paid_num, novel_num, paid_snum, paid_title, paid_content) values
                        (paid_num.nextval, '21', 1, 'ȭ���� ���� 1��', 'ȭ���� ���� 1�� ����');
                        
INSERT INTO paid_tbl (paid_num, novel_num, paid_snum, paid_title, paid_content) values
                        (paid_num.nextval, '22', 1, '������ ���� 1��', '������ ���� 1�� ����');
                        
INSERT INTO paid_tbl (paid_num, novel_num, paid_snum, paid_title, paid_content) values
                        (paid_num.nextval, '23', 1, '����� ���� 1��', '����� ���� 1�� ����');
                        
INSERT INTO paid_tbl (paid_num, novel_num, paid_snum, paid_title, paid_content) values
                        (paid_num.nextval, '24', 1, '�ݿ��� ���� 1��', '�ݿ��� ���� 1�� ����');
                        
                        commit;
                        
                        
                        
-- �����

-- ����Ÿ���Ҽ��� 
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'����','������� �����̴�',100, 'fantasy', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'�۷���','������ 1���ڰ� �Ǿ���',100, 'fantasy', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'�߰�','�� ȥ�ڸ� ������',100, 'fantasy', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'���׸�','�Ǵ��� ��ư��¹�',100, 'fantasy', 'free');
-- �ڷθǽ��Ҽ��� 
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'������','����ȿ��',100, 'romance', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'�̼�','���������',100, 'romance', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'������','�Ҹ���',100, 'romance', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'������','����� ���� ��ó��',100, 'romance', 'free');

-- �ڹ����Ҽ���         
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'�念��','���밭ȣ',100, 'wuxia', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'�±�','õ�����',100, 'wuxia', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'����','�±ع�',100, 'wuxia', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'������','����',100, 'wuxia', 'free');

-- ���߸��Ҽ���                                 
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'�����̰���','�����',100, 'detective', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'�ƿ��߸� ���','��Ž���ڳ�',100, 'detective', 'free');
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'Ű�پ߽� ��','�ҳ�Ž�� ������',100, 'detective', 'free');                        
INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values
                        (novel_num.nextval,'B.A.�и���','�����ε� ����',100, 'detective', 'free');
                        
                        
    -- ����Ÿ�� ����Ҽ� - ������                    
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
    (free_num.nextval, '30',1,'������_��1��-1ȭ','�̹� Ŭ������ ���� �ӿ� ������.
    �׷���
    �� [�����]���� �� ����� �����̴�.'); 
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '30',2,'������_��1��-2ȭ','[������ ��]
���󿡼� ���� ������ ���� �� �ϳ� ������ ����ϰ� ���۵� �ϳ��� ���迡�� ���ʾ��� �ΰ����� NPC�� �����ϴ�, �ִܱ� >������ ���� ���ؼ��� ���ӽð����� 10�� �̻� �÷��̰� �ʿ��� ����.'); 
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '30',3,'������_��1��-3ȭ','���ΰ� �;���.
���� ������ ������� �� �ǰ�.
��� ���ɼ��� �����ϰ� ���� �ϳ���, �ƹ��� ���� ���� �ʴ� ���̶� �����̶� �����ߴ�.
�ƹ��� �̼������� �����ϴ��� �̰��� ������ �´� �� ���Ҵ�.
52���� �÷����ϸ鼭 �� ������ ���丮�� �Ǵ� ��� �ִ�.'); 
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '30',4,'������_��1��-4ȭ','���� ���� ����������

�������� ������ ��� ���� Ű���.

�׷� �� ���� ���� �Ѿ ������ �÷��̾�ϱ�.');                       
-- ����Ÿ�� ����Ҽ�  - �����ϡ�                    
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '31',1,'������_��1��-1ȭ','������ ȯ���� ������� ���, ���� ���ټ� ������ ������ ���� �����ϰ� �Ǿ���.'); 
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '31',2,'������_��1��-2ȭ','������ ȯ���� ����� �� ��ġ�ٲ����� �ߴ�. �׷��� ��ȸ�� �Դ�.

�����Ϸ� �Ǹ� ���� ������ ���� �����ߴ�. �� �ڷ�ڷ� �� ������ �����̿� ����̶��� ��Ե� �������� �װ� �ƹ��� ������ ���� �ʾҴ�.');
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '31',3,'������_��1��-3ȭ','"���� Ű�� �ֵ��� ���ε�."

���ж� �Ҹ��� ������ ���, ������ �����߸� �巡�� �����̾�, ���� ���� Ű����.'); 
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '31',4,'������_��1��-4ȭ','�̱� ���� ���� ���� �ƹ��͵� �ƴϾ���.

<������ 1���ڰ� �Ǿ���> Prologue ��');  
-- ����Ÿ�� ����Ҽ�  - ��ȥ�ڸ���������                    
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '32',1,'��ȥ��_��1��-1ȭ','10�� ��, ����ü ������ �� �� ���� ������Ʈ����� ���� ���ܳ��� �ǰ� �װ��� ���������̶� �θ���. �� �ȿ����� ����������� ���簡 ��۰Ÿ���. ������������ �ΰ����� �������̷� ���̰� �ȴ�. �׸��� �� ������������ ��� �ΰ����� �����͡���� �Ѵ�'); 
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '32',2,'��ȥ��_��1��-2ȭ','������ ����� E�޺��� D��, C��, B��, A�� �׸��� ���� ���� S���� �����Ѵ�.
�׷��� ���� ���ѹα��� �Ϲ��ΰ� ���� �ٸ��� ���� ������ ���� E�� ����, �������� û���� �־���');
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '32',3,'��ȥ��_��1��-3ȭ','�� ���� ������ ������Ե� ���� ���� ���� �ż��� ���� �ǰ�, ������ ���� �ķ��� ������ ���� �־���.
�������� ���ο� ��Ӵ��� ������ ���� �ֺ��ε鿡�� �η� �־ິ���� ��� �����鼭�� ������ ���� ���� �ϴ� E�� ���� �������'); 
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '33',4,'��ȥ��_��1��-4ȭ','�� ������ ���� ���� ������ ���� �޴ٰ� ���� �ϳ��� ã�� ���� ������ ���� ������ �� �������� ��Ӵϸ� ���ø��� ���� ������ ����. ����� �ڽ��� �����Կ� ȭ���� ���񿡰� ����� �ϴµ�, �̶� �̾��ϸ� ���̶� ���� ����Ʈ ��û�� �޴´�.');  

-- ����Ÿ�� ����Ҽ�  - �Ǵ��� ��ư��¹���                    
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '33',1,'�Ǵ����λ��_��1��-1ȭ','���� �Ǵ��̴�.
�װ͵� ������ ���ϰ� ġ���ϰ� ������ �Ǵ��̴�'); 
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '33',2,'�Ǵ����λ��_��1��-2ȭ','�׸��� ���� �Ǵ��ΰ��� ���� �β����� ������ �ʴ´�.');
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '33',3,'�Ǵ����λ��_��1��-3ȭ','���� �Ǵ��̴�.
�װ͵� ������ ���ϰ� ġ���ϰ� ������ �Ǵ��̴�.'); 
INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content) values
                        (free_num.nextval, '33',4,'�Ǵ����λ��_��1��-4ȭ','�׸��� ���� �Ǵ��ΰ��� ���� �β����� ������ �ʴ´�.');
  commit;                      
                        
                        select n.novel_title,n.novel_num from novel_tbl n WHERE n.novel_category='romance' ORDER BY n.novel_num DESC;
                        
                        
                        
                        
         select * FROM towork_tbl;               
                        
                        

-- ��ʸ�Ʈ ������ �� ��ȸ���� ���ϱ�
    -- 8������ �� ��ǰ�� �ö󰡾��ϴµ�
        -- �ϴ� �� ��ǰ���� ��ȸ���� �����غ���.
            SELECT * FROM free_tbl;
            UPDATE free_tbl SET free_hit = 239 WHERE novel_num=30 AND free_snum=1;
            UPDATE free_tbl SET free_hit = 113 WHERE novel_num=30 AND free_snum=2;
            UPDATE free_tbl SET free_hit = 97 WHERE novel_num=30 AND free_snum=3;
            
            UPDATE free_tbl SET free_hit = 1120 WHERE novel_num=32 AND free_snum=1;
            UPDATE free_tbl SET free_hit = 339 WHERE novel_num=32 AND free_snum=2;
            UPDATE free_tbl SET free_hit = 24 WHERE novel_num=32 AND free_snum=3;
            
            UPDATE free_tbl SET free_hit = 19 WHERE novel_num=17 AND free_snum=1;
            
            UPDATE free_tbl SET free_hit = 3 WHERE novel_num=19 AND free_snum=1;
            
        -- �׷� ���̷� ��ȸ���� ����� (�Ҽ� ��ȣ��)
            SELECT novel_num, sum(free_hit) FROM free_tbl GROUP BY novel_num ORDER BY sum(free_hit) DESC;
    
        -- ���⼭ ���� 4��
        SELECT * FROM (SELECT novel_num, sum(free_hit) FROM free_tbl GROUP BY novel_num ORDER BY sum(free_hit) DESC) WHERE rownum <= 4 ;
        
        
        
        
        
        
        
        
        
        
        
        
        
            ALTER TABLE novel_tbl MODIFY novel_category varchar2(30);
            
    -- INSERT novel (10�� ����) ��Ÿ��, ����, �θǽ�, �̽��͸�                                                                       �۰��̸�  �Ҽ����� ����� ī�װ� ����                                   ��ǰ��ȣ
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'�㼺��','Ŭ����', 12, '��Ÿ��', 'free');                            -- 48
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'�޸�','��Ȳ�� õ�� ���б�', 28, '����', 'free');                      -- 49
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'��������','��Ʋ�� ���� ���迡�� ��Ƴ���', 113, '����', 'free');      -- 50
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'���Ǻ�','�ݿ��� �㿡 ������ ����', 33, '�θǽ�', 'free');             -- 51
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'����','������ ��ȥ', 7, '�θǽ�', 'free');                            -- 52 
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'������','������ Ĭ����', 44, '�̽��͸�', 'free');                     -- 55
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'�̻���','���ϼ���',229, '�̽��͸�', 'free');                          -- 56
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'��ñ���','ȸ�� �ż�', 22, '����', 'free');                           -- 57
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'ȫ�۰�','�θǽ��� �޲ٴ�', 23, '�θǽ�', 'free');                     -- 58
        INSERT INTO novel_tbl (novel_num, novel_writer, novel_title, novel_tsnum, novel_category, novel_week) values (novel_num.nextval,'������','ž��Ŀ�� �۰����� ��Ȱ�鼭',56, '��Ÿ��', 'free');         -- 59
        
        SELECT * FROM novel_tbl ORDER BY novel_num DESC;
    
    -- INSERT free (2���� * 10 ����)                                                                                    ��ǰ��ȣ ȸ�� ����            ���� 
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '48', 2,'Ŭ���� 2ȸ', 'Ŭ���� 2ȸ�� �����Դϴ�', 23); 
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '49', 1,'��Ȳ�� õ�� ���б� 2ȸ', '��Ȳ�� õ�� ���б� 2ȸ�� �����Դϴ�', 19);
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '50', 1,'��Ʋ�� ���� 2ȸ', '��Ʋ�� ���� 2ȸ�� �����Դϴ�', 76);
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '51', 2,'�ݿ��� ���� ���� 2ȸ', '�ݿ��� ���� ���� 2ȸ�� �����Դϴ�', 1230);
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '52', 2,'������ ��ȥ 2ȸ', '������ ��ȥ 2ȸ�� �����Դϴ�', 280);
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '55', 2,'������ Ĭ���� 2ȸ', '������ Ĭ���� 2ȸ�� �����Դϴ�', 110);
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '56', 2,'���ϼ��� 2ȸ', '���ϼ��� 2ȸ�� �����Դϴ�', 338);
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '57', 1,'ȸ�� �ż� 1ȸ', 'ȸ�ͽż� 1ȸ�� �����Դϴ�', 331);
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '58', 2,'�θǽ��� 2ȸ', '�θǽ��� 2ȸ�� �����Դϴ�', 1340);
        INSERT INTO free_tbl (free_num, novel_num, free_snum, free_title, free_content, free_hit) values (free_num.nextval, '59', 2,'ž��Ŀ�� 2ȸ', 'ž��Ŀ�� 2ȸ�� �����Դϴ�', 998);
    
        DELETE FROM free_tbl WHERE novel_num=57;
        SELECT * FROM free_tbl;
    
    
