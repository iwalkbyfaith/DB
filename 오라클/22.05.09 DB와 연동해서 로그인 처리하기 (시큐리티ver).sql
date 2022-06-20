-- 05.09 DB�� �����ؼ� �α��� ó�� �ϱ�( ������ ����11�� 46~

-- �� ���̺�1) � ������ �����ߴ���
CREATE TABLE users(
    username varchar2(50) not null primary key,
    password varchar2(100) not null,
    enabled char(1) default '1'
);
    
    
-- �� ���̺�2) ����Ǿ� �ִ� ������ � ������ �ο��ߴ��� ���� ����. �����δ� ���� ��ȣ�� �ο��ؾ��Ѵ�
CREATE TABLE authorities(
    username varchar2(50) not null,
    authority varchar2(50) not null,        -- user, manager, admin
    constraint fk_authorities_users foreign key (username) references users(username)
);


create unique index ix_auth_username on authorities (username, authority);

    drop table users;
    drop table authorities;

    SELECT * FROM users;
    SELECT * FROM authorities;
    commit;

-- ����
    -- ���̺�1
    
    insert into users ( username, password) values ('member11', 'pw11');
    
    insert into users ( username, password) values ('user22', 'pw22');
    insert into users ( username, password) values ('free22', 'pw22');
    insert into users ( username, password) values ('paid22', 'pw22');
    insert into users ( username, password) values ('admin22', 'pw22');
    
    -- ���̺�2
    insert into authorities (username, authority) values ('user22', 'ROLE_USER');
    insert into authorities (username, authority) values ('free22', 'ROLE_FREE_WRITER');
    insert into authorities (username, authority) values ('paid22', 'ROLE_PAID_WRITER');
    insert into authorities (username, authority) values ('admin22', 'ROLE_PAID_WRITER');
    
    delete from authorities WHERE username = 'memeber00';
    
    commit;
    
    
    
-- �� ����ڰ� ������ Ŀ���� DB�� Ȱ���� �α��� ��� ó�� (����11�� 54)

CREATE TABLE member_tbl(
    userid varchar2(50) not null primary key,
    userpw varchar2(100) not null,
    username varchar2(100) not null,
    regdate date default sysdate,
    updatedate date default sysdate,
    enabled char(1) default '1'
);

CREATE TABLE member_auth(
    userid varchar2(50) not null,
    auth varchar2(50) not null,         -- user, member, admin
    constraint fk_member_auth foreign key (userid) references member_tbl(userid)
);
    
    -- ��ȸ
    SELECT * FROM member_tbl;
    SELECT * FROM member_auth;
    
    commit;
    
    -- MemberMapper.xml���� ���� ������ (left outer join)
    SELECT
        m.userid, userpw, username, enabled, regdate, updatedate, a.auth
    FROM
        member_tbl m LEFT OUTER JOIN member_auth a on m.userid = a.userid
    WHERE
        m.userid = 'user0';
        
        
        
        
     -- ������ ������Ʈ UserMapper.xml���� ���� ������ (left outer join) ������
    SELECT
        u.user_num, u.user_id, u.user_pw, u.user_name, u.user_pnum, u.user_email, u.user_coin, u.user_coupon, u.user_rdate, u.user_auth_mdate, u.user_enabled,
        a.auth
    FROM
        user_tbl u LEFT OUTER JOIN auth_tbl a on u.user_id = a.user_id
    WHERE
        u.user_id = 'user0';
        
        
    SELECT * FROM auth_tbl;
    
    commit;
        
    
    
    