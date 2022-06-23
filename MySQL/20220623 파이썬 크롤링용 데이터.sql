-- 더미 데이터를 넣을 테이블 생성
CREATE TABLE test_tbl(
	tno int primary key auto_increment,
    tname varchar(20)
);

SELECT * FROM test_tbl;

insert into test_tbl VALUES (null, 'd');

delete from test_tbl where tno >= 8;



CREATE TABLE test2_tbl(
	audiCnt int,
    scrnCnt int,
    result int,
    movieNm varchar(1000)
);


select * from test2_tbl;


delete from test2_tbl;

drop table test2_tbl;



CREATE TABLE test3_tbl(
	audiCnt int,
    scrnCnt int,
    result int,
    movieNm varchar(1000)
);

select * from test3_tbl;
select count(*) from test3_tbl;

drop table test3_tbl;
-- 
