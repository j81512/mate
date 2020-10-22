--=====================================
-- mate 계정 생성 (system 계정)
--=====================================
--create user mate
--identified by mate
--default tablespace users;
--grant RESOURCE,CONNECT to mate;
----------------------------------------------------------------
--grant create any job to mate;
--=====================================
-- 유저 삭제 (system 계정)
--=====================================
--select sid,serial#,username,status from v$session where schemaname = 'MATE'; --여기서 나온 숫자를
--alter system kill session '115,825'; --여기에 대입해서 세션 kill후 삭제하면 안껐다 켜도됌
--DROP USER mate CASCADE;
--=====================================
-- Drop 관련
--=====================================
--DROP TABLE MEMBER;
--DROP TABLE  EMP cascade constraints;
--DROP TABLE PRODUCT;
--DROP TABLE Address;
--DROP TABLE PRODUCT_IMAGES;
--DROP TABLE PRODUCT_MAIN_IMAGES;
--DROP TABLE  IO_LOG;
--DROP TABLE  CS;
--DROP TABLE  CS_IMAGES;
--DROP TABLE PURCHASE;
--DROP TABLE  CART;
--DROP TABLE RETURN;
--DROP TABLE RETURN_IMAGES;
--DROP TABLE QUIT_MEMBER;
--DROP TABLE ORDER_LOG;
--DROP TABLE REVIEW;
--DROP TABLE BOARD_REPLY;
--DROP TABLE CS_REPLY;
--DROP TABLE REQUEST_LOG;
--DROP TABLE BOARD;
--DROP TABLE BOARD_IMAGES;
--DROP TABLE DELETE_CS;
--DROP TABLE DELETE_BOARD;
--DROP TABLE DELETE_PRODUCT;
--DROP TABLE DELETE_EMP;
--DROP TABLE RECEIVE;
--DROP TABLE BOARD_INFO;
--DROP TABLE STOCK;
--DROP TABLE PURCHASE_LOG;
--
--drop sequence seq_product_no;
--drop sequence seq_product_image_no;
--drop sequence seq_product_main_image_no;
--drop sequence seq_stock_no;
--drop sequence seq_request_no;
--drop sequence seq_io_no;
--drop sequence seq_receive_no;
--drop sequence seq_board_no;
--drop sequence seq_board_reply_no;
--drop sequence seq_board_image_no;
--drop sequence seq_board_info_no;
--drop sequence seq_cs_no;
--drop sequence seq_cs_image_no;
--drop sequence seq_cs_reply_no;
--drop sequence seq_purchase_no;
--drop sequence seq_purchase_log_no;
--drop sequence seq_return_no;
--drop sequence seq_return_image_no;
--drop sequence seq_review_no;
--
--drop trigger trg_quit_member;
--drop trigger trg_delete_cs;
--drop trigger trg_delete_board;
--drop trigger trg_delete_emp;
--drop trigger trg_delete_product;
--drop trigger trg_purchase_log;
--drop trigger trg_return;
--drop trigger trg_receive;
--drop trigger trg_io_log;
--drop trigger trg_request_log;

--=====================================
-- 테이블
--=====================================
--DROP TABLE MEMBER;
CREATE TABLE MEMBER (
	member_id 	varchar2(100)		NOT NULL,
	member_pwd	varchar2(300)		NOT NULL,
	member_name	varchar2(128)		NOT NULL,
   	 gender	char(1)		NOT NULL,
	phone	char(11)		NOT NULL,
	enroll_date	date	DEFAULT sysdate	NOT NULL,
    
    constraint pk_member primary key (member_id),
    constraint chk_member_gender check (gender in ('M','F'))
);

<<<<<<< HEAD
select * from member;

=======
>>>>>>> branch 'master' of https://github.com/j81512/mate.git
--DROP TABLE Address;
CREATE TABLE Address (
	address_name	varchar2(128)		NOT NULL,
	member_id	varchar2(100)		NOT NULL,
	reciever_name	varchar2(128)		NOT NULL,
	receiver_phone	char(11)		NOT NULL,
	addr1	varchar2(512)		NOT NULL,
	addr2	varchar2(512)		NOT NULL,
	addr3	varchar2(512)		NOT NULL,
	reg_date	date	DEFAULT sysdate	NOT NULL,
	is_check	number	DEFAULT 0	NOT NULL,
    
    constraint pk_address primary key (address_name, member_id),
    constraint fk_address_member_id foreign key (member_id)
                                              references member (member_id)
                                              on delete cascade
);

--DROP TABLE EMP;
--DROP TABLE EMP CASCADE CONSTRAINTS;
select * from cart;
CREATE TABLE EMP (
	emp_id	varchar2(15)		NOT NULL,
	emp_pwd	varchar2(300)		NOT NULL,
	emp_name	varchar2(256)		NOT NULL,
	addr1	varchar2(512)		NOT NULL,
	addr2	varchar2(512)		NOT NULL,
	addr3	varchar2(512)		NOT NULL,
	phone   char(11)		NOT NULL,
	enroll_date	date	DEFAULT sysdate	NOT NULL,
	status	number		NOT NULL,
    
    constraint pk_emp primary key (emp_id)
);
select * from emp;



select
	*
from
    emp
order by
    enroll_date;




--DROP TABLE PRODUCT;
CREATE TABLE PRODUCT (
	product_no	number	NOT NULL	,
	product_name	varchar2(256)		NOT NULL,
	reg_date	date	DEFAULT sysdate	 NOT NULL,
	category	varchar2(128)		NOT NULL,
	content	varchar2(4000)		NOT NULL,
	price	number		NOT NULL,
    manufacturer_id varchar2(15) NOT NULL,
	enabled	number	DEFAULT 0	NOT NULL,
    
    constraint pk_product primary key (product_no),
    constraint fk_product_emp_id foreign key (manufacturer_id)
                                         references emp (emp_id)
                                         on delete cascade
);

--DROP TABLE PRODUCT_IMAGES;
CREATE TABLE PRODUCT_IMAGES (
	product_image_no number		NOT NULL,
	renamed_filename	varchar2(256)		NOT NULL,
	product_no	number		NOT NULL,
    
    constraint pk_product_images primary key (product_image_no),
    constraint fk_product_images_product_no foreign key (product_no)
                                                        references product (product_no)
                                                        on delete cascade
);


--DROP TABLE PRODUCT_MAIN_IMAGES;
CREATE TABLE PRODUCT_MAIN_IMAGES (
	product_main_image_no	number		NOT NULL,
	original_filename	varchar2(256)		NOT NULL,
	renamed_filename	varchar2(256)		NOT NULL,
	product_no	number		NOT NULL,
    
    constraint pk_product_main_images primary key (product_main_image_no),
    constraint fk_product_main_images_prod_no foreign key (product_no)
                                                        references product (product_no)
                                                        on delete cascade
);

--DROP TABLE STOCK;
CREATE TABLE STOCK (
    product_no	number		NOT NULL,
	emp_id	varchar2(15)		NOT NULL,
	stock	number	DEFAULT 0	NOT NULL,
    
    constraint pk_stock primary key (product_no, emp_id),
    constraint fk_stock_product_no foreign key (product_no)
                                            references product(product_no)
                                            on delete cascade,
    constraint fk_stock_emp_id foreign key (emp_id)
                                            references emp(emp_id)
                                            on delete cascade
);

--DROP TABLE REQUEST_LOG;
CREATE TABLE REQUEST_LOG (
	request_no	number		NOT NULL,
    manufacturer_id varchar2(15)    NOT NULL,
	amount	number		NOT NULL,
	request_date	date	DEFAULT sysdate	NOT NULL,
	confirm	number	DEFAULT 0	NOT NULL,
	product_no	number		NOT NULL,
	emp_id	varchar2(15)		NOT NULL,
    
    constraint pk_request_log primary key (request_no),
    constraint fk_request_log_product_no foreign key (product_no)
                                                    references product(product_no)
                                                    on delete cascade,
    constraint fk_request_log_emp_id foreign key (emp_id)
                                            references emp(emp_id)
                                            on delete cascade
);

--DROP TABLE IO_LOG;
CREATE TABLE IO_LOG (
	io_no	number		NOT NULL,
    status	char(1)		NOT NULL,
	amount	number		NOT NULL,
	io_date	date	DEFAULT sysdate	NOT NULL,
	product_no	number		NOT NULL,
	emp_id	varchar2(15)		NOT NULL,
    content varchar2(100)   NOT NULL,
    
    constraint pk_io_log primary key (io_no),
    constraint fk_io_log_product_no foreign key (product_no)
                                            references product(product_no)
                                            on delete cascade,
    constraint fk_io_log_emp_id foreign key (emp_id)
                                       references emp(emp_id)
                                       on delete cascade
);

--DROP TABLE RECEIVE;
CREATE TABLE RECEIVE (
	receive_no	number		NOT NULL,
    manufacturer_id	varchar2(15)		NOT NULL,
	amount	number		NOT NULL,
	reg_date	date	DEFAULT sysdate	NOT NULL,
	confirm	number	DEFAULT 0	NOT NULL,
	product_no	number		NOT NULL,
	emp_id	varchar2(15)		NOT NULL,
    
    constraint pk_receive primary key(receive_no),
    constraint fk_receive_manufacturer_id foreign key (emp_id)
                                                    references emp(emp_id)
                                                    on delete cascade,
    constraint fk_receive_emp_id foreign key (emp_id)
                                        references emp(emp_id)
                                        on delete cascade,
    constraint fk_receive_product_no foreign key (product_no)
                                              references product(product_no)
                                              on delete cascade
);

--DROP TABLE BOARD;
CREATE TABLE BOARD (
	board_no	number		NOT NULL,
	category	char(3)		NOT NULL,
	title	varchar2(128)		NOT NULL,
	content	varchar2(3000)		NOT NULL,
	emp_id	varchar2(15)		NOT NULL,
	reg_date	date	DEFAULT sysdate	NOT NULL,
	enabled	number	DEFAULT 0	NOT NULL,
    read_count number DEFAULT 0 NOT NULL,
    
    constraint pk_board primary key(board_no),
    constraint fk_board_emp_id foreign key (emp_id)
                                       references emp(emp_id)
                                       on delete cascade
);

--DROP TABLE BOARD_REPLY;
CREATE TABLE BOARD_REPLY (
	board_reply_no	number		NOT NULL,
	content	varchar2(1000)		NOT NULL,
	reg_date date	DEFAULT sysdate	NOT NULL,
	board_no	number		NOT NULL,
	emp_id	varchar2(15)		NOT NULL,
    
    constraint pk_board_reply primary key (board_reply_no),
    constraint fk_board_reply_emp_id foreign key (emp_id)
                                              references emp(emp_id)
                                              on delete cascade,
    constraint fk_board_reply_board_no foreign key (board_no)
                                            references board(board_no)
                                            on delete cascade
);

--DROP TABLE BOARD_IMAGES;
CREATE TABLE BOARD_IMAGES (
	board_image_no	number		NOT NULL,
	original_filename	varchar2(128)		NOT NULL,
	renamed_filename	varchar2(128)		NOT NULL,
	board_no number		NOT NULL,
    
    constraint pk_board_images primary key (board_image_no),
    constraint fk_board_images_board_no foreign key (board_no)
                                                    references board(board_no)
                                                    on delete cascade
);

--DROP TABLE BOARD_INFO;
CREATE TABLE BOARD_INFO (
	board_info_no	number		NOT NULL,
	board_no	number		NOT NULL,
	product_no	number		NOT NULL,
	amount	number		NOT NULL,
    
    constraint pk_board_info primary key (board_info_no),
    constraint fk_board_info_board_no foreign key (board_no)
                                                references board(board_no)
                                                on delete cascade,
    constraint fk_board_info_product_no foreign key (product_no)
                                                references product(product_no)
                                                on delete cascade
);

--DROP TABLE CS;
CREATE TABLE CS (
	cs_no	number		NOT NULL,
	title	varchar2(128)		NOT NULL,
	content	varchar2(3000)		NOT NULL,
	member_id	varchar2(100)		NOT NULL,
	reg_date	date	DEFAULT sysdate	NOT NULL,
	secret	number	DEFAULT 0	NOT NULL,
	notice	number	DEFAULT 0	NOT NULL,
    
    constraint pk_cs primary key (cs_no),
    constraint fk_cs_member_id foreign key (member_id)
                                       references member (member_id)
                                       on delete cascade
);

--DROP TABLE CS_IMAGES;
CREATE TABLE CS_IMAGES (
	cs_image_no	number		NOT NULL,
	original_filename	varchar2(256)		NOT NULL,
	renamed_filename	varchar2(256)		NOT NULL,
	cs_no	number		NOT NULL,
    
    constraint pk_cs_images primary key (cs_image_no),
    constraint fk_cs_images_cs_no foreign key (cs_no)
                                          references cs (cs_no)
                                          on delete cascade
);

--DROP TABLE CS_REPLY;
CREATE TABLE CS_REPLY (
	cs_reply_no	number		NOT NULL,
	content	varchar2(300)		NOT NULL,
	reg_date	date	DEFAULT sysdate	NOT NULL,
	cs_no	number		NOT NULL,
    
    constraint pk_cs_reply primary key (cs_reply_no),
    constraint fk_cs_reply_cs_no foreign key (cs_no)
                                          references cs (cs_no)
                                          on delete cascade
);

--DROP TABLE CART;
CREATE TABLE CART (
	member_id	varchar2(100)		NOT NULL,
	product_no	number		NOT NULL,
	amount	number	DEFAULT 0	NOT NULL,
    
    constraint pk_cart primary key (member_id, product_no),
    constraint fk_cart_member_id foreign key (member_id)
                                         references member (member_id)
                                         on delete cascade,
    constraint fk_cart_product_no foreign key (product_no)
                                         references product (product_no)
                                         on delete cascade
);

--DROP TABLE PURCHASE;
CREATE TABLE PURCHASE (
	purchase_no	number		NOT NULL,
	member_id	varchar2(100)		NOT NULL,
	purchase_date	date	DEFAULT sysdate	NOT NULL,
    
    constraint pk_purchase primary key (purchase_no),
    constraint fk_purchase_member_id foreign key (member_id)
                                                references member (member_id)
                                                on delete cascade
);

--DROP TABLE PURCHASE_LOG;
CREATE TABLE PURCHASE_LOG (
	purchase_log_no	number		NOT NULL,
	purchase_no	number		NOT NULL,
	product_no	number		NOT NULL,
	amount	number		NOT NULL,
    status number DEFAULT 0 NOT NULL,
    
    constraint pk_purchase_log primary key (purchase_log_no),
    constraint fk_purchase_log_purchase_no foreign key (purchase_no)
                                                      references purchase (purchase_no)
                                                      on delete cascade
);

--DROP TABLE RETURN;
CREATE TABLE RETURN (
	return_no	 number		NOT NULL,
	status	char(1)		NOT NULL,
	purchase_log_no	number		NOT NULL,
	content	varchar2(1000)		NOT NULL,
    amount number NOT NULL,
	confirm	number	DEFAULT 0	NOT NULL,
    
    constraint pk_return primary key (return_no),
    constraint fk_return_purchase_log_no foreign key (purchase_log_no)
                                                   references purchase_log(purchase_log_no)
                                                   on delete cascade
);

--DROP TABLE RETURN_IMAGES;
CREATE TABLE RETURN_IMAGES (
	return_image_no	number		NOT NULL,
	original_filename	varchar2(256)		NOT NULL,
	renamed_filename	varchar2(256)		NOT NULL,
	return_no number		NOT NULL,
    
    constraint pk_return_images primary key(return_image_no),
    constraint fk_return_images_return_no foreign key(return_no)
                                                    references return(return_no)
                                                    on delete cascade
);

--DROP TABLE REVIEW;
CREATE TABLE REVIEW (
	review_no	number		NOT NULL,
	purchase_log_no	number		NOT NULL,
	comments 	varchar2(300)		NULL,
	score 	number		NOT NULL,
	reg_date	date	DEFAULT sysdate	NOT NULL,
    
    constraint pk_review primary key (review_no),
    constraint fk_review_purchase_log_no foreign key(purchase_log_no)
                                                   references purchase_log(purchase_log_no)
                                                   on delete cascade
);

--DROP TABLE QUIT_MEMBER;
CREATE TABLE QUIT_MEMBER (
	member_id	varchar2(100)		NOT NULL,
	member_pwd	varchar2(300)		NOT NULL,
	member_name	varchar2(128)		NOT NULL,
	gender	char(1)		NOT NULL,
	phone	char(11)		NOT NULL,
	enroll_date	date	NOT NULL,
	quit_date	date	DEFAULT sysdate	NOT NULL
);

--DROP TABLE DELETE_CS;
CREATE TABLE DELETE_CS (
	cs_no	number		NOT NULL,
	title	varchar2(128)		NOT NULL,
	content	varchar2(3000)		NOT NULL,
	member_id	varchar2(100)		NOT NULL,
	reg_date	date	NOT NULL,
	secret	number	NOT NULL,
	notice	number	NOT NULL,
	delete_date	date	DEFAULT sysdate	NOT NULL
);

--DROP TABLE DELETE_BOARD;
CREATE TABLE DELETE_BOARD (
	board_no	number		NOT NULL,
	category	char(3)		NOT NULL,
	title	varchar2(128)		NOT NULL,
	content	varchar2(3000)		NOT NULL,
	emp_id	varchar2(15)		NOT NULL,
	reg_date	date	NOT NULL,
	delete_date	date	DEFAULT sysdate	NOT NULL
);

--DROP TABLE DELETE_PRODUCT;
CREATE TABLE DELETE_PRODUCT (
	product_no	number		NOT NULL,
	product_name	varchar2(256)		NOT NULL,
	reg_date	date	NOT NULL,
	category	varchar2(128)		NOT NULL,
	content	varchar2(4000)		NOT NULL,
	price	number		NOT NULL,
    emp_id varchar2(15) NOT NULL,
	delete_date	date	DEFAULT sysdate	NOT NULL
);

--DROP TABLE DELETE_EMP;
CREATE TABLE DELETE_EMP (
	emp_id	varchar2(15)		NOT NULL,
	emp_pwd	varchar2(300)		NOT NULL,
	emp_name	varchar2(256)		NOT NULL,
	addr1	varchar2(512)		NOT NULL,
	addr2	varchar2(512)		NOT NULL,
	addr3	varchar2(512)		NOT NULL,
	phone	char(11)		NOT NULL,
	enroll_date	date	NOT NULL,
	status	char(1)		NOT NULL,
	delete_date	date	DEFAULT sysdate	NOT NULL
);

--======================================
-- 시퀀스
--======================================
create sequence seq_product_no;
create sequence seq_product_image_no;
create sequence seq_product_main_image_no;
create sequence seq_stock_no;
create sequence seq_request_no;
create sequence seq_io_no;
create sequence seq_receive_no;
create sequence seq_board_no;
create sequence seq_board_reply_no;
create sequence seq_board_image_no;
create sequence seq_board_info_no;
create sequence seq_cs_no;
create sequence seq_cs_image_no;
create sequence seq_cs_reply_no;
create sequence seq_purchase_no;
create sequence seq_purchase_log_no;
create sequence seq_return_no;
create sequence seq_return_image_no;
create sequence seq_review_no;

--===================================
--샘플데이터
--===================================
--상품 카테고리별로 10개씩 대표사진 3개
--회원 15명 -> 배송지 한사람당 0개 이상 마음 내키는 대로 한사함당 최대 3개만
--지점 5개
insert into spring.EMP values ('toy1', '$2a$10$k.3/YgT3TnTn0gGODrslJOQvQhOuvZlnAYlbCqmryMjlMllziCM2q', '강남점', 06234, '서울특별시 강남구 테헤란로14길 8(역삼동)', '1층', '07012341234', default, 1);
insert into spring.EMP values ('toy2', '$2a$10$k.3/YgT3TnTn0gGODrslJOQvQhOuvZlnAYlbCqmryMjlMllziCM2q', '역삼점', 06220, '서울특별시 강남구 역삼동 테헤란로 212', '2층', '07013246432', default, 1);
insert into spring.EMP values ('toy3', '$2a$10$k.3/YgT3TnTn0gGODrslJOQvQhOuvZlnAYlbCqmryMjlMllziCM2q', '부산점', 47216, '부산광역시 부산진구 연수로11번길 1(양정동)', '1층', '07085321234', default, 1);
insert into spring.EMP values ('toy4', '$2a$10$k.3/YgT3TnTn0gGODrslJOQvQhOuvZlnAYlbCqmryMjlMllziCM2q', '광주점', 61937, '광주광역시 서구 무진대로 904(광천동)', '1층', '07057328628', default, 1);
insert into spring.EMP values ('toy5', '$2a$10$k.3/YgT3TnTn0gGODrslJOQvQhOuvZlnAYlbCqmryMjlMllziCM2q', '대구점', 41931, '대구광역시 중구 달성로 22(동산동)', '1층', '07085767552', default, 1);
--제조사 10개
insert into spring.EMP values
('alter',1234, '알터',01693,'서울특별시 노원구 상계2동 603-8', '1층', '0265653535', default,2);
insert into spring.EMP values
('bookia',1234, '고토부키아',04044,'서울특별시 마포구 서교동 신촌로6길 17', '6층', '0317133010', default,2);
insert into spring.EMP values
('wave',1234, '웨이브',02830,'서울특별시 성북구 동소문동6가 동소문로15길 8', '4층', '029048899', default,2);
insert into spring.EMP values
('smiles',1234, '굿스마일즈',05116,'서울특별시 광진구 구의3동 광나루로56길 85', '1층', '024347799', default,2);
insert into spring.EMP values
('megahouse',1234, '메가하우스',06014,'서울특별시 강남구 청담동 선릉로158길 3', '4층', '027974466', default,2);
insert into spring.EMP values
('okidsid',1234, '오키드시드',04039,'서교동 370-24 KR 서울특별시 마포구 홍익로 5안길 50', '2층', '0315597851', default,2);
insert into spring.EMP values
('kidoyo',1234, '카이도요',05253,'서울특별시 강동구 암사동 472-21', '1층', '025845959', default,2);
insert into spring.EMP values
('die',1234, '반다이',05028,'KR 서울특별시 광진구 자양동 224-9', ' 건흥빌딩 건프라샵 사이드7 2층', '029987585', default,2);
insert into spring.EMP values
('nami',1234, '코나미',03120,'서울특별시 종로구 창신1동 종로52길 44', '2층', '029978426', default,2);
insert into spring.EMP values
('gigafalse',1234, '기가펄스',01136,'서울특별시 강북구 번동 430-1', '4층', '0706659745', default,2);
insert into spring.EMP values
('claze',1234, '클레이즈',07782,'서울특별시 강서구 화곡2동 855-13', '1 층 아카데미 과학', '024496566', default,2);
insert into spring.EMP values
('bird',1234, '그리폰',06734,'서울특별시 서초구 서초동 서운로 18', '영진빌딩 16층', '027033321', default,2);
insert into spring.EMP values
('sega',1234, 'SEGA',06168,'서울특별시 강남구 삼성동 157-18', '하남빌딩 13층', '024439933', default,2);
insert into spring.EMP values
('freeing',1234, 'FREEing',04377,'서울특별시 용산구 한강로3가 한강대로23길 55', '9층', '0226482345', default,2);

--관리자 1
insert into EMP values
('admin', '1234', '본사관리자', '06234', '서울특별시 강남구 테헤란로14길 6', '남도빌딩', '01012341234', default, 0);
insert into member values
('admin', '1234', '본사관리자', 'M', '01012341234', default);
--고객센터 공지 2개 문의글 답변된거 4개 안된거 3개 비밀글 2개

--게시판 카테고리별로 3개씩

--(요청글은 완료된거 2개 안된거 1개)












--======================================
-- 트리거
--======================================
-- 탈퇴회원 관련 트리거
create or replace trigger trg_quit_member
    before
    delete on member
    for each row
begin
    insert into 
        quit_member 
    values(
        :old.member_id, 
        :old.member_pwd, 
        :old.member_name, 
        :old.gender, 
        :old.phone,
        :old.enroll_date,
        default
    );
end;
/

-- 삭제 고객센터 관련 트리거
create or replace trigger trg_delete_cs
    before
    delete on cs
    for each row
begin
    insert into 
        delete_cs
    values(
        :old.cs_no, 
        :old.title, 
        :old.content, 
        :old.member_id, 
        :old.reg_date,
        :old.secret,
        :old.notice,
        default
    );
end;
/

-- 삭제 게시판 관련 트리거
create or replace trigger trg_delete_board
    before
    delete on board
    for each row
begin
    insert into 
        delete_board
    values(
        :old.board_no, 
        :old.category, 
        :old.title, 
        :old.content, 
        :old.emp_id,
        :old.reg_date,
        default
    );
end;
/

-- 삭제 지점/제조사 관련 트리거
create or replace trigger trg_delete_emp
    before
    delete on emp
    for each row
begin
    insert into 
        delete_emp
    values(
        :old.emp_id, 
        :old.emp_pwd, 
        :old.emp_name, 
        :old.addr1,
        :old.addr2,
        :old.addr3,
        :old.phone,
        :old.enroll_date,
        :old.status,
        default
    );
end;
/

-- 삭제 상품 관련 트리거
create or replace trigger trg_delete_product
    before
    delete on product
    for each row
begin
    insert into 
        delete_product
    values(
        :old.product_no, 
        :old.product_name, 
        :old.reg_date, 
        :old.category, 
        :old.content,
        :old.price,
        :old.emp_id,
        default
    );
end;
/

-- 주문 로그에 insert시 입출고 로그에 출고로 insert 되는 트리거
create or replace trigger trg_purchase_log
    before
    insert on purchase_log
    for each row
begin
    insert into
        io_log
    values(
        seq_io_no.nextval,
        'O',
        :new.amount,
        default,
        :new.product_no,
        'admin',
        '온라인 - 구매'
    );
end;
/

-- 반품 수락시 입출고 로그에 입고로 insert 되는 트리거
create or replace trigger trg_return
    before
    update on return
    for each row
declare    
    v_emp_Id emp.emp_id%type;
    v_purchase_log_no purchase_log.purchase_log_no%type;
    v_product_no product.product_no%type;
begin
    if :new.confirm = 1 then
        select
            purchase_log_no
        into
            v_purchase_log_no
        from
            return
        where
            purchase_log_no = :new.purchase_log_no;
    
        select 
            product_no
        into
            v_product_no
        from 
            purchase_log
        where
            purchase_log_no = v_purchase_log_no;
            
        select
            emp_id
        into
            v_emp_id
        from 
            product
        where
            product_no = v_product_no;
            
            
        insert into
            io_log
        values(
            seq_io_no.nextval,
            'I',
            :new.amount,
            default,
            v_product_no,
            v_emp_id,
            '온라인 - 반품'
        );
    end if;
end;
/

-- 입고 수락(update)시 입출고 로그에 입고로 insert 되는 트리고
create or replace trigger trg_receive
    before
    update on receive
    for each row
declare
    v_emp_name emp.emp_name%type;
begin
    if :new.confirm = 1 then
        select
            emp_name
        into
            v_emp_name
        from
            emp
        where
            emp_id = :new.manufacturer_id;
        
        insert into
            io_log
        values(
            seq_io_no.nextval,
            'I',
            :new.amount,
            default,
            :new.product_no,
            :new.emp_id,
            v_emp_name || ' - 입고'
        );
    end if;
end;
/

-- 입출고 로그에 입고insert시 재고 반영 관련 트리거
create or replace trigger trg_io_log
    before
    insert on io_log
    for each row
begin
    update
        stock
    set
        stock = stock + :new.amount
    where
        product_no = :new.product_no and
        emp_id = :new.emp_id;
end;
/

-- 제조사가 발주 로그 확인 후 수락(update) 시 입고테이블에 insert 관련 트리거
create or replace trigger trg_request_log
    before
    update on request_log
    for each row
begin
    if :new.confirm = 1 then
        insert into
            receive
        values(
            seq_receive_no.nextval,
            :new.manufacturer_id,
            :new.amount,
            default,
            default,
            :new.product_no,
            :new.emp_id
        );
    end if;
end;
/

-- 반품신청에서 관리자가 승인/거절 하게되면 주문로그의 상태 변경
create or replace trigger trg_return_purchase_log
    before
    update on return
    for each row
begin
    if :new.confirm = 1 then
        update purchase_log
        set status = -2
        where purchase_log_no = :new.purchase_log_no;
    end if;
    if :new.confirm = -1 then
        update purchase_log
        set status = -3
        where purchase_log_no = :new.purchase_log_no;
    end if;
end;
/
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        