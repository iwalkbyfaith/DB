/* 1. 데이터 베이스 생성 명령

DB 생성시 한글을 쓸 수 있도록 하는 명령 -> default character set utf8;
우리가 쓸 데이터베이스인 ict_practice를 만들고 명령을 붙여줌 -> 다 적고 컨트롤 + 엔터 */

create database ict_practice default character set utf8;


/* Navigator 우측 하단의 schemas 클릭 -> 새로고침 버튼을 클릭 -> ict_practice 우클릭
   -> set as default schema를 클릭하세요. 이러면 현재 명령을 받을 DB로 지정됩니다. */
   
/* default schema 지정은 명령어로도 할 수 있습니다.
use 스키마명; 을 사용하면 => 좌측 schemas에서 우클릭 후 default 스키마 지정한 효과를 낼 수도 있습니다. */
use sys;
/* 이렇게 하면 sys에 볼드 처리가 옮겨짐 */
use ict_practice;



/* 테이블 생성 명령
primary key - 컬럼의 주요 키를 뜻하며, 중복 데이터를 방지합니다.
테이블 내의 하나의 컬럼은 반드시 primary key 속성을 가져야 합니다.
not null -> 데이터에 null 값이 들어오는 것을 방지합니다. */

/* 테이블은 클래스랑 구조가 비슷합니다.
클래스 내부의 멤버 변수를 지정하듯이 테이블 요소를 지정해 줄 수 있습니다. */
/* 실제하는 대상을 프로그래밍적으로 표현하는 것을 '추상(抽象)화'라고 한다.
사물이 지니고 있는 여러가지 측면 가운데서 특정한 측면만을 가려내어 포착하는 것이다.(사전적 의미) */    

CREATE TABLE users(
	id varchar(20) primary key,
    pw varchar(20) not null,
    user_name varchar(30) not null,
    email varchar(80)
    );
    
/* varchar = 자바의 string  (varchar라고 쓰면 자바의 String과 호환됨) 
   (20) => 20자까지 문자열 제한 (자바에서는 제한을 하지 못하기때문에 여기서 거는 것) */


/* 데이터 적재하기
INSERT INTO 테이블명 (컬럼1, 컬럼2 ...) VALUE(S) (컬럼1값, 컬럼2값, ...);

만약 모든 컬럼을 대상으로 지정시 컬럼은 생략하고 VALUE(S) 이후 값만 지정할 수 있다.
INSERT INTO 테이블명 VALUE(S)(컬럼1값, 컬럼2값, ...); */

-- VALUES의 다음 () 괄호를 밑으려 내려도 에러나지 않는다. (이클립스에서도 비슷했지)
INSERT INTO users (id, pw, user_name, email) VALUE 
	('abc1234', 'asdf', '김자바', 'asdf@asdf.com');
INSERT INTO users VALUES('qwer123', 'qwer', '쿼리문', 'query@query.com');  



-- 한 줄 주석은 자바와 달리 작대기 두개+한칸 띄고 적어 작성할 수 있습니다.
-- Q) 여러분들이 계정 3개를 더 넣어주시되, 1개 계정은 이메일을 생략하고 넣어주세요.

	INSERT INTO users VALUES('love1', 'love11', '러브캣', 'loveyou@you.com');
	INSERT INTO users VALUES('cat1', 'cat11', '캐츠랑', 'catgod@you.com');

   -- A1) 이메일 없이 넣는 경우는 컬럼명을 반드시 표기해야 합니다.
	INSERT INTO users (id, pw, user_name) value	('iid', 'ppww', '아이디디');
   -- A2) (다른 방법) 모든 것을 넣는 경우로 만들고, 채울 자리를 null 처리 해도 됨
	INSERT INTO users VALUES('love123', 'love1123', '러브캣1', null);



/* 데이터 조회하기
SELECT 컬럼1, 컬럼2, ... FROM 테이블명;
을 적으면 테이블에 적재된 데이터 조회 가능
SELECT * FROM 테이블명;으로 조회시 해당 테이블의 전체 컬럼 조회 가능 */
  -- 전체 보기 방법1)
	SELECT * FROM users;
  -- 전체 보기 방법2) 이 방법으로 원하는 데이터의 일부만 볼 수도 있음.
	SELECT id, pw, user_name, email FROM users;

  -- 조회 구문에 조건을 걸기 위해서 WHERE이라는 구문을 사용합니다.
  -- SELECT 조회컬럼 FROM 테이블명 WHERE 컬럼명 = '조건에 맞는 값';
  -- 이름이 '김자바'인 사람만 출력하기
	SELECT * FROM users WHERE user_name = '김자바';
  -- 여러분들의 기준으로 필터링을 해보세요.
	  -- 아이디가 'love1'인 사람만 출력하기
      SELECT * FROM users WHERE id = 'love1';
  -- 조건 여러개를 걸 경우 AND, OR 키워드를 쓰면 됩니다.
	  -- 아이디가 cat1 이거나 혹은 유저 이름이 김자바인 경우(★ 자바에서는 &, | 였는데, 여기서는 AND, OR 임에 주의!)
	  SELECT * FROM users WHERE id = 'cat1' OR user_name = '김자바';


/* 데이터 수정하기
UPDATE 테이블명 SET 컬럼명1 = '값1', 컬럼명2 = '값2' ... ;
주의할 점은 WHERE 구문 없이 사용하면 일괄적으로 컬럼 내의 모든 값이 다 바뀝니다. */

UPDATE users SET pw = 'pppp';
	-- 모든 pw가 pppp가 됨.
	-- 이런 실수를 방지하려고 밑에 'SQL_SAFE_UPDATES'를 쓰지 않으면 반영이 되지 않게 됨. (최근에 새로 업데이트 됨)
	SET SQL_SAFE_UPDATES = 1;   -- 0으로 주면 비활성화(바꿀 수 있음), 1로 바꾸면 다시 safety모드 활성화.
	SELECT * FROM users;

	-- Q) WHERE 구문을 이용해서 pw 컬럼의 값을 다르게 바꿔보세요.
	UPDATE users SET pw = '111' WHERE id = 'abc1234';
	UPDATE users SET pw = '222' WHERE id = 'cat1';
	UPDATE users SET pw = '333' WHERE id = 'iid';
	UPDATE users SET pw = '444' WHERE id = 'love1';
	UPDATE users SET pw = '666' WHERE id = 'qwer123';
    -- 두개 이상도 가능
	UPDATE users SET pw = '5959', user_name = '왕발깜구' WHERE id = 'love123';
	-- 수정 후 조회하기
    SELECT * FROM users;
    

/* 데이터 삭제
DELETE FROM 테이블명; 을 할 경우 테이블 전체의 데이터가 싹 다 날아갑니다.
DELETE 구문 역시 WHERE과 조합해서 사용해야합니다. */

-- 데이터 삭제. (id가 iid인 사람을 users 테이블에서 삭제하겠다)
DELETE FROM users WHERE id = 'iid';
-- 삭제 후 다시 조회
SELECT * FROM users;


/* (실습)
도서관 DB를 한 번 만들어 보겠습니다.
도서관 테이블 이름 : library
내장 데이터 : 
책이름(book_name) - primary key/문자열(30) 
책가격(book_price) - not null, int(7)
출판사(book_pub)   - not null, 문자열(20자)
저자(book_writer) - not null, 문자열(10자)
분량(book_page)   - not null, int(5))

생성 후 책을 6권 넣어보세요.
*/
	-- 테이블 생성
	CREATE TABLE library(
		book_name varchar(30) primary key,
		book_price int(7) not null,           -- 7자리 ( ~ 1000000)
		book_pub varchar(20) not null,
		book_writer varchar(10) not null,
		book_page int(5) not null             -- 5자리 ( ~ 10000)
		);
        -- varchar = String
        -- int = int (주의! 자리수를 말함)

	-- 테이블에 값을 넣어줌
	INSERT INTO library VALUES ('데미안', 12000, '민음사', '헤르만 헤세', 200);
	INSERT INTO library VALUES ('해리포터1', 11000, '문학수첩', '롤링', 189);
	INSERT INTO library VALUES ('해리포터2', 11000, '문학수첩', '롤링', 190);
	INSERT INTO library VALUES ('고양이전사들', 14800, '주니어김영사', '에린헌터', 300);
	INSERT INTO library VALUES ('샬롯의거미줄', 8000, '시공주니어', '화이트', 123);
	INSERT INTO library VALUES ('헝거게임', 11000, '북폴리오', '수잔콜린스', 210);
	
    -- 결과 확인
	SELECT * FROM library;
    
    -- 테이블을 잘못 생성한 경우 'drop table library;'를 이용해 추가 테이블을 삭제할 수 있고,
	-- 삭제한 후에 수정 내역을 반영해 다시 만들어주시면 됩니다.