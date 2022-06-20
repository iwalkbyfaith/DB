-- 04.18 ���

CREATE table reply_tbl(

    rno number(10, 0),                   -- ���� ��ȣ
    bno number(10, 0) not null,          -- �� ��ȣ
    reply varchar2(1000) not null,       -- ���
    replyer varchar2(50) not null,       -- ��� ���� ���
    replyDate date default sysdate,      -- �ۼ���
    updateDate date default sysdate      -- ������
);

create sequence reply_num;

alter table reply_tbl add constraint pk_reply primary key(rno);

alter table reply_tbl add constraint fk_reply foreign key (bno) references board_tbl(bno);

-- ��ȸ
SELECT * FROM reply_tbl ORDER BY rno DESC;



-- Ű���� : ����Ŭ ������ ��ĳ��
alter sequence reply_num nocache;








