
-- 페이징 처리를 위해 글 늘리기
insert into board_tbl (bno, title, content, writer) (select Board_NUM.nextval, title, content, writer from board_tbl);

-- 변경 사항은 커밋까지 해줘야함
commit;

-- 몇 개 들어갔는지 확인 해봄
SELECT count(*) FROM board_tbl;

-- 힌트
SELECT 
/*+ 힌트가 들어갈 자리*/
* FROM board_tbl;


-- 상단의 '계획 실행' 클릭 (예전에는 아래의 쿼리문이 시간이 많이 걸렸음) >- 힌트를 사용하는 이유
SELECT * FROM board_tbl ORDER BY bno DESC;
    -- bno만 가지고 정렬을 하도록 처리됨


-- 글 조회하기 (위의 구문보다 아래 쿼리문이 더 빠름.)
SELECT
/*+ INDEX_DESC(board_tbl pk_board) */
* FROM board_tbl;
    -- 번호순으로 보는게 아니라 메모리 주소 개념이 들어가게 됨


-- 글 조회하기 + (교안 p.10)
SELECT
/*+ INDEX_DESC(board_tbl pk_board) */
rownum, rowid, board_tbl.* FROM board_tbl;


    -- bno를 기준으로 내림차순되는 이유 : 힌트를 줘서 정렬했기 때문
    -- rowid = 메모리에 저장된 주소 (변하지 않는다)
    -- rownum = 마지막에 결정되는 순서 (다른 컬럼들이 다 생성 되고 나서 마지막으로 걔네들에게 번호를 부여하는 것) (그래서 변할 수 있다)
        -- 그래서 셀렉트 구문을 어떤 조건으로 날려서 받든지 rownum은 1부터 끝번까지 부여되는 것 (해당 데이터와 연결된 데이터가 아니라는 것)
        -- MySQL의 리미트 구문의 역할을 하는 것이 rownum이라고 생각하면 된다.
        
    -- 이게 왜 빠르냐?
        -- bno의 정렬 방식
            -- 우리 입장에서는 일일이 볼 필요가 없지만, 컴퓨터 입장에서는 정렬을 한 번 더 해주어야 함. (그냥 select로 가져오면 bno가 섞여있는 경우도 있어서)
            -- 그래서 ORDER BY를 써서 bno로 조건을 걸어주었음.
            -- 그런데 문제는 실행계획으로 확인했을때 옵션에 'full'이라고 나옴 (풀로 스캔을 한다는 것) (오더 바이가 코스트(=자원)을 또 잡아먹음)
                -- 1번부터 끝 번까지 다 조회 -> 그 다음 하나하나 순서를 맞추는 것
                
        -- 그래서 위의 스캔 구문을 사용했더니(힌트 사용한)
            -- 스캔을 풀로 들어가도 자원을 거의 잡아먹지 않는 것을 볼 수 있다.
            
        -- rowid를 저장할때
            -- rowid는 순차적으로 저장
            -- bno는 메모리 주소가 아니고 그냥 부여된 번호지만, rowid는 저장된 데이터의 순번이어서 시작과 끝번호만 알면 순서대로 쫙 세울 수 있는 것.
            -- bno 같은 경우는 빈 번호가 있을 수 있지만, rowid는 메모리에 순서대로 저장함 (rowid 끝번호 보면 알 수 있음)
            
   
    
-- rownum이 정해진 것이 아니라는 것을 보여주기 위해서 다른 구문 사용해봄(11:46~)
    -- (해석) 아까는 rownum 1번이었던 196625가 이번에는 rownum이 11이 됨
SELECT
/*+ INDEX_ASC(board_tbl pk_board) */
rownum, rowid, board_tbl.* FROM board_tbl WHERE bno BETWEEN 196615 AND 196625;



-- (결론) rownum으로 페이징처리를 하고, rowid로 정렬을 함 
    -- rowid : 메모리 영역에서 바로 스캔
    -- bno : 메모리 영역에서 전체 숫자를 다 받아와서 하나하나 순서대로 나열하는 것
    
    
    
    
    
-- rownum을 이용해 페이지네이션 구문 작성하기 (02:17~
    -- rowid는 조회를 할 필요가 없음(정렬만 하면 되기 때문에)
    -- 1~20개의 글이 조회됨
    -- rownum rn이라는 명칭으로 바꾸면 박제가 된다(02:23~
SELECT 
/*+ INDEX_DESC(board_tbl pk_board)*/
rownum rn, board_tbl.* FROM board_tbl WHERE rownum <= 20;



-- 안쪽과 바깥쪽의 rownum이 겹치면 결과가 안나옴. 그래서 안쪽의 rownum에는 rn이라는 이름을 붙여지는 것
SELECT * FROM
(SELECT /*+ INDEX_DESC(board_tbl pk_board) */
rownum, board_tbl.* FROM board_tbl WHERE rownum <=20)
WHERE rownum >10;


-- 그래서 바꾸면 이렇게 됨 (최종)
SELECT * FROM
(SELECT /*+ INDEX_DESC(board_tbl pk_board) */
rownum rn, board_tbl.* FROM board_tbl WHERE rownum <=20)
WHERE rn >10;




