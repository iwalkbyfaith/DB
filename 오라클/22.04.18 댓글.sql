-- 04.18 댓글

CREATE table reply_tbl(

    rno number(10, 0),                   -- 리플 번호
    bno number(10, 0) not null,          -- 글 번호
    reply varchar2(1000) not null,       -- 댓글
    replyer varchar2(50) not null,       -- 댓글 쓰는 사람
    replyDate date default sysdate,      -- 작성일
    updateDate date default sysdate      -- 수정일
);

create sequence reply_num;

alter table reply_tbl add constraint pk_reply primary key(rno);

alter table reply_tbl add constraint fk_reply foreign key (bno) references board_tbl(bno);

-- 조회
SELECT * FROM reply_tbl ORDER BY rno DESC;



-- 키워드 : 오라클 시퀀스 노캐시
alter sequence reply_num nocache;








