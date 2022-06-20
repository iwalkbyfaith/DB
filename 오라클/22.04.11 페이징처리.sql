
-- ����¡ ó���� ���� �� �ø���
insert into board_tbl (bno, title, content, writer) (select Board_NUM.nextval, title, content, writer from board_tbl);

-- ���� ������ Ŀ�Ա��� �������
commit;

-- �� �� ������ Ȯ�� �غ�
SELECT count(*) FROM board_tbl;

-- ��Ʈ
SELECT 
/*+ ��Ʈ�� �� �ڸ�*/
* FROM board_tbl;


-- ����� '��ȹ ����' Ŭ�� (�������� �Ʒ��� �������� �ð��� ���� �ɷ���) >- ��Ʈ�� ����ϴ� ����
SELECT * FROM board_tbl ORDER BY bno DESC;
    -- bno�� ������ ������ �ϵ��� ó����


-- �� ��ȸ�ϱ� (���� �������� �Ʒ� �������� �� ����.)
SELECT
/*+ INDEX_DESC(board_tbl pk_board) */
* FROM board_tbl;
    -- ��ȣ������ ���°� �ƴ϶� �޸� �ּ� ������ ���� ��


-- �� ��ȸ�ϱ� + (���� p.10)
SELECT
/*+ INDEX_DESC(board_tbl pk_board) */
rownum, rowid, board_tbl.* FROM board_tbl;


    -- bno�� �������� ���������Ǵ� ���� : ��Ʈ�� �༭ �����߱� ����
    -- rowid = �޸𸮿� ����� �ּ� (������ �ʴ´�)
    -- rownum = �������� �����Ǵ� ���� (�ٸ� �÷����� �� ���� �ǰ� ���� ���������� �³׵鿡�� ��ȣ�� �ο��ϴ� ��) (�׷��� ���� �� �ִ�)
        -- �׷��� ����Ʈ ������ � �������� ������ �޵��� rownum�� 1���� �������� �ο��Ǵ� �� (�ش� �����Ϳ� ����� �����Ͱ� �ƴ϶�� ��)
        -- MySQL�� ����Ʈ ������ ������ �ϴ� ���� rownum�̶�� �����ϸ� �ȴ�.
        
    -- �̰� �� ������?
        -- bno�� ���� ���
            -- �츮 ���忡���� ������ �� �ʿ䰡 ������, ��ǻ�� ���忡���� ������ �� �� �� ���־�� ��. (�׳� select�� �������� bno�� �����ִ� ��쵵 �־)
            -- �׷��� ORDER BY�� �Ἥ bno�� ������ �ɾ��־���.
            -- �׷��� ������ �����ȹ���� Ȯ�������� �ɼǿ� 'full'�̶�� ���� (Ǯ�� ��ĵ�� �Ѵٴ� ��) (���� ���̰� �ڽ�Ʈ(=�ڿ�)�� �� ��Ƹ���)
                -- 1������ �� ������ �� ��ȸ -> �� ���� �ϳ��ϳ� ������ ���ߴ� ��
                
        -- �׷��� ���� ��ĵ ������ ����ߴ���(��Ʈ �����)
            -- ��ĵ�� Ǯ�� ���� �ڿ��� ���� ��Ƹ��� �ʴ� ���� �� �� �ִ�.
            
        -- rowid�� �����Ҷ�
            -- rowid�� ���������� ����
            -- bno�� �޸� �ּҰ� �ƴϰ� �׳� �ο��� ��ȣ����, rowid�� ����� �������� �����̾ ���۰� ����ȣ�� �˸� ������� �� ���� �� �ִ� ��.
            -- bno ���� ���� �� ��ȣ�� ���� �� ������, rowid�� �޸𸮿� ������� ������ (rowid ����ȣ ���� �� �� ����)
            
   
    
-- rownum�� ������ ���� �ƴ϶�� ���� �����ֱ� ���ؼ� �ٸ� ���� ����غ�(11:46~)
    -- (�ؼ�) �Ʊ�� rownum 1���̾��� 196625�� �̹����� rownum�� 11�� ��
SELECT
/*+ INDEX_ASC(board_tbl pk_board) */
rownum, rowid, board_tbl.* FROM board_tbl WHERE bno BETWEEN 196615 AND 196625;



-- (���) rownum���� ����¡ó���� �ϰ�, rowid�� ������ �� 
    -- rowid : �޸� �������� �ٷ� ��ĵ
    -- bno : �޸� �������� ��ü ���ڸ� �� �޾ƿͼ� �ϳ��ϳ� ������� �����ϴ� ��
    
    
    
    
    
-- rownum�� �̿��� ���������̼� ���� �ۼ��ϱ� (02:17~
    -- rowid�� ��ȸ�� �� �ʿ䰡 ����(���ĸ� �ϸ� �Ǳ� ������)
    -- 1~20���� ���� ��ȸ��
    -- rownum rn�̶�� ��Ī���� �ٲٸ� ������ �ȴ�(02:23~
SELECT 
/*+ INDEX_DESC(board_tbl pk_board)*/
rownum rn, board_tbl.* FROM board_tbl WHERE rownum <= 20;



-- ���ʰ� �ٱ����� rownum�� ��ġ�� ����� �ȳ���. �׷��� ������ rownum���� rn�̶�� �̸��� �ٿ����� ��
SELECT * FROM
(SELECT /*+ INDEX_DESC(board_tbl pk_board) */
rownum, board_tbl.* FROM board_tbl WHERE rownum <=20)
WHERE rownum >10;


-- �׷��� �ٲٸ� �̷��� �� (����)
SELECT * FROM
(SELECT /*+ INDEX_DESC(board_tbl pk_board) */
rownum rn, board_tbl.* FROM board_tbl WHERE rownum <=20)
WHERE rn >10;




