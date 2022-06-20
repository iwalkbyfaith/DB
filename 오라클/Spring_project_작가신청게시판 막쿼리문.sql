-- Spring_project 작가신청게시판 쿼리문 모음


SELECT * FROM enroll_tbl WHERE user_id='user0' AND enroll_result=0;

select * from novel_tbl order by novel_num desc ;
delete from novel_tbl where novel_num > 36;


commit;
delete from enroll_tbl where enroll_result = 0;
select * from auth_tbl order by auth_num;
select * from novel_tbl order by novel_num desc;

select * from enroll_tbl ;
delete from enroll_tbl;

SELECT * FROM enroll_tbl WHERE user_id = 'user0' ORDER BY enroll_num DESC;


select * from enroll_tbl;

commit;

-- 조회
    SELECT * FROM enroll_tbl order by enroll_num desc;
    select * from novel_tbl;
    delete from enroll_tbl where enroll_num=52;
    commit;

-- 글쓰기 폼에 입력한 데이터 적재하기
    INSERT INTO enroll_tbl(enroll_num, novel_title, novel_writer, novel_category, user_id, enroll_intro)
        VALUES
    (enroll_num.nextval, 'ㅈㅈ', 'ㅍㅍ', 'fantasy', 'user0', '시놉어쩌구');
    
    
    
    commit;
    

-- 관리자 '선택' 버튼 눌렀을 때 update 하기
UPDATE enroll_tbl SET enroll_result = 2 WHERE enroll_num=8;


-- 관리자 '선택' 버튼을 눌렀을 때 enroll_result가 2(무료 승인)인경우 novel_tbl에 insert 해주
            
    
    
    
    
    INSERT INTO novel_tbl (novel_num, novel_writer,user_id, novel_title, novel_category, novel_week) values
                        (novel_num.nextval,'플아다','paidWriter1','날 닮은 아이','romance', 'free');
                        
    select * from novel_tbl order by novel_num desc; --where novel_num=37;
    
    
    delete from novel_tbl where novel_num=38;
    
    
    -- 업데이트하기 (일반 유저는 '승인 대기'만 확인할 수 있기 때문에, 승인이 '무료승인','거부' 등의 결과값이 생기면 업데이트를 못한다)

    UPDATE 
        enroll_tbl 
    SET 
        novel_title='타이틀변경re', novel_writer='필명변경re', novel_category='wuxia', enroll_intro='변경했음re' 
    WHERE 
        user_id='admin0' AND enroll_num=12;
        
        
    -- 삭제하기
    DELETE FROM enroll_tbl WHERE enroll_num=9;
    
    
    
    -- 작가신청 버튼 클릭시 '승인대기'중인 데이터가 있을때는 못쓰게 하기
        -- 1. DB에서 user_id=아이디 and enroll_result=0의 결과를 받아옴
        SELECT * FROM enroll_tbl WHERE user_id='admin0' AND enroll_result=0 ;
        commit;
        
        
        
    -- 유저아이디를 받아서 권한을 free_writer로 변경
    select * from auth_tbl order by auth_num;
    
    UPDATE auth_tbl SET auth='ROLE_FREE_WRITER' WHERE user_id = 'user0' AND auth = 'ROLE_USER';
    UPDATE auth_tbl SET auth='ROLE_USER' WHERE user_id = 'user0';
    
    commit;
    
    
    
    
    select * from novel_tbl order by novel_num desc;
    
    delete from novel_tbl where novel_num > 35;
    
    commit;

    select * from torec_tbl;
    delete from torec_tbl;
        
        
        
    select * from novel_tbl order by novel_num desc;
    
    select * from auth_tbl order by auth_num ;
    
    update auth_tbl set auth = 'ROLE_USER' WHERE user_id='user0' or user_id='user1' or user_id='user2' or user_id='user3' or user_id='user7';
    commit;
    
    
    
    
    