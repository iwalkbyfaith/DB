

-- 게시판 테이블(boardinfo)을 생성해보겠습니다

/*

	게시물 번호(board_num) : int, primary key, auto increment
    게시물 제목(title)     : varchar(100), not null
    게시물 본문(content)   : varchar(2000), not null
    글쓴이(writer)        : varchar(30), not null (userinfo의 닉네임과 맞춰주면 됨)
    작성 날짜(bdate)       : datetime, default now()
    최종 수정 날짜(mdate)   : datetime, default now()
    조회수(hit)           : int, default 0

*/


-- 생성
	CREATE TABLE boardinfo(
			board_num INT PRIMARY KEY AUTO_INCREMENT,
			title VARCHAR(100) NOT NULL,
			content VARCHAR(2000) NOT NULL,
			writer VARCHAR(30) NOT NULL,
			bdate DATETIME DEFAULT now(),
			mdate DATETIME DEFAULT now(),
			hit INT DEFAULT 0
		);

-- 테이블 삭제    
drop table boardinfo;

-- 테이블 조회
SELECT * FROM boardinfo ;

-- 전체 글 몇개 있는지 조회
SELECT count(*) FROM boardinfo ;

-- 페이징 처리를 위한 리미트 구문
SELECT * FROM boardinfo ORDER BY board_num DESC limit 0, 10;
SELECT * FROM boardinfo ORDER BY board_num DESC limit 10, 10;
SELECT * FROM boardinfo ORDER BY board_num DESC limit 20, 10;

-- 재귀함수 (페이징 처리를 위한 게시판 증식 구문)
INSERT INTO boardinfo(title, content, writer, bdate, mdate) (SELECT title, content, writer, bdate, mdate FROM boardinfo);
-- - mdate, bdate 는 디폴트 설정 되어 있어서 안 넣어도 됨.



-- 적재
-- INSERT INTO로 글 3개만 넣어주세요. 글제목, 글본문, 저자는 마음대로 설정해주세요

	-- 방법)
	INSERT INTO boardinfo(title, content, writer) VALUES ('제목입니다', '내용입니다', '쓴이입니다');
	INSERT INTO boardinfo(title, content, writer) VALUES ('제목제목', '내용내용', '쓴이쓴이');
	INSERT INTO boardinfo(title, content, writer) VALUES ('타이틀틀', '컨텐트트', '라이터터');

	-- ★ 이 방법은 안됨!) 왜냐면 null로 넣었을때 작성일,수정일,조회수는 null처리가 됨(글번호는 됨)
	INSERT INTO boardinfo VALUE (null, '그냥', '점심이', '먹고 싶은', null, null, null);
    
-- 삭제
DELETE FROM boardinfo WHERE board_num = '1';

-- 수정
UPDATE boardinfo SET title='제목수정' WHERE board_num ='1';
