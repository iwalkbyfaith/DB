-- 05.02 ���ο� ���̺� ���� (�������� AOP�� Ʈ�����)

CREATE TABLE tbl_test1(
    col1 varchar(50)
);

CREATE TABLE tbl_test2(
    col2 varchar2(5)
);


SELECT * FROM tbl_test1;
SELECT * FROM tbl_test2;

DROP TABLE tbl_test1;





-- 05.02 �� �Խ��� �� ������ Ʈ����� �����ϱ� (11:02~

    -- ����1) board_tbl�� ��۰���(replycount) �÷��� �߰��ϴ� ����
    ALTER TABLE board_tbl ADD replycount int DEFAULT 0;
    
    SELECT * FROM board_tbl;
    
    -- ����2) update ���� (���� 0���� �Ǿ��ִ� ����� ������Ʈ ����. ��� WHERE���� �ʿ�� ����)
    UPDATE board_tbl SET replycount = (SELECT count(rno) FROM reply_tbl WHERE bno = board_tbl.bno) WHERE bno > 0;
    
    -- Ȯ��
    SELECT * FROM board_tbl ORDER BY bno DESC;
    commit;
    
    DELETE FROM reply_tbl WHERE bno=196633;
    
    
SELECT * FROM reply_tbl;

    UPDATE board_tbl SET replycount = 2 WHERE bno = 196631	;

