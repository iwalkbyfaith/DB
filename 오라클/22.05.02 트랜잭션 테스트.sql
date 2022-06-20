-- 05.02 새로운 테이블 생성 (스프링의 AOP와 트랜잭션)

CREATE TABLE tbl_test1(
    col1 varchar(50)
);

CREATE TABLE tbl_test2(
    col2 varchar2(5)
);


SELECT * FROM tbl_test1;
SELECT * FROM tbl_test2;

DROP TABLE tbl_test1;





-- 05.02 실 게시판 글 삭제시 트랜잭션 적용하기 (11:02~

    -- 순서1) board_tbl에 댓글개수(replycount) 컬럼을 추가하는 구문
    ALTER TABLE board_tbl ADD replycount int DEFAULT 0;
    
    SELECT * FROM board_tbl;
    
    -- 순서2) update 구문 (전부 0으로 되어있는 댓글을 업데이트 해줌. 사실 WHERE절은 필요는 없음)
    UPDATE board_tbl SET replycount = (SELECT count(rno) FROM reply_tbl WHERE bno = board_tbl.bno) WHERE bno > 0;
    
    -- 확인
    SELECT * FROM board_tbl ORDER BY bno DESC;
    commit;
    
    DELETE FROM reply_tbl WHERE bno=196633;
    
    
SELECT * FROM reply_tbl;

    UPDATE board_tbl SET replycount = 2 WHERE bno = 196631	;

