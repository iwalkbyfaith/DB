/* 
<권한 뺏기>

GRANT가 들어갈 자리에 REVOKE를 사용하면 됩니다.
단, REVOKE는 GRANT와 TO FROM과 연동해서 씁니다.

문법 : REVOKE 권한명... ON DB이름.테이블이름 FROM 계정명;
*/



/*
<조인(JOIN)>

테이블 두 개를 합쳐주는 기능.
연관된 데이터를 여러 테이블에 나눠 담았을때, 그 것을 다시 재조립 해줍니다.

문법 : SELECT 테이블1.컬럼1, 테이블1.컬럼2, 테이블2.컬럼1, 테이블2.컬럼2 ...
			FROM 테이블1 조인구문 테이블2
            ON 테이블1.공통컬럼 = 테이블2.공통컬럼;

(WHERE구문은 ON으로 합쳐진 결과 컬럼에 대한 필터링을 해줍니다.)

INNER JOIN		 		 = 양쪽 테이블 모두에 존재하는 데이터만 출력
LEFT OUTER JOIN 		 = 왼쪽 테이블 데이터는 매칭이 되건 말건 다 살림, 오른쪽 테이블 데이터는 왼쪽에 존재하는 것만 출력
RIGHT OUTER JOIN 		 = 오른쪽 테이블 데이터는 무조건 다 살림, 왼쪽 테이블은 오른쪽에 존재하는 것만.
FULL OUTER JOIN 		 = 양쪽 테이블 전부 살림(없는 데이터는 null)						


LEFT JOIN, LIGHT JOIN은 공통데이터가 아닌 데이터도 방향에 따라 출력이 되기 때문에
공통 데이터(INNER)가 아닌 데이터(OUTER)까지 출력되는 점을 이용해 OUTER JOIN이라고 부릅니다.

LEFT OUTER JOIN은 JOIN 구문의 왼쪽 테이블의 자료는 모두 출력하고, 오른쪽 테이블 데이터는 왼족 기준 컬럼과 일치할때만 출력합니다.
반대로 RIGHT OUTER JOIN은 join구문의 오른쪽 테이블의 자료는 전부 출력하고, 왼쪽 테이블 데이터는 오른쪽 테이블의 기준 컬럼과 일치할 때만 출력합니다.

FULL OUTER JOIN은 누락 데이터 없이 양쪽 테이블의 모든 자료를 보여줍니다.
ORACLE SQL에는 FULL JOIN을 구문으로 지원하지만
MYSQL에서는 FULL OUTER JOIN을 UNION 명령어를 이용해 LEFT OUTER JOIN과 RIGHT OUTER JOIN의 결과물을 합쳐서 구현합니다.
이 때 접점이 없는 데이터는 반대쪽 데이터를 NULL로 가집니다.
UNION은 위쪽 결과물과 아래쪽 결과물을 합쳐줍니다.

*/

	use ict_practice;
	SELECT * FROM buyTbl INNER JOIN userTbl ON buytbl.user_id = usertbl.user_id;
		-- FROM buyTbl INNER JOIN userTbl       => 구매테이블과 회원 테이블을 합친 것을 보고 싶은데
        -- ON buytbl.user_id = usertbl.user_id; => 구매테이블의 유저 아이디와 회원 테이블의 유저 아이디가 '같은' 경우'만' 합치고 싶다
        -- SELECT * 							=> 그 테이블의 모든 컬럼을 가져와서 조회하겠다.
        -- 구매 테이블에 존재하는 회원만 옆에 붙여넣기가 됨. (구매 안한 애들은 안나온다는 뜻. 또한 두 번 산 애들은 두 번 나옴)
        -- 제2 정규화 된 테이블들을 그 이전으로 돌려 놓는 구문이라고 생각할 수도 있다.
        -- *로 소환하는 경우는 INNER JOIN의 왼쪽, 오른쪽에 온 테이블 순서대로 Result Grid에 출력된다.
			-- 하지만 컬럼 이름을 직접적으로 적는 경우는 그 순서대로 함.
		/* CMD 에서도 해보자
        mysql> SELECT * FROM buytbl INNER JOIN usertbl ON buytbl.user_id = usertbl.user_id;
+--------------+---------+--------------+------------+--------+--------+---------+-----------+------------+----------+--------------+--------+------------+
| order_number | user_id | prod_name    | group_name | price  | amount | user_id | user_name | birth_year | addr     | phone_number | height | reg_date   |
+--------------+---------+--------------+------------+--------+--------+---------+-----------+------------+----------+--------------+--------+------------+
|            1 | mimi    | 기계식키보드 	| 주변기기     | 200000 |      1 | mimi    | 미미       |       2019 | 삼척      | 01012341234  |     20  | 2019-03-05 |
|            2 | mimi    | 듀얼모니터  	| 주변기기     | 200000 |      1 | mimi    | 미미       |       2019 | 삼척      | 01012341234  |     20  | 2019-03-05 |
|            5 | SHM     | 유니폼     	| 의류        | 300000 |      1 | SHM     | 손흥민      |       1900 | 주소     | 01012131415  |    175  | 1970-01-01 |
|            6 | EM      | 도지코인     	| 가상화폐  	 |   5000 | 100000 | EM      | 엘론       |       1950 | 주소1     | 01019283746  |    180  | 1950-01-02 |
|            7 | idd     | 고양이사료   	| 사료      	 |  25000 |      1 | idd     | 아이디      |       1507 | 주소주소  | 01012311231  |    160  | 2021-03-02 |
|            8 | idd     | 고양이방석   	| 애완      	 |   5000 |      3 | idd     | 아이디      |       1507 | 주소주소  | 01012311231  |    160  | 2021-03-02 |
|            9 | iddd    | 코코볼       	| 시리얼     	 |   7000 |      2 | iddd    | 아이디디    |       1507 | 주소      | 01012311232  |    167 | 2021-03-02 |
|           10 | iddd    | 게임용마우스 	| 전자기기   	 |  20000 |      1 | iddd    | 아이디디    |       1507 | 주소      | 01012311232  |    167 | 2021-03-02 |
+--------------+---------+--------------+------------+--------+--------+---------+-----------+------------+----------+--------------+--------+------------+
        */
	
    -- 합친 테이블에서 필요한 컬럼만 보고싶을 때
		-- 몇 년생이 샀는지, 키가 몇인 사람이 물건을 샀는지 등..
        
        -- 현재 현재 구매자 정보를 조회하려고 하는데, 필요한 정보는 buytbl의 구매 물품정보 전체에
        -- 구매자 정보는 택배를 받기 위해서 이름, 주소, 휴대폰 번호만 있으면되는 상황입니다.
        -- 조인 구문을 활용해 필요한 컬럼만 출력되게 수정해주세요.
			-- 예시
				SELECT buytbl.user_id, usertbl.user_name, buytbl.price, usertbl.addr
				FROM buytbl INNER JOIN usertbl
                ON buytbl.user_id = usertbl.user_id;
            
            -- 실습
				SELECT buytbl.user_id, usertbl.user_name, usertbl.addr, usertbl.phone_number, 
					   buytbl.order_number, buytbl.prod_name, buytbl.group_name, buytbl.price, buytbl.amount
				FROM buytbl INNER JOIN usertbl
                ON buytbl.user_id = usertbl.user_id;
			
            -- 실습(buytbl.*로 해봤다) => 된다 캬캬>_< => 근데 현업에서는 * 쓰는거보다 하나하나 적는걸 선호한다고 하심.
			SELECT usertbl.user_name, usertbl.addr, usertbl.phone_number, buytbl.*
            FROM buytbl INNER JOIN usertbl
            ON buytbl.user_id = usertbl.user_id;

			-- 위의 경우처럼 특정 테이블의 전체 데이터를 출력하는 경우는 테이블명.*로 대체할 수 있습니다.


	-- FROM 구문에서 테이블명만 적는게 아니라, 
    -- 테이블명 별명 형식으로 적을 경우는 테이블명을 풀로 적지 않고 별명으로 대체해서 호출할 수 있어 좀 더 편리합니다. "테이블명 별명" ex) buytbl b
	-- 현업에서 가장 많이 쓰는 방법.
		SELECT * 
        FROM buytbl b INNER JOIN usertbl u
        ON b.user_id = u.user_id;
        
			-- 현재 *로 처리된 구문을 위에 적힌 컬럼 조회하는 부분으로 고쳐주세요. (단, buytbl.* 구문은 쓰지 마세요)
			-- 별명이 생긴 이후부터는 usertbl (x) u (O). usertbl이라고 쓰면 에러가 뜸.
            	SELECT u.user_name, u.addr, u.phone_number, b.order_number, b.user_id, b.prod_name, b.group_name, b.price, b.amount
                FROM buytbl b INNER JOIN usertbl u
                ON b.user_id = u.user_id;
                
                /* CMD에서 해보자
                mysql> SELECT u.user_name, u.addr, u.phone_number, b.order_number, b.user_id, b.prod_name, b.group_name, b.price, b.amount
				-> FROM buytbl b INNER JOIN usertbl u
				-> ON b.user_id = u.user_id;
					+-----------+----------+--------------+--------------+---------+--------------+------------+--------+--------+
					| user_name | addr     | phone_number | order_number | user_id | prod_name    | group_name | price  | amount |
					+-----------+----------+--------------+--------------+---------+--------------+------------+--------+--------+
					| 미미       | 삼척      | 01012341234  |            1 | mimi    | 기계식키보드    | 주변기기     | 200000 |      1 |
					| 미미       | 삼척      | 01012341234  |            2 | mimi    | 듀얼모니터  	  | 주변기기     | 200000 |      1 |
					| 손흥민      | 주소     | 01012131415  |            5 | SHM     | 유니폼         | 의류        | 300000 |      1 |
					| 엘론       | 주소1     | 01019283746  |            6 | EM      | 도지코인       | 가상화폐     |   5000 | 100000 |
					| 아이디      | 주소주소  | 01012311231  |            7 | idd     | 고양이사료   	  | 사료        |  25000 |      1 |
					| 아이디      | 주소주소  | 01012311231  |            8 | idd     | 고양이방석      | 애완        |   5000 |      3 |
					| 아이디디    | 주소      | 01012311232  |            9 | iddd    | 코코볼         | 시리얼      |   7000 |      2 |
					| 아이디디    | 주소      | 01012311232  |           10 | iddd    | 게임용마우스    | 전자기기     |  20000 |      1 |
					+-----------+----------+--------------+--------------+---------+--------------+------------+--------+--------+
                
                */

	-- WHERE절은 먼저 JOIN 구문의 결과가 나온 상태에서( SELECT ~ ON까지 끝난 상태), 추가 필터링만을 담당합니다.
    -- 구매물품의 가격이 5만원 이상인 것만 남기는 구문.
		SELECT u.user_name, u.addr, u.phone_number, b.order_number, b.user_id, b.prod_name, b.group_name, b.price, b.amount
		FROM buytbl b INNER JOIN usertbl u
        ON b.user_id = u.user_id
        WHERE price >= 50000;

		-- 위쪽 JOIN 구문을 활용하시되, 가격이 20만원 이하인 품목만 남겨주시고, 남은 자료들을 가격순으로 내림차순 출력해주세요.
			SELECT u.user_name, u.addr, u.phone_number, b.order_number, b.user_id, b.prod_name, b.group_name, b.price, b.amount
			FROM buytbl b INNER JOIN usertbl u
			ON b.user_id = u.user_id
			WHERE price <= 200000
            ORDER BY b.price desc;  -- price라고만 적어도 출력은 되지만, 좀 더 명확하게 하고 싶으면 b.price라고 하는게 맞음.

	
    
    SELECT * FROM usertbl;   -- 회원은 12명
    SELECT * FROM buytbl;	 -- 구매 이력이 있는 회원은 8명
    
	-- LEFT JOIN인데,
    -- usertbl을 왼족에, buytbl을 오른쪽에 두고 작성해주세요.
    -- INNER JOIN을 넣은 자리에 LEFT OUTER JOIN으로 고쳐주시기만 하면 작동합니다.
    -- 테이블의 컬럼은 전체 출력합니다.
		SELECT *
        FROM usertbl u LEFT OUTER JOIN buytbl b
        ON u.user_id = b.user_id;
      
			/* CMD 결과
        mysql> SELECT * FROM usertbl u LEFT OUTER JOIN buytbl b
    -> ON u.user_id = b.user_id;
		+----------+-----------+------------+----------+--------------+--------+------------+--------------+---------+--------------+------------+--------+--------+
		| user_id  | user_name | birth_year | addr     | phone_number | height | reg_date   | order_number | user_id | prod_name    | group_name | price  | amount |
		+----------+-----------+------------+----------+--------------+--------+------------+--------------+---------+--------------+------------+--------+--------+
		| ADR      | 압둘라      |       1995 | 경기      | 01012341239  |    183 | 2021-04-01 |         NULL | NULL    | NULL         | NULL       |   NULL |   NULL |
		| EM       | 엘론       |       1950 | 주소1     | 01019283746  |    180 | 1950-01-02 |            6 | EM      | 도지코인     	| 가상화폐      |   5000 | 100000 |
		| idd      | 아이디      |       1507 | 주소주소   | 01012311231  |    160 | 2021-03-02 |            7 | idd     | 고양이사료 	    | 사료         |  25000 |      1 |
		| idd      | 아이디      |       1507 | 주소주소   | 01012311231  |    160 | 2021-03-02 |            8 | idd     | 고양이방석      | 애완         |   5000 |      3 |
		| iddd     | 아이디디    |       1507 | 주소      | 01012311232  |    167 | 2021-03-02 |            9 | iddd    | 코코볼         | 시리얼        |   7000 |      2 |
		| iddd     | 아이디디    |       1507 | 주소      | 01012311232  |    167 | 2021-03-02 |           10 | iddd    | 게임용마우스     | 전자기기      |  20000 |      1 |
		| iloveyou | 퐁구       |       2021 | 삼척      | 01011112222  |     15 | 2020-03-05 |         NULL | NULL    | NULL         | NULL        |   NULL |   NULL |
		| JSP      | 쟈스피      |       1989 | 전라     | 01012341239  |    177 | 2022-01-01 |         NULL | NULL    | NULL         | NULL        |   NULL |   NULL |
		| KJV      | 김자바      |       1983 | 서울     | 01012341239  |    171 | 2020-08-15 |         NULL | NULL    | NULL         | NULL        |   NULL |   NULL |
		| mimi     | 미미       |       2019 | 삼척     | 01012341234  |     20 | 2019-03-05 |            1 | mimi    | 기계식키보드     | 주변기기      | 200000 |      1 |
		| mimi     | 미미       |       2019 | 삼척     | 01012341234  |     20 | 2019-03-05 |            2 | mimi    | 듀얼모니터       | 주변기기     | 200000 |      1 |
		| SHM      | 손흥민      |       1900 | 주소     | 01012131415  |    175 | 1970-01-01 |            5 | SHM     | 유니폼         | 의류        | 300000 |      1 |
		| SPR      | 스프링      |       1987 | 강원     | 01012341239  |    184 | 2021-12-31 |         NULL | NULL    | NULL         | NULL       |   NULL |   NULL |
		| YSO      | 야스오      |       2001 | 부산     | 01012341239  |    165 | 2021-10-08 |         NULL | NULL    | NULL         | NULL       |   NULL |   NULL |
		| ZYA      | 장위안      |       1985 | 부산     | 01012341239  |    164 | 2020-02-28 |         NULL | NULL    | NULL         | NULL       |   NULL |   NULL |
		+----------+-----------+------------+----------+--------------+--------+------------+--------------+---------+--------------+------------+--------+--------+
        */
     
     
     -- RIGHT JOIN
     -- usertbl(RIGHT), buytbl(left)
        SELECT *
        FROM buytbl b RIGHT OUTER JOIN usertbl u
        ON u.user_id = b.user_id;
        
			/* CMD 결과
            
            mysql> SELECT * FROM buytbl b RIGHT OUTER JOIN usertbl u
				-> ON u.user_id = b.user_id;
			+--------------+---------+--------------+------------+--------+--------+----------+-----------+------------+----------+--------------+--------+------------+
			| order_number | user_id | prod_name    | group_name | price  | amount | user_id  | user_name | birth_year | addr     | phone_number | height | reg_date   |
			+--------------+---------+--------------+------------+--------+--------+----------+-----------+------------+----------+--------------+--------+------------+
			|         NULL | NULL    | NULL         | NULL       |   NULL |   NULL | ADR      | 압둘라    |       1995 | 경기        | 01012341239  |    183 | 2021-04-01 |
			|            6 | EM      | 도지코인       | 가상화폐     |   5000 | 100000 | EM       | 엘론      |       1950 | 주소1      | 01019283746  |    180 | 1950-01-02 |
			|            7 | idd     | 고양이사료      | 사료       |  25000 |      1 | idd      | 아이디    |       1507 | 주소주소     | 01012311231  |    160 | 2021-03-02 |
			|            8 | idd     | 고양이방석      | 애완       |   5000 |      3 | idd      | 아이디    |       1507 | 주소주소     | 01012311231  |    160 | 2021-03-02 |
			|            9 | iddd    | 코코볼         | 시리얼      |   7000 |      2 | iddd     | 아이디디  |       1507 | 주소        | 01012311232  |    167 | 2021-03-02 |
			|           10 | iddd    | 게임용마우스    | 전자기기     |  20000 |      1 | iddd     | 아이디디  |       1507 | 주소        | 01012311232  |    167 | 2021-03-02 |
			|         NULL | NULL    | NULL         | NULL       |   NULL |   NULL | iloveyou | 퐁구      |       2021 | 삼척       | 01011112222  |     15 | 2020-03-05 |
			|         NULL | NULL    | NULL         | NULL       |   NULL |   NULL | JSP      | 쟈스피    |       1989 | 전라        | 01012341239  |    177 | 2022-01-01 |
			|         NULL | NULL    | NULL         | NULL       |   NULL |   NULL | KJV      | 김자바    |       1983 | 서울        | 01012341239  |    171 | 2020-08-15 |
			|            1 | mimi    | 기계식키보드    | 주변기기     | 200000 |      1 | mimi     | 미미      |       2019 | 삼척        | 01012341234  |     20 | 2019-03-05 |
			|            2 | mimi    | 듀얼모니터      | 주변기기    | 200000 |      1 | mimi     | 미미      |       2019 | 삼척        | 01012341234  |     20 | 2019-03-05 |
			|            5 | SHM     | 유니폼         | 의류       | 300000 |      1 | SHM      | 손흥민    |       1900 | 주소         | 01012131415  |    175 | 1970-01-01 |
			|         NULL | NULL    | NULL         | NULL       |   NULL |   NULL | SPR      | 스프링    |       1987 | 강원        | 01012341239  |    184 | 2021-12-31 |
			|         NULL | NULL    | NULL         | NULL       |   NULL |   NULL | YSO      | 야스오    |       2001 | 부산        | 01012341239  |    165 | 2021-10-08 |
			|         NULL | NULL    | NULL         | NULL       |   NULL |   NULL | ZYA      | 장위안    |       1985 | 부산        | 01012341239  |    164 | 2020-02-28 |
			+--------------+---------+--------------+------------+--------+--------+----------+-----------+------------+----------+--------------+--------+------------+
            */


	-- FULL OUTER JOIN
		SELECT * FROM buytbl b LEFT OUTER JOIN usertbl u ON b.user_id = u.user_id
        UNION -- UNION 구문은 위 아래 결과 화면을 합쳐줍니다. => LEFT와 RIGHT 사이에 넣으면 FULL OUTER JOIN이 되는 것.
        SELECT * FROM buytbl b RIGHT OUTER JOIN usertbl u ON b.user_id = u.user_id;
        
      
		-- FULL OUTER JOIN 이해를 돕기 위한 추가 데이터 설정
			CREATE TABLE student( 				    -- 학교에서 관리하는 학적부
				user_name VARCHAR(3) PRIMARY KEY,
				addr CHAR(2) NOT NULL			    -- VARCHAR와 CHAR의 차이는 인트와 인티저 같은 느낌스,,
			);
			
			CREATE TABLE membership( 				-- 학교 앞에 있는 마트 같은. 물건 사면 포인트 주는곳
				user_name VARCHAR(3) PRIMARY KEY,
				user_point INT NOT NULL
			);
		
        -- 데이터 적재
			INSERT INTO student VALUES ('강건마', '서울');
			INSERT INTO student VALUES ('노영웅', '수원');
            INSERT INTO student VALUES ('이상용', '인천');
			
            SELECT * FROM student;
			SELECT * FROM membership;
        
			INSERT INTO membership VALUES ('강건마', 15000);
			INSERT INTO membership VALUES ('노영웅', 37000);
            INSERT INTO membership VALUES ('김철수', 500);    -- 학교 학생은 아니지만 마트를 사용하는 사람
			
		-- LEFT OUTER JOIN
			SELECT * FROM student s LEFT OUTER JOIN membership m ON s.user_name = m.user_name;
				/* CMD 결과
				+-----------+------+-----------+------------+
				| user_name | addr | user_name | user_point |
				+-----------+------+-----------+------------+
				| 강건마      | 서울  | 강건마      |      15000 |
				| 노영웅      | 수원  | 노영웅      |      37000 |
				| 이상용      | 인천  | NULL      |       NULL |
				+-----------+------+-----------+------------+
				*/
        -- RIGHT OUTER JOIN
            SELECT * FROM student s RIGHT OUTER JOIN membership m ON s.user_name = m.user_name;
				/* CMD 결과
                +-----------+------+-----------+------------+
				| user_name | addr | user_name | user_point |
				+-----------+------+-----------+------------+
				| 강건마      | 서울  | 강건마      |      15000 |
				| NULL      | NULL | 김철수      |        500 |
				| 노영웅      | 수원  | 노영웅      |      37000 |
				+-----------+------+-----------+------------+
				*/
        -- FULL OUTER JOIN
			SELECT * FROM student s LEFT OUTER JOIN membership m ON s.user_name = m.user_name
            UNION
			SELECT * FROM student s RIGHT OUTER JOIN membership m ON s.user_name = m.user_name;
				/* CMD 결과
                +-----------+------+-----------+------------+
				| user_name | addr | user_name | user_point |
				+-----------+------+-----------+------------+
				| 강건마      | 서울  | 강건마      |      15000 |
				| 노영웅      | 수원  | 노영웅      |      37000 |
				| 이상용      | 인천  | NULL      |       NULL |
				| NULL      | NULL | 김철수      |        500 |
				+-----------+------+-----------+------------+
                */
        
        -- 위의 UNION으로 처리되는 구문은 user_name이 두 번 출력되는 문제가 있습니다.
        -- 한 번만 출력되게 작성해보세요.
			

            
        