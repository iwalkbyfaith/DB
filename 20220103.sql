-- 스키마 지정
	use ict_practice;

-- 유저 테이블 조회
	SELECT * FROM userTbl;


-- 유저 테이블에 두명만 더 추가 (한명은 키 =160으로)
	INSERT INTO userTbl VALUES ('idd', '아이디', 1507, '주소주소', '01012311231', 160, '2021-03-02');
	INSERT INTO userTbl VALUES ('iddd', '아이디디', 1507, '주소', '01012311232', 167, '2021-03-02');

-- 구매 테이블에 새로 추가한 2명의 구매내역을 추가해주세요. (3개)
	INSERT INTO buyTbl VALUES(null, 'idd', '고양이사료', '사료', 25000, 1);
    INSERT INTO buyTbl VALUES(null, 'idd', '고양이방석', '애완', 5000, 3);
    INSERT INTO buyTbl VALUES(null, 'iddd', '코코볼', '시리얼', 7000, 2);
    
    -- order_number를 빼기 위해 컬럼명들을 적어줘도 됨.
		INSERT INTO buyTbl(user_id, prod_name, group_name, price, amount) 
			VALUES ('iddd', '게임용마우스', '전자기기', 20000, 1);
    
-- 구매 테이블 조회
	SELECT * FROM buyTbl;
    
    

/* 
여태까지의 SELECT 구문은 조건 없이 모든 데이터를 다 조회했습니다.
극단적인 경우 employees 테이블의 모든 row를 조회하다보니 조회 시간이 굉장히 오래 잡히는 케이스가 발생했습니다.
따라서 조건에 맞도록 필터링을 할 수 있고, 이를 위해 사용하는 구문은 WHERE 구문입니다.
SELECT 컬럼명1, 컬럼명2 ... FROM 테이블명 WHERE 컬럼명 = 조건식;
*/

-- 아래는 이름이 손흥민인 사람만 조회하는 구문입니다.
	SELECT * FROM userTbl WHERE user_name = '손흥민';

-- 서울에 사는 사람만 조회해보세요. (없어서 삼척 넣음)
	SELECT * FROM userTbl WHERE addr = '삼척';
    
    
    
	-- 관계연산자를 이용해서 대소 비교를 하거나
	-- and, or을 이용해 조건 여러개를 연결할 수 있습니다.
		-- 정수, 실수가 있으면 실수는 안 쓰려고 하는 경향이 있음.(실수는 정확한 숫자가 아니니까). 필요할때만.

	-- 키 180이상인 사람만 조회해주세요
		SELECT * FROM userTbl WHERE height >= 180;
        
	-- AND를 이용해 91 ~ 99년생까지만 조회하는 구문을 만들어보세요.
		-- 방법 1)
		SELECT * FROM userTbl WHERE (birth_year >= 1991) AND (birth_year <= 1999);
        SELECT * FROM userTbl WHERE (1991 <= birth_year) AND (birth_year <= 1999);
			-- 이렇게 써도 됨. (선생님은 이렇게 쓰심)
        -- 아무것도 안 나와서 나한테 있는 데이터에 맞는 자료 조건으로 만들어봄.
		SELECT * FROM userTbl WHERE (birth_year >= 2019) AND (birth_year <= 2021);
        -- 근데 파이썬은 이렇게하는게 대소비교 허용됨 => 1991 <= birth_year <= 1999
			-- 조건식에 괄호를 이용하면 가독성이 좋음.
            
		-- 더 간단하게 구현할 수도 있음.
		-- 방법 2)
    -- BETWEEN ~ AND 구문을 이용하면 birth_year를 한 번만 적고도 해당 범위 조회가 가능합니다.
		SELECT * FROM userTbl WHERE birth_year BETWEEN 2019 AND 2021;
        
	-- 위와 같이 숫자는 연속된 범위를 갖기 때문에 범위 연산자로 처리가 가능하지만
    -- addr 같은 자료는 서울이 크다던가 영국이 작다던가 하는 연산적 처리가 불가능합니다.
    -- 먼저 지역이 서울이거나 혹은 화성인 사람의 정보를 WHERE절로 조회해주세요.
		SELECT * FROM userTbl WHERE (addr = '서울') or (addr = '화성');
		SELECT * FROM userTbl WHERE (addr = '삼척') or (addr = '주소');

	-- in 키워드를 사용하면, 컬럼명 in(데이터1, 2, 3, 4 ...);
    -- 특정 컬럼에 괄호에 담긴 데이터가 포함되는 경우를 전부 출력합니다.
    -- 경기, 화성, 영국에 있는 사람들만 in 키워드로 조회해주세요.
		SELECT * FROM userTbl WHERE addr in('경기', '화성', '영국');
        SELECT * FROM userTbl WHERE addr in('삼척', '주소', '주소주소');
        
        SELECT * FROM userTbl WHERE height in(180, 183);
        -- in 키워드는 나중에 파이썬에도 사용하니 잘 기억해두자.
	
    -- like 연산자는 일종의 표현 양식을 만들어줍니다.
    -- like 연산자를 이용하면 %라고 불리는 와일드 카드나, 혹은 _라고 불리는 와일드 카드 문자를 이용해 매칭되는 문자나 문자열을 찾습니다.
		-- 채씨를 찾는 케이스 (%는 뒤에 몇 글자가 오더라도 상관 없음.)
			-- 아래 구문은 채로 시작하는 모든 요소를 다 가져옵니다. '채'도 포함
			SELECT * FROM usertbl WHERE user_name like '채%';
            SELECT * FROM usertbl WHERE user_name like '아%';

		-- 휴대폰 번호가 01로 시작하는 모든 사람을 찾아보세요.
			SELECT * FROM usertbl WHERE phone_number like '01%';
            SELECT * FROM usertbl WHERE phone_number like '01012%';
            
		-- 두 글자만 찾는 케이스(_는 하나에 한 글자임)
			SELECT * FROM usertbl WHERE user_name like '__';   -- 두글자인 사람만 나옴.
            SELECT * FROM usertbl WHERE user_name like '미_';
		
        -- 유저 아이디가 세글자이면서 H로 끝나는 사람만 조회해보세요.
			SELECT * FROM usertbl WHERE user_id like '__H';
            SELECT * FROM usertbl WHERE user_id like '__d';
            
	SELECT * FROM userTbl;


/*
서브쿼리(하위쿼리)란 1차적 결과를 얻어 놓고, 거기서 다시 조회구문을 중첩해서 날리는 것을 의미합니다.
*/

-- 손흥민보다 키가 큰 사람을 조회하는 예시를 보겠습니다.
	-- 원시적인 방법 (매번 쿼리문의 값을 고쳐야하기 때문에 불편.)
		-- 1. 손흥민의 키를 WHERE 절을 이용해 확인한다.
        SELECT height FROM userTbl WHERE user_name = '손흥민';
        -- 2. 확인한 손흥민의 키를 커리문에 넣는다. 175보다 큰 사람의 이름과 키만 조회.
        SELECT user_name, height FROM userTbl WHERE height > 175;
        
	-- 서브쿼리 활용 방법
    -- 서브 쿼리는 WHERE절 다음에 ()를 이용해서 SELECT 구문을 한 번 더 활용합니다.
	-- 구문 : SELECT user_name, height FROM userTble WHERE height > '조회하는 사람의 키';
    SELECT user_name, height FROM userTbl WHERE height > (SELECT height FROM userTbl WHERE user_name = '손흥민');
		-- 105번의 내용(손흥민의 키가 나오는 구문)을 '조회하는 사람의 키' 부분에 넣어주면 됨.
        -- 괄호 안의 우선순위가 먼저이기 때문에 
			-- 1) 손흥민의 키 = 175 가 (괄호) 안에 남음. => (175)
            -- 2) 결과적으로 SELECT user_name, height FROM userTbl WHERE height > 175; 라는 구문이 됨.
            -- 3) 175보다 키가 큰 유저의 이름과 키를 유저테이블에서 조회하는 구문이기 때문에 => 결과 값 :엘론, 180
        
	
    -- 내가 만드는 예제. 미미(2019년생)보다 더 늦게 태어난 유저의 이름, 출생년도를 조회하는 테이블
		-- 나와야하는 결과값 : 퐁구, 2021
    SELECT user_name, birth_year FROM userTbl WHERE birth_year > (SELECT birth_year FROM userTbl WHERE user_name = '미미');

	-- 서브쿼리를 활용해 '엘론'(1950)보다 먼저 태어난 사람들만 골라내보세요.
    SELECT user_name, birth_year FROM userTbl WHERE birth_year < (SELECT birth_year FROM userTbl WHERE user_name = '엘론');
    

-- 최대값은 max()로 구합니다.
-- 현재 usertbl 컬럼에서 가장 나이가 적은 사람의 생년 조회
	SELECT max(birth_year) FROM userTbl;
    
   -- 유저 아이디에 M이 포함된 사람들 중 키가 제일 작은 사람보다, 키가 더 큰 사람을 구하시오. (min 사용)
		-- M이 포함된 사람들 중 키가 제일 작은 사람 : 미미, 20cm
			SELECT min(height) FROM userTbl WHERE user_id like '%M%';
        -- 미미보다 키가 더 큰 사람 : EM, idd, iddd, SHM
			SELECT user_id, user_name, height FROM userTbl WHERE height > (SELECT min(height) FROM userTbl WHERE user_id like '%M%');
				-- 게시판에서 글 검색할때 로직에서 %M% 이런거 많이 씀.
                
	-- 3중 쿼리
		-- 2021년 가입자 중, 가입일이 제일 빠른 사람보다 키가 큰 사람을 조회해주세요.
        -- 날짜도 부등호로 조회 가능합니다. (작다: 이전날짜, 크다: 이후날짜)
        
        -- 1. 2021년 가입자중, 가장 가입일이 빠른 사람
			SELECT min(reg_date) FROM userTbl WHERE reg_date >= '2021-01-01';
				-- 원래는 WHERE 뒤에 2022년보다 작다고 하는 구문 넣어야 함.
		-- 2. 1의 쿼리문을 조건으로 해서 가입일이 제일 빠른 사람의 키 구하기
			SELECT height FROM userTbl WHERE reg_date = (SELECT min(reg_date) FROM userTbl WHERE reg_date >= '2021-01-01') ;
		-- 3. 2에서 구한 키를 조건으로 해서 최종적인 명단을 얻어냄
			SELECT * FROM usertbl WHERE height > (SELECT height FROM userTbl WHERE reg_date = (SELECT min(reg_date) FROM userTbl WHERE reg_date >= '2021-01-01'));
           
           
        -- 먼저 구하는 것은 역순으로 해야.   
		-- 1. 키가 더 큰 사람들 > 입력된 키
        -- 2. 가입일이 가장 빠른 사람의 키
        -- 3. 2021년 중, 가입일이 제일 빠른 것.
        
        
    -- 유저를 다섯 명 더 추가하겠습니다.    
	INSERT INTO userTbl VALUES ('KJV', '김자바', 1983, '서울', '01012341239', 171, '2020-08-15');
	INSERT INTO userTbl VALUES ('ADR', '압둘라', 1995, '경기', '01012341239', 183, '2021-04-01');
	INSERT INTO userTbl VALUES ('YSO', '야스오', 2001, '부산', '01012341239', 165, '2021-10-08');
	INSERT INTO userTbl VALUES ('ZYA', '장위안', 1985, '부산', '01012341239', 164, '2020-02-28');
	INSERT INTO userTbl VALUES ('SPR', '스프링', 1987, '강원', '01012341239', 184, '2021-12-31');
 	INSERT INTO userTbl VALUES ('JSP', '쟈스피', 1989, '전라', '01012341239', 177, '2022-01-01');       
   
   
   
   
   -- ANY, ALL, SOME 구문은 서브쿼리와 조합해서 사용합니다.
		-- SOME은 ANY랑 결과가 똑같음
   -- 지역이 서울인 사람보다 키가 작은 사람을 찾는 쿼리문
   
   -- 1. 지역이 서울인 사람들의 전체 키 리스트 (min, max 없이 써봄)
		SELECT height FROM usertbl WHERE addr = '서울';
   -- 2. 위 구문을 서브쿼리로 해서 서울 사람보다 키가 작은 사람을 찾을 경우 에러가 납니다.
		SELECT * FROM usertbl WHERE height < (SELECT height FROM usertbl WHERE addr = '서울');  
			-- 에러가 뜸.(나는 1명이라서 안뜨는데 선생님은 1번 답이 3개가 나와서 에러뜨시는 것)
            -- 현재 데이터셋은 결과가 169, 171, 186 3개인데, 어느 데이터를 기반으로 height을 조건에 잡아줄지 모호하기 떄문에 에러가 납니다.
   -- 3. ANY 구문 사용.
		SELECT * FROM usertbl WHERE height < ANY(SELECT height FROM usertbl WHERE addr = '서울');  
   
-- ANY 구문을 사용하면 169, 171, 186 모든 데이터에 대해 OR로 처리가 됩니다.
	-- 개별 값 모두에 대해 or 처리가 붙고, 그래서 아래와 같이
	-- (height < 169) or (height < 171) or (height <186) => 3개 조건이 or로 연결이 됩니다.
		-- 만약 키가 175라면 169, 171보다는 크지만 186보다는 작으므로 만족. ==> 가장 큰 범위를 가진 값을 기준으로 보면 됨. 여기서는 height<186
	-- ★ ANY는 OR로 연결된다는 특성상 범위가 가장 넒은 조건 하나로 통일됩니다.(or로 연결된 조건 중 하나만 만족하면 되기 때문에)
    -- 따라서 현재 코드에서는 186보다 작은 데이터는 전부 잡혀 나옵니다.
    -- ANY와 SOME은 사실상 차이가 없는 구문으로 보셔도 무방합니다.
		-- 아래 ANY 자리에 SOME을 대신 넣어도 똑같이 작동합니다.
    
-- ALL 구문을 사용하면 169, 171, 186 모든 데이터에 대해 AND로 처리 됩니다.
	-- 개별 값 모두에 대해 and 처리가 붙고, 그래서 아래와 같이
    -- (height < 169) and (height < 171) and (height <186)
    -- 3개의 조건이 AND로 연결됩니다.
    -- 현재 코드에서 몇 보다 작은 숫자가 다 잡혀 나오는지 적어주세요. => 169보다 작은 값만 트루.
		SELECT * FROM usertbl WHERE height < ALL(SELECT height FROM usertbl WHERE addr = '서울');  
   
   
   -- 다시 한번 해보기
   -- 2021년 가입자 중, 가입일이 제일 빠른 사람보다 키가 큰 사람을 조회해주세요.
        -- 날짜도 부등호로 조회 가능합니다. (작다: 이전날짜, 크다: 이후날짜)
	
		-- 1. 키가 큰 사람 > 키
        -- 2. 제일 빠른 가입일을 가진 사람의 키
        -- 3. 2021년 가입자 중 제일 빠른 가입일
        
        SELECT min(reg_date) FROM userTbl WHERE reg_date >= '2021-01-01';
        SELECT min(height) FROM userTbl WHERE reg_date = (SELECT min(reg_date) FROM userTbl WHERE reg_date >= '2021-01-01');
        SELECT * FROM userTbl WHERE height > (SELECT min(height) FROM userTbl WHERE reg_date = (SELECT min(reg_date) FROM userTbl WHERE reg_date >= '2021-01-01'));