-- 05.18 작가 신청 게시판 & 딸린 첨부파일 게시판


-- auto
CREATE SEQUENCE enroll_num;

-- 테이블 생성
CREATE TABLE enroll_tbl(

    enroll_num number(10,0) PRIMARY KEY,
    novel_writer varchar2(50) not null,
    novel_title varchar2(200) not null,
    novel_category varchar2(10) not null,
    user_id varchar2(20) not null, 
    enroll_intro varchar2(2000) not null,
    enroll_result number(10,0) default 0,
    enroll_msg varchar2(1000)
);

-- 시퀀스 해결
alter sequence enroll_num nocache;

-- 외래키
alter table enroll_tbl add constraint fk_enroll foreign key (user_id) references user_tbl(user_id);

-- 조회
SELECT * FROM enroll_tbl;

SELECT * FROM enroll_tbl WHERE enroll_num=1;

-- 커밋
commit;

-- 적재
INSERT INTO enroll_tbl(enroll_num, novel_writer, novel_title, novel_category, user_id, enroll_intro, enroll_msg) VALUES
    (enroll_num.nextval, '작가1', '제목1', 'romance', 'user2', '작품소개입니다1', '관리자 메세지1');
    
INSERT INTO enroll_tbl(enroll_num, novel_writer, novel_title, novel_category, user_id, enroll_intro, enroll_msg) VALUES
    (enroll_num.nextval, '작가2', '제목2', 'romance', 'user3', '작품소개입니다2', '관리자 메세지2');
    
INSERT INTO enroll_tbl(enroll_num, novel_writer, novel_title, novel_category, user_id, enroll_intro, enroll_msg) VALUES
    (enroll_num.nextval, '작가3', '제목3', 'romance', 'user4', '작품소개입니다3', '관리자 메세지3');
    
    
    SELECT * FROM user_tbl;
    
    
-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ▼ ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■


-- 첨부파일 테이블



-- 테이블 생성
CREATE TABLE enroll_img_tbl(

    uuid VARCHAR(100) NOT NULL,          -- uuid
    uploadPath VARCHAR(200) NOT NULL,    -- 파일 경로
    fileName VARCHAR(100) NOT NULL,      -- 파일 이름
    fileType char(1) DEFAULT 'I',        -- 이미지인지 아닌지의 여부
    enroll_num number(10)                -- enroll_tbl의 몇 번째 글에 딸려있는지
    
);

ALTER TABLE enroll_img_tbl ADD CONSTRAINT pk_enroll_ing_attach PRIMARY KEY (uuid);
ALTER TABLE enroll_img_tbl ADD CONSTRAINT fk_enroll_attach FOREIGN KEY(enroll_num) REFERENCES enroll_tbl(enroll_num);


SELECT * FROM enroll_img_tbl;

commit;

    -- 적재
    INSERT INTO enroll_img_tbl (uuid, uploadPath, fileName, fileType, enroll_num)
			VALUES
		('1232313132', '경로경로', '파일이름', 'I', 1);
        
        
    DELETE FROM enroll_img_tbl WHERE uuid= '1232313132';
    
    SELECT * FROM enroll_img_tbl WHERE enroll_num=1;

    
    
    

    
    
    



