
-- 변수 생성 (0으로 저장됨)
CREATE SEQUENCE board_num;

-- 테이블 생성
CREATE TABLE board_tbl(
    bno number(10, 0),
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
    );
    
alter table board_tbl add constraint pk_board primary key(bno);

-- 적재
INSERT INTO board_tbl (bno, title, content, writer) VALUES (board_num.nextval, '테스트글', '테스트본문', '글쓴이');

-- 조회
SELECT * FROM board_tbl ORDER BY bno DESC;
SELECT rowid, rownum, board_tbl.* FROM board_tbl WHERE rownum <= 5;

-- commit 구문을 실행해야 비로소 데이터가 박제됨 (근데 난 안했는데도 나오긴 했음;;왜지)
commit;

-- BNO가 20씩 튀는 것을 막기 위해서 쓰는 구문
alter sequence board_num nocache;

-- 변경
UPDATE board_tbl SET title='제목변경' WHERE bno='3';
UPDATE board_tbl SET title='07제목', content='07본문', updatedate=sysdate WHERE writer='새로넣는 글쓴이3';

insert into board_tbl (bno, title, content, writer) (select Board_NUM.nextval, title, content, writer from board_tbl);


-- 테스트
INSERT INTO board_tbl (bno, title, content, writer) VALUES (board_num.nextval, '테스트글', '테스트본문', '글쓴이');

