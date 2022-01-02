-- employees를 사용 스키마로 지정해주세요.
	use employees;

-- employees 내부의 employees 테이블을 조회해주세요.
-- SQL 구문은 명령구문을 무조건 대문자, 테이블 명이나 호칭 등은 소문자로 작성하는 것이 관례입니다.
-- 무조건 지키지 않아도 실행은 가능하지만, 가독성을 위해 되도록이면 지켜주세요.
	SELECT * FROM employees;


-- 원래 테이블 조회할 때는 스키마명.테이블명으로 모두 표기해야 합니다.
	SELECT * FROM employees.employees;
	-- 지금은 use employees;를 해서 employees 스키마를 사용하는 상태이기 때문에 안 적어도 조회가 되었던 것.
    -- employees 스키마인 상태에서 ict_practice의 users 테이블을 조회하고 싶은 경우
		-- (= use중이지 않은 스키마의 테이블을 조회하고 싶을 때)
		SELECT * FROM users;              -- 에러 뜸
		SELECT * FROM ict_practice.users; -- 조회 가능
        
        
        
-- 컬럼을 전체가 아닌 임의로 가져올때는 컬럼명을 ,(콤마)로 구분합니다.
-- 이 경우 모든 컬럼이 아닌 일부 컬럼만 조회할 수도 있으며 심지어 한 개의 컬럼만 조회하는 등 개수 조절도 가능합니다.
-- (순번도 바꿀 수 있음)
	SELECT gender, first_name, last_name From employees;


-- CMD환경에서는 좌측 스키마처럼 스키마 목록을 보여주는 창이 없으므로
-- 아래 명령어를 이용해 SCHEMA 목록을 확인할 수 있습니다.
	SHOW databases;
	-- 여기서 먹히는 명령어는 CMD에서도 먹힌다고 보면 됨.

-- CMD에서 employees 스키마를 쓰도록 세팅
	-- 똑같음  use employees;


-- 현재 DB정보를 조회하기 위해서는
	SHOW TABLE STATUS;

-- 특정 테이블의 컬럼 정보를 조회하고 싶다면 아래 명령어를 씁니다.
-- DESCRIBE 테이블명; 혹은 DESC 테이블명;
	DESCRIBE employees;
	DESC employees;
    
-- 제 1 정규화, 제 2 정규화에 대해서 보고 넘어감.




-- ict_practice를 디폴트 스키마로 잡아주세요.
use ict_practice;

-- 테이블을 생성합니다.
-- 테이블 생성시 적힌 제약 조건과 컬럼명을 활용해 만들어주세요.

CREATE TABLE userTbl(
	user_id 	 VARCHAR(8) PRIMARY KEY,
    user_name    VARCHAR(10) NOT NULL,
    birth_year   int(4) NOT NULL,       -- int 라고만 쓰면 자리수 제한이 없이 쓸 수 있다.
    addr 	     VARCHAR(4) NOT NULL,
    phone_number VARCHAR(11),
    height 		 INT(3),
    reg_date 	 DATE
);

CREATE TABLE buyTbl(
	order_number 	INT AUTO_INCREMENT PRIMARY KEY,
    user_id 		VARCHAR(8) NOT NULL,
    prod_name 		VARCHAR(6) NOT NULL,
    group_name 		VARCHAR(4),
    price 			INT(7) NOT NULL,
    amount 			INT(3) NOT NULL,
    FOREIGN KEY(user_id) REFERENCES userTbl(user_id)   -- userTble을 참조하겠다
);



/*
 PRIMARY KEY = 주요키
	각 테이블을 대표할 수 있는 대표데이터를 저장하는 컬럼에 붙이는 제약조건입니다.
    모든 테이블은 무조건 하나의 PRIMARY KEY를 갖는다.
    PRIMARY KEY는 자동으로 중복을 방지하고, NULL도 들어올 수 없으므로 NOT NULL도 겸한다.

NOT NULL
	무조건 데이터 받아야 됨
    
AUTO_INCREMENT = 자동 증가
	INT(정수) 자료형이 붙은 컬럼에만 붙일 수 있고, 이게 붙은 컬럼은 자동으로 1씩 증가하는 숫자를 배정 받습니다.
    시작은 1입니다.
    INSERT INTO 구문이 실행될 때마다 해당 컬럼에 들어갈 숫자를 자동으로 배정해줍니다.
    한 번 쓰인 숫자는 다시는 사용되지 않습니다. (= 겹칠 일이 없음 => PRIMARY KEY가 되기 좋음) ex) 게시판 글 번호, 주문 번호
    
FOREIGN KEY = 외래키
	쇼핑몰의 구매자는 반드시 회원이어야 합니다.
    특정 테이블에 존재하는 값만 해당 컬럼에 들여올 수 있도록 거는 제약조건입니다.
    FOREIGN KEY를 거는 컬럼의 자료형과 크기는 참조하는 쪽과 원본 모두 같아야 합니다.
    참조 컬럼에 있는 값만(여기서는 userTble의 user_id) buyTbl의 user_id에 올 수 있습니다.
*/

-- 데이터 추가 (성공)
	INSERT INTO userTbl VALUES('iloveyou', '깜구', 2021, '강원', '01012345678', 18, '2020-03-05');

-- 데이터 확인
	SELECT * FROM userTbl;

-- 데이터 하나 더 추가 (실패)
	INSERT INTO userTbl VALUES('iloveyou', '퐁구', 2021, '삼척', '01011112222', 15, '2020-03-05');
	-- 이렇게하면 에러남. 왜? user_id가 주요키(PRIMARY KEY)이기 때문.
    
-- 데이터 하나 더 추가 (성공)
	INSERT INTO userTbl VALUES('mimi', '미미', 2019, '삼척', '01012341234', 20, '2019-03-05');

-- 가입한 회원이 물건을 산 이력이 남도록 하겠습니다.
	INSERT INTO buyTbl VALUES(null, 'mimi', '기계식키보드', '주변기기', 200000, 1);
-- order_number는 값을 null로 주면 AUTO_INCREMENT에 의해 자동으로 1씩 증가된 숫자를 배정 받음.
	INSERT INTO buyTbl VALUES(null, 'mimi', '듀얼모니터', '주변기기', 200000, 1);

-- 없는 회원 아이디로 INSERT를 시도해보겠습니다(실패) -> userTbl에 없기 때문.
	INSERT INTO buyTbl VALUES(null, 'SHM', '유니폼', '의류', 300000, 1);
	INSERT INTO buyTbl VALUES(null, 'EM', '도지코인', '가상화폐', 5000, 100000);

SELECT * FROM buyTbl;


-- SHM, EM으로 INSERT를 할 수 있도록 조취를 취해주신다음 실행시켜서, 디비에 저장까지 해주세요.
-- 회원부터 집어 넣음
	INSERT INTO userTbl VALUES ('SHM', '손흥민', 1900, '주소', '01012131415', 175, '1970-01-01');
	INSERT INTO userTbl VALUES ('EM', '엘론', 1950, '주소1', '01019283746', 180, '1950-01-02');

-- 유저 테이블 확인
	SELECT * FROM userTbl;

-- buyTbl에 넣어보기
	INSERT INTO buyTbl VALUES(null, 'SHM', '유니폼', '의류', 300000, 1);
	INSERT INTO buyTbl VALUES(null, 'EM', '도지코인', '가상화폐', 5000, 100000);

-- buyTbl 확인
	SELECT * FROM buyTbl;

	