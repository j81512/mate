--=====================================
-- mate 계정 생성
--=====================================
--create user mate
--identified by mate
--default tablespace users;
--grant RESOURCE,CONNECT to mate;
--=====================================
-- 혹시 몰라서 
--=====================================
--grant create any job to mate;
--DROP USER mate CASCADE;
--=====================================
-- Drop 관련
--=====================================
DROP TABLE MEMBER;
DROP TABLE  EMP;
DROP TABLE PRODUCT;
DROP TABLE Address;
DROP TABLE PRODUCT_IMAGES;
DROP TABLE  IO_LOG;
DROP TABLE  CS;
DROP TABLE  CS_IMAGES;
DROP TABLE ORDER;
DROP TABLE  CART;
DROP TABLE RETURN;
DROP TABLE RETURN_IMAGE;
DROP TABLE QUIT_MEMBER;
DROP TABLE ORDER_LOG;
DROP TABLE REVIEW;
DROP TABLE BOARD_REPLY;
DROP TABLE CS_REPLY;
DROP TABLE REQUEST_LOG;
DROP TABLE BOARD;
DROP TABLE DELETE_CS;
DROP TABLE DELETE_BOARD;
DROP TABLE DELETE_PRODUCT;
DROP TABLE DELETE_EMP;
DROP TABLE RECEIVE;
DROP TABLE BOARD_INFO;
--=====================================
-- table 관련
--=====================================
CREATE TABLE MEMBER(
	member_id varchar2(15) NOT NULL,
	member_pwd varchar2(300) NOT NULL,
	member_name varchar2(12)	NOT NULL,
	gender	char(1)	NOT NULL,
	birthday	date	NOT NULL,
	phone  char(11) NOT NULL,
	enroll_date	date	default sysdate NOT NULL 
);
​
--check 라는 단어가 겹처서 missing left parenthesis 오류 is_check로 변경
CREATE TABLE Address (
	address_name	varchar2(128)	NOT NULL,
	member_id varchar2(15)	 NOT NULL,
	reciever_name	varchar2(128)	NOT NULL,
	receiver_phone	char(11)	NOT NULL,
	address	varchar2(512)	NOT NULL,
	reg_date  date DEFAULT sysdate	NOT NULL,
	is_check  number DEFAULT 0 NOT NULL 	
);
​
​
​
CREATE TABLE EMP (
	emp_id	varchar2(15)	NOT NULL,
	emp_pwd	varchar2(300)	NOT NULL,
	emp_name	varchar2(256)	NOT NULL,
	address	varchar2(512)	NOT NULL,
	phone	char(11)	NOT NULL,
	enroll_date	date	DEFAULT sysdate	NOT NULL,
	status	number	NOT NULL
);
​
-- content 4000> 커서 테이블생성 불가 일단 4000으로 수정
CREATE TABLE PRODUCT (
	product_no	number	NOT NULL,
	emp_id	varchar2(15)	NOT NULL,
	product_name	varchar2(256)	NOT NULL,
    stock	number	DEFAULT 0 NOT NULL,
	reg_date	date DEFAULT sysdate	NOT NULL,
	category	varchar2(128)	NOT NULL,
	brand	varchar2(128)	NOT NULL,
	title	varchar2(128)	NOT NULL,
	content	varchar2(4000)	NOT NULL,
	price	number	NOT NULL,
	enabled	number	DEFAULT 0	NOT NULL
);
​
​
CREATE TABLE PRODUCT_IMAGES (
	product_image_no	number	NOT NULL,
	original_filename	varchar2(256)	NOT NULL,
	renamed_filename	varchar2(256)	NOT NULL,
	product_no number	NOT NULL,
	emp_id2	varchar2(15)	NOT NULL
);
​
​
CREATE TABLE IO_LOG (
	io_no	number	NOT NULL,
	emp_id	varchar2(15)	NOT NULL,
	product_no	number	NOT NULL,
	status	char(1)	NOT NULL,
	amount	number	NOT NULL,
    io_date	date DEFAULT sysdate	NOT NULL,
	emp_id22	varchar2(15)	NOT NULL
);
​
​
CREATE TABLE CS (
	cs_no	number	NOT NULL,
	title	varchar2(128)	NOT NULL,
	content	varchar2(3000)	NOT NULL,
	member_id	varchar2(15)	NOT NULL,
	reg_date date	DEFAULT sysdate	NOT NULL,
	secret	number	DEFAULT 0	NOT NULL,
	notice	number DEFAULT 0	NOT NULL	
);
​
​
CREATE TABLE CS_IMAGES (
	cs_image_no	number	NOT NULL,
	original_filename	varchar2(256)	NOT NULL,
	renamed_filename	varchar2(256)	NOT NULL,
	cs_no	number	NOT NULL
);
​
​
CREATE TABLE CART (
	member_id	varchar2(15)	NOT NULL,
	product_no	number	NOT NULL,
	emp_id2	varchar2(15)	NOT NULL,
	amount	number	DEFAULT 0	NOT NULL
);
​
-- table name오류 invalid  -> order -> product_order
CREATE TABLE PRODUCT_ORDER (
	order_no	number	NOT NULL,
	member_id	varchar2(15)	NOT NULL,
    order_date	date	DEFAULT sysdate	NOT NULL
);
​
​
​
CREATE TABLE ORDER_LOG (
	order_log_no	number	NOT NULL,
	order_no	number	NOT NULL,
	product_no number	NOT NULL,
	amount	number	NOT NULL,
	emp_id2	varchar2(15)	NOT NULL
);
​
CREATE TABLE RETURN (
	return_no	number	NOT NULL,
	status	char(1)	NOT NULL,
	order_log_no	number	NOT NULL,
	content	varchar2(1000)	NOT NULL,
	confirm	number	DEFAULT 0	NOT NULL,
	emp_id2	varchar2(15)	NOT NULL
);
​
​
CREATE TABLE RETURN_IMAGE (
	return_image_no	number	NOT NULL,
	original_filename	varchar2(256)	NOT NULL,
	renamed_filename	varchar2(256)	NOT NULL,
	return_no	number	NOT NULL,
	emp_id2	varchar2(15)	NOT NULL
);
​
-- comment -> content로 수정 예약어로인한 생성 불가
CREATE TABLE REVIEW (
	review_no	number	NOT NULL,
	order_log_no	number	NOT NULL,
	content	varchar2(300)	NULL,
	score	number	NOT NULL,
	reg_date	date	DEFAULT sysdate	NOT NULL,
	emp_id2	varchar2(15)	NOT NULL
);
​
​
​
CREATE TABLE CS_REPLY (
	cs_reply_no	number	NOT NULL,
	content	varchar2(300)	NOT NULL,
	reg_date date	DEFAULT sysdate	NOT NULL,
	cs_no	 number	 NOT NULL
);
​
CREATE TABLE REQUEST_LOG (
	request_no	number	NOT NULL,
	emp_id	varchar2(15)	NOT NULL,
	product_no	number	NOT NULL,
	amount	number	NOT NULL,
	request_date	date	DEFAULT sysdate	NOT NULL,
	confirm	number	DEFAULT 0	NOT NULL,
	emp_id2	varchar2(15)	NOT NULL
);
​
​
​
CREATE TABLE BOARD (
	board_no	number	NOT NULL,
	category	char(3)	NOT NULL,
	title	varchar2(128)	NOT NULL,
	content	varchar2(3000)	NOT NULL,
	emp_id	varchar2(15)	NOT NULL,
	reg_date	date	DEFAULT sysdate NOT NULL,
	enabled	number	DEFAULT 0	NOT NULL
);
​
​
CREATE TABLE BOARD_REPLY (
	board_reply_no	number	NOT NULL,
	content	varchar2(1000)	NOT NULL,
	reg_date	date	DEFAULT sysdate	NOT NULL,
	board_no	number	NOT NULL,
	emp_id	varchar2(15)	NOT NULL
);
​
​
​
CREATE TABLE QUIT_MEMBER (
	member_id	varchar2(15)	NOT NULL,
	member_pwd	varchar2(300)	NOT NULL,
	member_name	varchar2(128)	NOT NULL,
	gender	char(1)	NOT NULL,
	birthday	date	NOT NULL,
	phone	char(11)	NOT NULL,
	enroll_date	date	DEFAULT sysdate	NOT NULL,
	quit_date 	date	DEFAULT sysdate	NOT NULL
);
​
​
CREATE TABLE DELETE_CS (
	cs_no	number	NOT NULL,
	title	varchar2(128)	NOT NULL,
	content	varchar2(3000)	NOT NULL,
	member_id	varchar2(15)	NOT NULL,
	reg_date	date	DEFAULT sysdate	NOT NULL,
	is_secret	number	DEFAULT 0	NOT NULL,
	notice 	number	DEFAULT 0 NOT NULL,
	delete_date	date	DEFAULT sysdate	NOT NULL
);
​
CREATE TABLE DELETE_BOARD (
	board_no	number	NOT NULL,
	category	char(3)	NOT NULL,
	title	varchar2(128)	NOT NULL,
	content	varchar2(3000)	NOT NULL,
	emp_id	varchar2(15)	NOT NULL,
	reg_date date	DEFAULT sysdate	NOT NULL,
	enabled	number	DEFAULT 0	NOT NULL,
	delete_date	date	DEFAULT sysdate	NOT NULL
);
​
​
-- content 4000으로 수정
CREATE TABLE DELETE_PRODUCT (
	product_no	number	NOT NULL,
	product_name	varchar2(256)	NOT NULL,
	stock	number	DEFAULT 0	NOT NULL,
	reg_date  	date	DEFAULT sysdate	NOT NULL,
	category	varchar2(128)	NOT NULL,
	brand	varchar2(128)	NOT NULL,
	title	varchar2(128)	NOT NULL,
	content	varchar2(4000)	NOT NULL,
	price	number	NOT NULL,
	emp_id	varchar2(15)	NOT NULL,
	enabled	number	DEFAULT 0	NOT NULL,
	delete_date	date	DEFAULT sysdate NOT NULL
);
​
​
​
CREATE TABLE DELETE_EMP (
	emp_id	varchar2(15)	NOT NULL,
	emp_pwd	varchar2(300)	NOT NULL,
	emp_name	varchar2(256)	NOT NULL,
	address	varchar2(512)	NOT NULL,
	phone	char(11)	NOT NULL,
	enroll_date date	DEFAULT sysdate	NOT NULL,
	status	char(1)	NOT NULL,
	delete_date date	DEFAULT sysdate	NOT NULL
);
​
​
​
CREATE TABLE BOARD_INFO (
	board_info_no	number	NOT NULL,
	board_no	 number	 NOT NULL,
	product_no	number	NOT NULL,
	amount	number	NOT NULL,
	emp_id2	varchar2(15)	NOT NULL
);
​
​
​
CREATE TABLE RECEIVE (
	receive_no	number	NOT NULL,
	emp_id	varchar2(15)	NOT NULL,
	amount	number	NOT NULL,
	reg_date	date	DEFAULT sysdate	NOT NULL,
	product_no	number	NOT NULL,
	confirm	number	DEFAULT 0	NOT NULL,
	receiver_id	varchar2(15)	NOT NULL
);
​
--=====================================
-- 제약 관련
--=====================================
ALTER TABLE MEMBER ADD CONSTRAINT PK_MEMBER PRIMARY KEY (
	member_id
);
​
ALTER TABLE Address ADD CONSTRAINT PK_ADDRESS PRIMARY KEY (
	address_name,
	member_id
);
​
ALTER TABLE EMP ADD CONSTRAINT PK_EMP PRIMARY KEY (
	emp_id
);
​
ALTER TABLE PRODUCT ADD CONSTRAINT PK_PRODUCT PRIMARY KEY (
	product_no,
);
​
ALTER TABLE PRODUCT_IMAGES ADD CONSTRAINT PK_PRODUCT_IMAGES PRIMARY KEY (
	product_image_no
);
​
ALTER TABLE IO_LOG ADD CONSTRAINT PK_IO_LOG PRIMARY KEY (
	io_no
);
​
ALTER TABLE CS ADD CONSTRAINT PK_CS PRIMARY KEY (
	cs_no
);
​
ALTER TABLE CS_IMAGES ADD CONSTRAINT PK_CS_IMAGES PRIMARY KEY (
	cs_image_no
);
​
ALTER TABLE CAR ADD CONSTRAINT PK_CART PRIMARY KEY (
	member_id,
	product_no,
	emp_id2
);
​
ALTER TABLE ORDER ADD CONSTRAINT PK_ORDER PRIMARY KEY (
	order_no
);
​
ALTER TABLE ORDER_LOG ADD CONSTRAINT PK_ORDER_LOG PRIMARY KEY (
	order_log_no
);
​
ALTER TABLE RETURN ADD CONSTRAINT PK_RETURN PRIMARY KEY (
	return_no
);
​
ALTER TABLE RETURN_IMAGE ADD CONSTRAINT PK_RETURN_IMAGE PRIMARY KEY (
	return_image_no
);
​
ALTER TABLE REVIEW ADD CONSTRAINT PK_REVIEW PRIMARY KEY (
	review_no
);
​
ALTER TABLE CS_REPLY ADD CONSTRAINT PK_CS_REPLY PRIMARY KEY (
	cs_reply_no
);
​
ALTER TABLE REQUEST_LOG ADD CONSTRAINT PK_REQUEST_LOG PRIMARY KEY (
	request_no
);
​
ALTER TABLE BOARD ADD CONSTRAINT PK_BOARD PRIMARY KEY (
	board_no
);
​
ALTER TABLE BOARD_REPLY ADD CONSTRAINT PK_BOARD_REPLY PRIMARY KEY (
	board_reply_no
);
​
ALTER TABLE BOARD_INFO ADD CONSTRAINT PK_BOARD_INFO PRIMARY KEY (
	board_info_no
);
​
ALTER TABLE RECEIVE ADD CONSTRAINT PK_RECEIVE PRIMARY KEY (
	receive_no
);
​
ALTER TABLE Address ADD CONSTRAINT FK_MEMBER_TO_Address_1 FOREIGN KEY (
	member_id
)
REFERENCES MEMBER (
	member_id
);
​
ALTER TABLE PRODUCT ADD CONSTRAINT FK_EMP_TO_PRODUCT_1 FOREIGN KEY (
	emp_id
)
REFERENCES EMP (
	emp_id
);
​
ALTER TABLE PRODUCT_IMAGES ADD CONSTRAINT FK_PRODUCT_TO_PRODUCT_IMAGES_1 FOREIGN KEY (
	product_no
)
REFERENCES PRODUCT (
	product_no
);
​
ALTER TABLE PRODUCT_IMAGES ADD CONSTRAINT FK_PRODUCT_TO_PRODUCT_IMAGES_2 FOREIGN KEY (
	emp_id2
)
REFERENCES PRODUCT (
	emp_id
);
​
ALTER TABLE IO_LOG ADD CONSTRAINT FK_EMP_TO_IO_LOG_1 FOREIGN KEY (
	emp_id
)
REFERENCES EMP (
	emp_id
);
​
ALTER TABLE IO_LOG ADD CONSTRAINT FK_PRODUCT_TO_IO_LOG_1 FOREIGN KEY (
	emp_id22
)
REFERENCES PRODUCT (
	emp_id
);
​
ALTER TABLE CS ADD CONSTRAINT FK_MEMBER_TO_CS_1 FOREIGN KEY (
	member_id
)
REFERENCES MEMBER (
	member_id
);
​
ALTER TABLE CS_IMAGES ADD CONSTRAINT FK_CS_TO_CS_IMAGES_1 FOREIGN KEY (
	cs_no
)
REFERENCES CS (
	cs_no
);
​
ALTER TABLE CART ADD CONSTRAINT FK_MEMBER_TO_CART_1 FOREIGN KEY (
	member_id
)
REFERENCES MEMBER (
	member_id
);
​
ALTER TABLE CART ADD CONSTRAINT FK_PRODUCT_TO_CART_1 FOREIGN KEY (
	product_no
)
REFERENCES PRODUCT (
	product_no
);
​
ALTER TABLE CART ADD CONSTRAINT FK_PRODUCT_TO_CART_2 FOREIGN KEY (
	emp_id2
)
REFERENCES PRODUCT (
	emp_id
);
​
ALTER TABLE ORDER ADD CONSTRAINT FK_MEMBER_TO_ORDER_1 FOREIGN KEY (
	member_id
)
REFERENCES MEMBER (
	member_id
);
​
ALTER TABLE ORDER_LOG ADD CONSTRAINT FK_ORDER_TO_ORDER_LOG_1 FOREIGN KEY (
	order_no
)
REFERENCES ORDER (
	order_no
);
​
ALTER TABLE ORDER_LOG ADD CONSTRAINT FK_PRODUCT_TO_ORDER_LOG_1 FOREIGN KEY (
	product_no
)
REFERENCES PRODUCT (
	product_no
);
​
ALTER TABLE ORDER_LOG ADD CONSTRAINT FK_PRODUCT_TO_ORDER_LOG_2 FOREIGN KEY (
	emp_id2
)
REFERENCES PRODUCT (
    emp_id
);
​
ALTER TABLE RETURN ADD CONSTRAINT FK_ORDER_LOG_TO_RETURN_1 FOREIGN KEY (
	order_log_no
)
REFERENCES ORDER_LOG (
	order_log_no
);
​
ALTER TABLE RETURN ADD CONSTRAINT FK_ORDER_LOG_TO_RETURN_2 FOREIGN KEY (
	emp_id2
)
REFERENCES ORDER_LOG (
	emp_id2
);
​
ALTER TABLE RETURN_IMAGE ADD CONSTRAINT FK_RETURN_TO_RETURN_IMAGE_1 FOREIGN KEY (
	return_no
)
REFERENCES RETURN (
	return_no
);
​
ALTER TABLE RETURN_IMAGE ADD CONSTRAINT FK_RETURN_TO_RETURN_IMAGE_2 FOREIGN KEY (
	emp_id2
)
REFERENCES RETURN (
	emp_id2
);
​
ALTER TABLE REVIEW ADD CONSTRAINT FK_ORDER_LOG_TO_REVIEW_1 FOREIGN KEY (
	order_log_no
)
REFERENCES ORDER_LOG (
	order_log_no
);
​
ALTER TABLE REVIEW ADD CONSTRAINT FK_ORDER_LOG_TO_REVIEW_2 FOREIGN KEY (
	emp_id2
)
REFERENCES ORDER_LOG (
	emp_id2
);
​
ALTER TABLE CS_REPLY ADD CONSTRAINT FK_CS_TO_CS_REPLY_1 FOREIGN KEY (
	cs_no
)
REFERENCES CS (
	cs_no
);
​
ALTER TABLE REQUEST_LOG ADD CONSTRAINT FK_EMP_TO_REQUEST_LOG_1 FOREIGN KEY (
	emp_id
)
REFERENCES EMP (
	emp_id
);
​
ALTER TABLE REQUEST_LOG ADD CONSTRAINT FK_PRODUCT_TO_REQUEST_LOG_1 FOREIGN KEY (
	product_no
)
REFERENCES PRODUCT (
	product_no
);
​
ALTER TABLE REQUEST_LOG ADD CONSTRAINT FK_PRODUCT_TO_REQUEST_LOG_2 FOREIGN KEY (
	emp_id22
)
REFERENCES PRODUCT (
	emp_id
);
​
ALTER TABLE BOARD ADD CONSTRAINT FK_EMP_TO_BOARD_1 FOREIGN KEY (
	emp_id
)
REFERENCES EMP (
	emp_id
);
​
ALTER TABLE BOARD_REPLY ADD CONSTRAINT FK_BOARD_TO_BOARD_REPLY_1 FOREIGN KEY (
	board_no
)
REFERENCES BOARD (
	board_no
);
​
ALTER TABLE BOARD_REPLY ADD CONSTRAINT FK_EMP_TO_BOARD_REPLY_1 FOREIGN KEY (
	emp_id
)
REFERENCES EMP (
	emp_id
);
​
ALTER TABLE BOARD_INFO ADD CONSTRAINT FK_BOARD_TO_BOARD_INFO_1 FOREIGN KEY (
	board_no
)
REFERENCES BOARD (
	board_no
);
​
ALTER TABLE BOARD_INFO ADD CONSTRAINT FK_PRODUCT_TO_BOARD_INFO_1 FOREIGN KEY (
	product_no
)
REFERENCES PRODUCT (
	product_no
);
​
ALTER TABLE BOARD_INFO ADD CONSTRAINT FK_PRODUCT_TO_BOARD_INFO_2 FOREIGN KEY (
	emp_id2
)
REFERENCES PRODUCT (
	emp_id
);
​
ALTER TABLE RECEIVE ADD CONSTRAINT FK_EMP_TO_RECEIVE_1 FOREIGN KEY (
	emp_id
)
REFERENCES EMP (
	emp_id
);
​
ALTER TABLE RECEIVE ADD CONSTRAINT FK_PRODUCT_TO_RECEIVE_1 FOREIGN KEY (
	product_no
)
REFERENCES PRODUCT (
	product_no
);
​
ALTER TABLE RECEIVE ADD CONSTRAINT FK_PRODUCT_TO_RECEIVE_2 FOREIGN KEY (
	receiver_id
)
REFERENCES PRODUCT (
	emp_id
);