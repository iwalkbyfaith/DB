use ict_practice;

/*
ORDER BY는 결과물의 개수나 종류에는 영향을 미치지 않지만
결과물을 순서대로(오름차순, 내림차순) 정렬하는 기능을 가집니다.
SELECT 컬럼명 FROM 테이블명 ORDER BY 기준컬럼 정렬기준;
	정렬기준 : ASC(오름차순), DESC(내림차순)
			 입력이 따로 없는 경우는 기본을 ASC로 잡습니다.
*/

	-- 가입한 순서(reg_date)순으로 오름차순 조회를 해보겠습니다.
		SELECT * FROM userTbl ORDER BY reg_date ASC;
    -- 내림차순으로도 해보자.
		SELECT * FROM userTbl ORDER BY reg_date DESC;
	-- 키 작은 순으로 나열해주세요.
		SELECT * FROM userTbl ORDER BY height;
        
	-- 정렬시 동점인 부분을 처리하기 위해 ORDER BY 절을 두 개 이상 동시에 나열할 수도 있습니다.
	-- 아래 코드는 키로 오름차순을 하되, 동점이면 생년 내림차순으로 나열합니다.
		SELECT * FROM usertbl ORDER BY height ASC, birth_year DESC;
	
    -- 만약 문자라면 아스키코드 순으로 ORDER BY 정렬이 들어갑니다.
    -- user_name으로 ORDER BY를 걸어보세요.
		SELECT * FROM usertbl ORDER BY user_name ASC;
	
    -- 지역 가나다라 역순으로 나열해주시되, 만약 지역이 같다면 이름 오름차순으로 정렬해주세요.
		SELECT * FROM userTbl ORDER BY addr DESC, user_name ASC;
        

/*
DISTINCT는 결과물로 나온 컬럼의 중복값을 다 제거하고 고유값만 남겨줍니다.
*/

	-- 아래 코드는 지역 종류 9개(데이터 개수는 12개)를 파악하기 어렵습니다.
		SELECT addr FROM usertbl;
	
    -- 지역이 몇 개인지 알고 싶다면?
    -- 중복값을 하나로 출력하기 위해 출력컬럼 앞에 distinct를 붙입니다.
		SELECT DISTINCT addr FROM usertbl;
        
-- ---------------------------------------------------------------------

-- employees 스키마로 지정
	use employees;


/*
출력 요소의 개수를 제한할 때는 limit 구문을 사용합니다.
데이터가 17만개에 가깝다보니, 모든 데이터를 보여주지 않고 1000개만 보여주도록 설정되어 있음.
*/
	SELECT * FROM employees;
		-- 컨트롤 + 엔터를 치면 Action Output에서 LIMIT 0,1000 이라고 적혀있음. => 자동으로 1000개만 보여준다는 것.
    
    -- 테이블명 뒤에 limit 숫자; 가 오는 경우는 적은 숫자 개수만큼만 결과창에 보여줍니다.
    
    -- 숫자를 하나만 적으면 자동으로 0번 자료부터 n개를 보여줍니다.
		SELECT * FROM employees limit 10;
    
		-- 일정 데이터셋을 먼저 얻어놓고 그 내부적으로 정렬시킬때는 서브쿼리를 씁니다. (이건 지금 할 수준은 아님. 몰라도.. 돼..)
			SELECT * FROM (SELECT * FROM employees limit 10) e ORDER BY hire_date DESC;
			-- 우리가 원하는 것은 밑에 구문(70번)이 아니라 57번 코드에서 정렬을 하는 것.
				-- 서브쿼리는 소괄호 안에 있는 것을 먼저 실행한다고 어제 배웠음. 따라서
				-- 순서1) (괄호 안 코드) 먼저 실행 => 10줄이 미리 박제됨.
                -- 순서2) SELECT * FROM (10줄) => 10줄에 대해서 조회하는 구문이 된다.
                -- 순서3) 그러면 테이블명이 없게 되기 때문에 임시로 'e'라는 명칭을 붙여주는 것 (10줄 때문에 영역 명칭이 없기 때문에)
							-- employees의 e자로 임의로 배정한 것(= 아무거나 상관 없다)
                -- 순서4) 10개짜리 데이터에 대해서 hire_date를 기준으로 DESC 해줌.			
    
    -- limit는 ODER BY와 결합해 쓸 수 있습니다.
		SELECT * FROM employees ORDER BY hire_date DESC limit 10;
		-- 순서1) 17만개의 데이터를 날짜순으로 정렬
        -- 순서2) 정렬된 17만개 중에 상위 10개만 뽑는 것
        -- 따라서 emp_no가 자유분방한 것임 (hire_date 기준으로 정렬된 것이니까)
    
    -- 만약 limit 숫자1, 숫자2; 와 같이 숫자 두 개를 넣는 경우 숫자 1번부터 숫자 2에 기입한 갯수만큼 보여줍니다.
		SELECT * FROM employees limit 5, 10;
        -- (인덱스 5번 = 10006) ~ (인덱스 14번 = 10015)
        
        SELECT * FROM employees limit 9, 20;
		-- (인덱스 9번 = 10010) ~ (인덱스 28번 = 10029)
 
 
/*
GROUP BY는 같은 데이터를 하나의 그룹으로 묶어줍니다.
조건절은 WHERE 대신에 HAVING절로 처리하게 됩니다.
*/
	
    -- DB변경
		use ict_practice;
    
    -- 하기 데이터에서 각 인물별로 구매한 개수 총합을 구해보겠습니다.
		SELECT user_id, amount FROM buytbl ORDER BY user_id ASC;              -- 이것과
        -- 같은 아이디라도 각각 나옴
	-- SELECT 컬럼명, 집계함수(컬럼명2) ... FROM 테이블명 GROUP BY 묶을컬럼명;
		SELECT user_id, sum(amount) FROM buyTbl GROUP BY user_id;         -- 이것을 컨트롤 엔터 쳐서 뭐가 변했는지 비교해보쟝
			-- GROUP BY user_id = 같은 애들끼리 하나로 묶겠다. => 아이디별로 집계가 가능해짐.
	
    
    -- 문제
		-- 각 유저별 총 구매액을 구해주세요.
        -- 총 구매액은 가격*개수의 결과를 다 더한 것입니다.
        -- 가격은 price 컬럼에, 개수는 amount 컬럼에 있습니다.
        -- 집계함수 sum()의 소괄호 사이에서 +, * 등의 연산을 할 수 있습니다.
        SELECT user_id, sum(price * amount) as 'total' FROM buytbl GROUP BY user_id;
        
        SELECT * FROM buytbl;
    
		-- 각 유저별 구매 물품의 평균가를 구해보세요(총액 아님) 평균은 avg()로 처리합니다.
		-- avg() 컬럼은 명칭을 '평균가'로 고쳐보세요.
        SELECT user_id, avg(price) as '평균가' FROM buytbl GROUP BY user_id;


/*
자주쓰는 집계 함수 정리
AVG() 			평균
MIN() 			최소값
MAX()			최대값
COUNT() 		row 개수
COUNT(DISTINCT) 종류 개수
STDEV() 		표준편차
VAR_SAMP() 		분산	   
*/

	-- 편차 : 평균과 얼마나 떨어져 있는지(음수, 양수)
	-- 분산 : 편차의 제곱을 다 더해서 평균을 낸 것  ex) 8
	-- 표준편차 : 분산의 제곱근(=분산에 루트 씌운 것) ex) 루트 8
	-- 평균이 174.4이고 표준편차가 5.75라면 실제적으로는 10개중 7개는 168.9 ~ 180.9 사이에 있을거다 (캡쳐 참고)

	-- 예시
		SELECT COUNT(*) FROM employees.employees; -- 결과값: 300024개의 데이터가 있음


	-- usertbl에서 키가 제일 큰 회원의 이름과 키를 화면에 표시해주세요.
		SELECT user_name, max(height) FROM usertbl;
			-- 결과창 : 압둘라, 184 => 불일치
		SELECT user_name, height FROM usertbl WHERE height = (SELECT max(height) FROM usertbl);
			-- 결과창 : 스프링, 184 => 일치
            
	-- usertbl에서 가장 키가 작은 회원을 찾아주세요.
		SELECT user_name, height FROM usertbl WHERE height = (SELECT min(height) FROM usertbl);

    -- usertbl 사용자 전체 키 평균을 구해주세요
		SELECT AVG(height) as '전체 키 평균' FROM usertbl;
        
        SELECT * FROM usertbl;
        
        

/*
기존 쿼리문에서의 조건절은 WHERE절을 이용해서 처리했었습니다.
하지만 GROUP BY를 통해 집계하는 경우, WHERE절을 받을 수가 없습니다.
대신 조건절을 HAVING이라는 구문으로 대체해 사용합니다.
WHERE절과 사용법은 완전히 동일합니다.

===> GROUP BY + WHERE   (X)
===> GROUP BY + HAVING  (O)
*/
    
	-- 사용자별 총 구매액을 다시 구해보겠습니다. (buytbl)
    -- sum(price * amount)를 활용해서 작성해주세요.
		SELECT user_id, sum(price * amount) as 'total' FROM buytbl GROUP BY user_id;
	
    -- 구매액이 25만원을 넘는 사람만 남겨보겠습니다.
	-- WHERE처럼 사용하시되 HAVING 이라고 적어서 조건식을 붙여보세요.
		SELECT user_id, sum(price * amount) as 'total' FROM buytbl GROUP BY user_id HAVING sum(price * amount) > 250000;
        
        
	-- 키가 평균보다 큰 사람들만 화면에 출력해주세요(userTbl)
		SELECT user_id, height FROM usertbl GROUP BY user_id HAVING height > (SELECT avg(height) FROM userTbl);
	
    -- 키가 평균보다 큰 지역만 화면에 출력해주세요(userTbl)
		SELECT addr, avg(height) FROM usertbl GROUP BY addr HAVING avg(height) > (SELECT avg(height) FROM userTbl);
			-- 아래는 내가 생각하는 순서임
            -- 순서1) 유저 테이블을 지역끼리 묶고                   (FROM usertbl GROUP BY addr)
            -- 순서2) '지역별 키 평균'이 '모든 지역 키 평균'보다 크다면  (HAVING avg(height) > (SELECT avg(height) FROM userTbl))
            -- 순서3) 지역 이름과 지역별 키 평균을 출력 		       (SELECT addr, avg(height))
    
    
    
/*
SQL구문의 분류

DDL(Data Definitin Language)
 - 데이터 정의 언어
 - 데이터베이스, 테이블, 뷰, 인덱스 등을 생성하고 삭제하는 구문
 - CREATE(생성), DROP(삭제), ALTER(수정)
 - DML과 달리 commit; 없이도 바로바로 서버에 반영된다.
 
 
DML(Data Manipulation Language)
 - 데이터 조작 언어
 - SELECT, INSERT, UPDATE, DELETE
 - 테이블의 데이터를 조회하거나 변경하기 위해서 사용한다.
 

DCL(Date Control Language)
 - 데이터 제어 언어
 - 특정 계정에 대한 권한을 부여하거나 뺏을 때 사용한다.
 - GRANT(권한부여), REVOKE(권한부여뺏기), DENY
    
*/


	-- 테이블 생성하기
    -- 테이블명 : tsttbl1 (id int, user_name varchar(3), age int)
		CREATE TABLE tsttbl1(
			id INT,
            user_name VARCHAR(3),
            age INT
        );
        
	-- 테이블명 뒤에 컬럼 정보를 적지 않으면, CREATE TABLE시 설정한 컬럼 정보가 순서대로 대입됩니다(id, user_name, age순으로)
    
    -- 데이터 적재
		INSERT INTO tsttbl1 VALUES(1, '홍길동', 25);
    
    -- id와 이름쪽에만 데이터를 넣을 때에는 컬럼을 생략할 수 없습니다.
		INSERT INTO tsttbl1(id, user_name) VALUES (2, '김길동');
        
	-- 만약 컬럼명 지정을 안했지만 age에는 null을 넣고 싶다면
		INSERT INTO tsttbl1 VALUES (3, '이호영', null);
    
    -- 만약 입력하는 컬럼(열)의 순서를 바꿔서 지정하는 경우는 (id, user_name, age가 아닌 순으로 넣음)
    -- 모든 컬럼에 값을 입력하는 상황이어도 컬럼명을 따로 기입해야 합니다.
		INSERT INTO tsttbl1 (user_name, age, id) VALUES ('채종훈', 10, 4);
        

    SELECT * FROM tsttbl1;
    