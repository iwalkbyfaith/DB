use ict_practice;

SELECT * FROM tsttbl1;

-- 지금 tsttbl1 같은 경우 id를 수동으로 입력해주고 있습니다.
-- 이 경우 id값을 사용자가 계산해서 insert 해야하기 때문에 굉장히 불편한데
-- auto_increment 속성을 컬럼에 걸어주면, 데이터를 입력받지 못한다면 컴퓨터가 순차적으로 컬럼에 중복되지 않고 증가하는 숫자를 자동으로 입력해줍니다.


-- 새롭게 만들어보자
-- 테이블명: testtbl2
-- id 정수 AUTO_INCREMENT PRIMARY KEY
-- user_name VARCHAR(3)
-- age 정수

	CREATE TABLE testtbl2(
		id INT AUTO_INCREMENT PRIMARY KEY,
		user_name VARCHAR(3),
		age INT
	);

-- 데이터 조회
	SELECT * FROM testtbl2;

	
-- id 컬럼에는 AUTO_INCREMENT가 붙어 있으므로 null 처리해도 자동으로 1부터 1씩 증가하며 들어갑니다.
	INSERT INTO testtbl2 VALUES(null, '알파카', 4);
    INSERT INTO testtbl2 VALUES(null, '에뮤', 2);
    INSERT INTO testtbl2 VALUES(null, '토끼', 1);
    
    -- 현재 3개의 데이터가 들어갔으므로 AUTO_INCREMENT의 값은 4 입니다.
   
   
/*   
AUTO_INCREMENT의 기준값은 1부터 1씩 자동 증가하지만,
만약에 사용자가 임시로 값을 바꾸고 싶다면 ALTER TABLE을 이용해 AUTO_INCREMENT의 값을 수정할 수도 있습니다.
*/	

    -- AUTO_INCREMENT의 현재 값을 1000으로 수정하는 구문
		ALTER TABLE testtbl2 AUTO_INCREMENT = 1000;
		-- 데이터를 추가해봅시다
        INSERT INTO testtbl2 VALUES (null, '반달곰', 10);
        INSERT INTO testtbl2 VALUES (null, '산양', 3);
			-- 결과값 : 1000	반달곰  10
            --        1001	산양	   3
	
    -- CMD(커맨드라인)에서 testtbl2컬럼에 데이터를 3개 더 입력해주세요.
    -- 커맨드라인에서 조회까지 마쳐주세요.
		-- CMD에서 추가한 데이터들이 워크벤치에도 반영된다.
	
    
    
    -- AUTO_INCREMNET는 기본적으로 1씩 증가하는데,
    -- 이 증가분을 수정하고 싶다면 서버측 변수인 @@auto_increment_increment를 바꿔야합니다.
    
		-- testtbl2와 모든 조건이 같고 이름만 testtbl3인 테이블을 하나 더 만들어주세요.
			CREATE TABLE testtbl3(
				id INT AUTO_INCREMENT PRIMARY KEY,
				user_name VARCHAR(3),
				age INT
			);
		
		-- testtbl3의 초기 AUTO_INCREMNET의 값을 1500으로 고쳐보세요.
			ALTER TABLE testtbl3 AUTO_INCREMENT = 1500;
            
		-- 증가분을 1이 아닌 3으로 세팅하는 법
			SET @@auto_increment_increment = 3;
            -- MySQL 프로그램이 전체적으로 영향을 받는다. (특정 테이블을 대상으로 하는게 아니기 때문)
            -- 굳이 다른 값으로 바꿀 일은 없음 (이런 기능이 있다는 것만 알아두기)
            -- 변경 후, 첫 추가는 마지막으로 적용된 값으로 증가하고 두번째 추가부터 변경값이 적용된다.(정확한건 아닌데 정황상 그럼)
            
		-- 동물 3마리를 testtbl3에 추가해보세요
			INSERT INTO testtbl3 VALUES (null, '닭', 1);
            INSERT INTO testtbl3 VALUES (null, '매', 13);
            INSERT INTO testtbl3 VALUES (null, '삵', 6);
            /* 결과값
				1501	닭	1
			    1504	매	13
				1507	삵	6
			*/
            
			SELECT * FROM testtbl3;
            
		-- testtbl2도 3씩 증가하는지 insert 해보자
			INSERT INTO testtbl2 VALUES (null, '양', 3);
			INSERT INTO testtbl2 VALUES (null, '닭', 4);
            SELECT * FROM testtbl2;
				/* 결과값
				1		알파카	4
				2		에뮤		2
				3		토끼		1
				1000	반달곰	10
				1001	산양		3
				1002	사자		4
				1003	꿩		1
				1004	뱀		8
				1006	양		3
				1009	닭		4
				*/
            
    
		-- 다시 증가량을 1로 돌려놓자
        SET @@auto_increment_increment = 1;
        
        -- 잘 됐는지 체크해보자 (CMD)에서. testtbl2에 추가
    
    
    
-- ★★ 하나의 INSERT INTO 구문으로 여러 row를 추가할때는 VALUES 뒤쪽을 연달아 작성합니다.
		INSERT INTO testtbl2 VALUES (null, '말', 4), (null, '오리', 1), (null, '닭', 2);
        SELECT * FROM testtbl2;
        

/*
UPDATE 구문은 기존에 입력되어 있는 값을 변경할 때 사용합니다.
WHERE 조건절을 걸지 않는다면, 컬럼 하나의 값을 전부 바꿉니다.
따라서 일반적으로는 무조건 조건절과 조합해서 사용합니다.
UPDATE 테이블명 SET 컬럼 1= 바꿀값1, 컬럼 2=바꿀값2...;
*/

	-- testtbl2의 user_name을 전부 '소'로 바꾸는 구문
		UPDATE testtbl2 SET user_name = '소';
        /* 결과창
			+------+-----------+------+
			| id   | user_name | age  |
			+------+-----------+------+
			|    1 | 소        |    4 |
			|    2 | 소        |    2 |
			|    3 | 소        |    1 |
			| 1000 | 소        |   10 |
			| 1001 | 소        |    3 |
			| 1002 | 소        |    4 |
			| 1003 | 소        |    1 |
			| 1004 | 소        |    8 |
			| 1006 | 소        |    3 |
			| 1009 | 소        |    4 |
			| 1012 | 소        |    3 |
			| 1013 | 소        |    3 |
			| 1014 | 소        |    4 |
			| 1015 | 소        |    1 |
			| 1016 | 소        |    2 |
			+------+-----------+------+
        */
        -- 실행하면 안됨. (저번에 배웠음) => 세이프 업데이트 모드가 걸려있기 때문.
        -- CMD에서 하면? 아묻따 그냥 바뀌어버린다 . . .
        
        -- 워크벤치에서 WHERE절 없이 수정하고 싶다면 safe_update모드를 해제해야한다.
			SET SQL_SAFE_UPDATES = 0;
		
        -- testtbl2의 user_name을 전부 '말'로 고쳐보세요.
			UPDATE testtbl2 SET user_name = '말';
			/* 결과창
            +------+-----------+------+
			| id   | user_name | age  |
			+------+-----------+------+
			|    1 | 말        |    4 |
			|    2 | 말        |    2 |
			|    3 | 말        |    1 |
			| 1000 | 말        |   10 |
			| 1001 | 말        |    3 |
			| 1002 | 말        |    4 |
			| 1003 | 말        |    1 |
			| 1004 | 말        |    8 |
			| 1006 | 말        |    3 |
			| 1009 | 말        |    4 |
			| 1012 | 말        |    3 |
			| 1013 | 말        |    3 |
			| 1014 | 말        |    4 |
			| 1015 | 말        |    1 |
			| 1016 | 말        |    2 |
			+------+-----------+------+
            */
		
	-- 특정 나이대의 user_name을 여러분들이 좋아하는 동물로 교체해주세요.
    -- WHERE절을 이용해 age를 필터링해주세요.
    -- 하나의 나이대만 우선 고쳐주세요.
		UPDATE testtbl2 SET user_name = '냐옹' WHERE age = 4;
        /* 결과창
			+------+-----------+------+
			| id   | user_name | age  |
			+------+-----------+------+
			|    1 | 냐옹    	   |    4 |
			|    2 | 말         |    2 |
			|    3 | 말         |    1 |
			| 1000 | 말         |   10 |
			| 1001 | 말         |    3 |
			| 1002 | 냐옹        |    4 |
			| 1003 | 말         |    1 |
			| 1004 | 말         |    8 |
			| 1006 | 말         |    3 |
			| 1009 | 냐옹        |    4 |
			| 1012 | 말         |    3 |
			| 1013 | 말         |    3 |
			| 1014 | 냐옹        |    4 |
			| 1015 | 말         |    1 |
			| 1016 | 말         |    2 |
			+------+-----------+------+
        */

	-- UPDATE 구문이 전체 컬럼에 적용될 수 있다는 것을 응용해 
    -- 특정 컬럼의 값을 일괄적으로 계산식에 따라 새로운 결과값으로 갱신하는 것도 가능합니다.
		-- 아래 코드는 나이를 2배한 결과물입니다.
			UPDATE testtbl2 SET age = age * 2;
            SELECT * FROM testtbl2;
		-- 다시 원래 나이로 돌려보세요.
			UPDATE testtbl2 SET age = age / 2;
		
	

/*
DELETE FROM 구문은 데이터를 삭제하는 구문입니다.

SELECT는 특정한 컬럼들만 조회하거나, 전체를 모두 조회하는 등의 경우의 수가 있었기 때문에
SELECT와 FROM 사이에 구체적인 컬럼명이나 *을 붙여서 전체 컬럼을 조회했습니다.

하지만 DELETE는 특정한 컬럼만 삭제하는 경우가 없고,
삭제 할거면 '전체 row'를 삭제하거나, 삭제를 안 해버리거나이기 때문에
DELETE 와 FROM 사이에 아무것도 적지 않습니다.
	==> DELETE * FROM (X)
	==> DELETE FROM   (O)

DELETE 역시 일반적으로는 WHERE절과 함께 사용합니다.
WHERE 없이 사용시 해당 테이블의 전체 데이터를 다 삭제합니다.

*/

	-- WHERE을 이용해서 id가 1에 해당하는 데이터만 삭제해보세요.
		DELETE FROM testtbl2 WHERE id = 1;
        SELECT * FROM testtbl2;
	
    -- limit를 사용하면 상위 n개만 삭제할 수도 있습니다.
    -- 검색 결과물 중 상위 2개만 삭제
		DELETE FROM testtbl2 limit 2;
	
    -- WHERE절 없이 삭제하면 테이블 내의 전체 데이터가 삭제
		DELETE FROM Testtbl2;
		/*CMD 창에서 확인해보면 이렇게 나옴
			mysql> SELECT * FROM testtbl2;
			Empty set (0.00 sec)
		*/

	-- DELETE FROM은 삭제할 때 시간이 조금 더 오래 걸리는 편인데,
    -- 그 이유는 트랜잭션 로그라는 것을 한 로우마다 작성하기 때문입니다.
    -- 따라서 속도를 끌어올리고 싶다면, TRUNCATE를 DELETE FROM 대신 쓰는 경우도 있습니다.
		TRUNCATE TABLE testtbl2;
        
		-- TRUNCATE와 DELETE FROM의 속도차이를 체험해보기 위해서 employees 테이블의 자료를 복사해보겠습니다.
			-- 먼저 테이블을 새로 만들고
				CREATE TABLE testtbl4(
					id INT,
					first_name VARCHAR(50),
					last_name VARCHAR(50)
				);
			-- 다른 스키마에서 데이터를 가져와서 testtbl4 테이블에 추가
				INSERT INTO testtbl4 (SELECT emp_no, first_name, last_name FROM employees.employees);
					-- 순서1) 30만줄 조회
                    -- 순서2) 1에서 조회된 데이터를 testtbl4에 복사해서 저장해줌.
                    -- 실행하면 Output의 Message창에 Running.. 적혀있고 몇 초 걸렸는지 뜸. 나는 1.688초
			-- 데이터가 제대로 들어왔는지 체크
				SELECT * FROM testtbl4;
			
            -- CMD에서 DELETE FROM으로 삭제 후 소요시간을 적어주세요.
				/* 결과창
					mysql> DELETE FROM testtbl4;
					Query OK, 300024 rows affected (1.30 sec)
				*/
			
            -- 다시 255를 실행해서 testtbl4 테이블에 데이터를 넣어줌
            
            -- CMD에서 TRUNCATE를 이용해 삭제 후 소요시간을 적어주세요.
				/* 결과창
					mysql> TRUNCATE TABLE testtbl4;
					Query OK, 0 rows affected (0.04 sec)
				*/

			/* 왜 속도에 차이가 나는지?
				DELETE FROM은
					1) 접속
                    2) 삭제
                    3) 접속 해제
                    을 한 줄, 한 줄씩 실행  => 접속 30만번, 삭제 30만번, 접속해제 30만번 => 총 90만번의 연산
					
                TRUNCATE
					1) 접속
                    2) 삭제 2) 삭제 2) 삭제 ... 2) 삭제 => 30만번
                    3) 접속 해제
                    
                    삭제는 자원을 별로 먹지 않고 접속과 접속 해제가 자원을 많이 잡아먹는데
					TRUNCATE는 접속과 접속 해제가 한 번씩 이루어지니까 시간이 절약되는 것.
                    트랜잭션 로그를 한 로우마다 작성하지 '않기' 때문에, 데이터를 복구하는 측면에서는 DELETE FROM 보다 불리함.
			*/ 
            
	

/*
조건부로 데이터 입력하기

예를들어 100개의 데이터를 입력하려고 하는데, 
첫 번째 자료만 기존 데이터의 id와 중복되는 값이 있고 이후 99건은 PK가 중복되지 않는다고 해도
SQL 시스템 상 전체 데이터가 입력되지 않는 문제가 발생합니다.

따라서 이 때 중복되는 데이터 1건은 중복된다면 무시하고, 이후 나머지 99개 데이터는 중단없이 정상적으로 입력하도록 만들 수 있습니다.
*/

	-- 테스트용 테이블 만들기
    -- 테이블명 membertbl
    -- user_id VARCHAR(6) PRIMARY KEY
    -- user_name VARCHAR(3) NOT NULL
    -- addr VARCHAR(3) NOT NULL
    
		CREATE TABLE membertbl (
			user_id VARCHAR(6) PRIMARY KEY,
			user_name VARCHAR(3) NOT NULL,
			addr VARCHAR(3) NOT NULL
		);
    
    
	-- MYSQL은 구문을 통째로 묶어서 실행할 경우, 모두 실행하거나 모두 실행하지 않습니다. (드래그 + 노란번개버튼)
		INSERT INTO membertbl VALUES ('LSH', '이상혁', '서울');
		INSERT INTO membertbl VALUES ('HS', '허수', '울산');
        INSERT INTO membertbl VALUES ('JJS', '정지훈', '인천');
		
        SELECT * FROM membertbl;
	
    -- 추가 데이터를 입력하되 한 건은 중복, 두 건은 중복 없도록 세팅
		INSERT INTO membertbl VALUES ('LSH', '이상혁', '서울');
        INSERT INTO membertbl VALUES ('KHK', '김혁규', '경기');
        INSERT INTO membertbl VALUES ('PDH', '박도현', '충정');
        -- 325~327을 드래그해서 왼쪽 위의 노란 번개버튼을 누르면 -> 한 번에 실행해주는 키 => 실행 안됨
        -- 왜? 이미 LSH가 있기 때문에 KHK와 PDH도 못들어가는 상황인 것.
	
    -- 만약 PRIMARY KEY가 겹치면 무시하고 그렇지 않으면 입력해주는 코드로 변환
	-- INSERT와 INTO 사이에 IGNORE를 추가해주면 된다.
		INSERT IGNORE INTO membertbl VALUES ('LSH', '이상혁', '서울');
        INSERT IGNORE INTO membertbl VALUES ('KHK', '김혁규', '경기');
        INSERT IGNORE INTO membertbl VALUES ('PDH', '박도현', '충정');
		-- 드래그해서 노란번개버튼을 눌렀더니
        -- LSH은 오류 발생 => 무시하고 넘어가고
        -- KHK, PDH는 정상적으로 데이터가 적재되었다.


	-- IGNORE는 기존 데이터를 유지하고 신규데이터를 막는 구문.
    -- Q) 이미 존재하는 데이터가 있어도 신규 데이터로 갱신해서 넣고 싶은 경우에는?
		INSERT INTO membertbl VALUES ('LSH', '이성혁', '제주');    -- 라는 데이터로 갱신하고 싶을 때
	-- A) ON DUPLICATE KEY UPDATE 구문을 쓰면 된다.
		INSERT INTO membertbl VALUES ('LSH', '이성혁', '제주')
			ON DUPLICATE KEY UPDATE user_name = '이성혁', addr = '제주';
            -- 기존에 데이터가 없으면 346에 있는 부분만 실행하고
			-- 이미 존재한다면 유저 네임은 '이성혁'으로, 주소는 '제주'로 갱신을 해줘라 라는 뜻
            -- 프라이머리키는 중복이 절대 되지 않음. LSH를 두 개로 만들 수는 없다.
	-- ON DUPLICATE KEY UPDATE는 자료가 없으면 INSERT INTO에 적힌대로 데이터를 넣고,
    -- 자료가 겹치는 상황인 경우에 ON DUPLICATE KEY UPDATE를 실행하는 구문이기 때문에
    -- 만약 데이터가 겹치지 않아도 잘 작동합니다.
    
		-- 기존 테이블 요소와 겹치지 않는 것을 넣어서 잘 들어가는지 CMD를 이용해 실행한 후 확인해주세요		
    
    
    
    
/*
사용자 관리하기

현재 root 계정은 모든 권한(수정, 삭제, 조회, 변경, 계정 생성 등)을 가지고 있는 계정입니다.

그렇지만 모든 사람이 모든 권한을 가지는 일은 그만큼 DB접근이 용이해져 위험을 내포하고 있으며,
작년 초에도 유명 게임사에서 DB를 날려먹는 사건이 발생한 만큼
일정 규모 이상의 개발사에서는 직급이나 권한 별로 DB 계정을 나눠서 관리합니다.
이제 root가 아닌 사용자를 만들고, 그 사용자에 대해서 권한부여를 하는 방법과 권한 개념에 대해 알아보겠습니다.

	-- 워크벤치에서 계정생성 및 권한 부여하기.
		1. 좌측의 navigator에서 administration 탭을 클릭합니다.
		2. Users and Privileges를 클릭합니다.
		3. 열리는 화면에서 좌하단 Add Account를 클릭한 다음 Login name, password 등을 입력합니다.
		4. 우하단 apply를 누르면 계정 생성이 완료 됩니다.
		5. Account Limit는 시간당 기능 사용 가능 횟수를 성정합니다.
		6. Administrative Roles는 어떤 구문 실행까지 허용할지입니다.
		
			아이디 ict
			비밀번호 ictICT03
		
	-- CMD 환경에서 생성하는 경우는
		CREATE USER 계정명(=아이디)@'%' IDENTIFIED BY '비밀번호';   ==> 생성
		GRANT ALL on *.* TO 계정명@'%' WITH GRANT OPTION;    	 ==> 권한 부여
		위 두 줄을 이용해서 생성할 수도 있습니다.
		
			아이디 ict2
			비밀번호 ictICT03

	-- 계정 접속 방법
		커맨드라인 접속시 mysql -u 계정명 -p로 연결 가능
		접속 후 show databases;를 이용해 DB목록 확인 가능
		use mysql;
		SELECT user, host FROM user; 를 할 경우 생성된 계정 목록 조회 가능.

	-- 계정 하나 더 만들기. icttest 계정. 권한은 따로 주지 마세요. (권한 줄 때는 root 계정으로 주어야함)
		
		아이디 icttest
		비밀번호 ictICT03

	-- 계정 권한 주기
		GRANT 권한1, 권한2 ... ON DB명.테이블명 TO 아이디@'%';
		ict_practice 데이터베이스의 testtbl3 테이블에 대한 SELECT, DELETE 권한만 가지도록 icttest 계정에 권한을 부여한다면
			문법 : GRANT <권한1, 권한2...> ON DB명.테이블명 TO 계정명@'%';
				=> GRANT SELECT, DELETE ON ict_practice.testtbl3 TO icttest@'%';
        
        
    -- 워크벤치에서 계정 권한 주기
		Navigator 하단 Adminstration에서 유저 선택 후 Administrative Roles에서 주고 싶은 권한을 체크
        DBA 선택시 모든 권한 획득(커멘드에서의 GRANT ALL on *.* TO 계정명@'%' WITH GRANT OPTION; 와 같은 것)
	

*/

	show databases; -- DB목록 조회
    SELECT user, host FROM user;
	
    -- 커맨드라인에서
    GRANT SELECT, DELETE ON ict_practice.testtbl3 TO icttest@'%';
		-- 했더니 SELECT는 되는데 INSERT INTO는 안됨. 당연함. 권한을 안 줬으니까.
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    