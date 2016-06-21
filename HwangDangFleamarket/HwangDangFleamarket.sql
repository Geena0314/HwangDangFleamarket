/* 회원 */
DROP TABLE member 
	CASCADE CONSTRAINTS;

/* 판매자 */
DROP TABLE seller 
	CASCADE CONSTRAINTS;

/* 상품 */
DROP TABLE product 
	CASCADE CONSTRAINTS;

/* 리뷰 */
DROP TABLE review 
	CASCADE CONSTRAINTS;

/* 스토어QnA */
DROP TABLE store_QnA 
	CASCADE CONSTRAINTS;

/* 장바구니 */
DROP TABLE cart 
	CASCADE CONSTRAINTS;

/* 주문 */
DROP TABLE orders 
	CASCADE CONSTRAINTS;

/* 상품옵션 */
DROP TABLE product_option 
	CASCADE CONSTRAINTS;

/* 소식통(관리자) */
DROP TABLE notice 
	CASCADE CONSTRAINTS;

/* 관리자QnA */
DROP TABLE admin_QnA 
	CASCADE CONSTRAINTS;

/* 관리자QnA댓글 */
DROP TABLE admin_QnA_reply 
	CASCADE CONSTRAINTS;

/* 교환신청 */
DROP TABLE exchange_request 
	CASCADE CONSTRAINTS;

/* 환불신청 */
DROP TABLE refund_request
	CASCADE CONSTRAINTS;

/* 상품상세사진 */
DROP TABLE product_detail_image 
	CASCADE CONSTRAINTS;

/* 스토어QnA댓글 */
DROP TABLE store_QnA_reply 
	CASCADE CONSTRAINTS;

/* 주문상품 */
DROP TABLE order_product 
	CASCADE CONSTRAINTS;

/* 코드 */
DROP TABLE code 
	CASCADE CONSTRAINTS;

/* 카테고리 */
DROP TABLE category 
	CASCADE CONSTRAINTS;

/* 회원vvvvvvvvvvvv*/
CREATE TABLE member (
	member_id VARCHAR2(30) primary key, /* 아이디 */
	member_password VARCHAR2(20) NOT NULL, /* 비밀번호 */
	member_name VARCHAR2(18) NOT NULL, /* 이름 */
	member_phone CHAR(13) NOT NULL, /* 전화번호 */
	member_zipcode VARCHAR2(7) NOT NULL, /* 우편번호 */
	member_address VARCHAR2(180) NOT NULL, /* 주소 */
	member_sub_adress VARCHAR2(90) NOT NULL, /* 세부주소 */
	member_assign NUMBER(1) NOT NULL /* 판매자등록여부 */
);

insert into member values ('isj4216', '52545856', '이성준', '010-9977-2905', '123-456',
										   '경기도 성남시 분당구 야탑동.', '노블리치오피스텔 A동 513호', 0);
insert into member values ('lsj4216', '52545856', '판매자', '010-9977-2905', '123-456',
   										   '경기도 성남시 분당구 야탑동.', '노블리치오피스텔 B동 313호', 1);
insert into member values ('hwang', 'dang', '황경희매니저', '010-9977-2905', '123-456',
   										   '경기도 성남시 판교동 판교로.', '유스페이스 B동 8층', 0);
insert into member values ('lsj42167', '52545856', '판매자', '010-9977-2905', '123-456',
   										   '경기도 성남시 분당구 야탑동.', '노블리치오피스텔 B동 313호', 1);
insert into member values ('lsj421678', 'dang', '황경희매니저', '010-9977-2905', '123-456',
   										   '경기도 성남시 판교동 판교로.', '유스페이스 B동 8층', 1);   			  										

/* 판매자vvvvvvvvvvv */
CREATE TABLE seller (
	seller_store_no number not null unique,
	seller_store_name VARCHAR2(60) not null unique, /* 상호명 */
	seller_tax_id CHAR(11), /* 사업자번호 */
	seller_industry VARCHAR2(30) NOT NULL, /* 업종 */
	seller_sub_industry VARCHAR2(150), /* 업종 소분류 */
	seller_zipcode VARCHAR2(7) NOT NULL, /* 우편번호 */
	seller_address VARCHAR2(180) NOT NULL, /* 주소 */
	seller_sub_address VARCHAR2(90) NOT NULL, /* 세부주소 */
	seller_store_image VARCHAR2(90) NOT NULL, /* 대표사진 */
	seller_product1 VARCHAR2(30), /* 판매물품1 */
	seller_product2 VARCHAR2(30), /* 판매물품2 */
	seller_product3 VARCHAR2(30), /* 판매물품3 */
	seller_introduction VARCHAR2(4000) NOT NULL, /* 소개글 */
	member_id varchar2(30) not null,
	foreign key(member_id) references member(member_id) on delete cascade
);
drop sequence seller_store_no_seq
create sequence seller_store_no_seq nocache;
insert into seller values (seller_store_no_seq.nextval, '황당마켓1', '12345678901', '업종임', '업종소분류', '123-456',
   										   '경기도 성남시 분당구 야탑동.', '노블리치오피스텔 B동 313호', '사진임', '판매물품1', '판매물품2', '판매물품3', '소개글', 'lsj4216');
insert into seller values (seller_store_no_seq.nextval, '황당마켓2', '12345678901', '업종임', '업종소분류', '123-456',
   										   '경기도 성남시 분당구 야탑동.', '노블리치오피스텔 B동 313호', '사진임', '판매물품1', '판매물품2', '판매물품3', '소개글', 'lsj42167');
insert into seller values (seller_store_no_seq.nextval, '황당마켓3', '12345678901', '업종임', '업종소분류', '123-456',
   										   '경기도 성남시 분당구 야탑동.', '노블리치오피스텔 B동 313호', '사진임', '판매물품1', '판매물품2', '판매물품3', '소개글', 'lsj421678');   										   

/* 상품vvvvvvvvv */
drop table product
CREATE TABLE product (
	product_id VARCHAR2(30) primary key, /* 상품ID */
	product_name VARCHAR2(30) NOT NULL, /* 상품명 */
	product_price NUMBER(7) NOT NULL, /* 가격 */
	product_stock NUMBER(4) NOT NULL, /* 총재고량 */
	product_main_image VARCHAR2(90) NOT NULL, /* 상품메인사진 */
	product_info CLOB NOT NULL, /* 상품정보 */
	product_like NUMBER NOT NULL, /* 추천수 */
	seller_store_no number not null,
	foreign key(seller_store_no) references seller(seller_store_no) on delete cascade
);
--연습용 시퀀스
drop sequence product_id_seq
create sequence product_id_seq nocache;
insert into product values (to_char(product_id_seq.nextval,'0000'), '상품명', 50000, 4444, 'shoes1.jpg', '상품정보클롭', 1, 1);
insert into product values (to_char(product_id_seq.nextval,'0000'), '상품명', 50000, 4444, 'shoes1.jpg', '상품정보클롭', 1, 1);
insert into product values (to_char(product_id_seq.nextval,'0000'), '상품명', 50000, 4444, 'shoes1.jpg', '상품정보클롭', 1, 1);
insert into product values (to_char(product_id_seq.nextval,'0000'), '상품명', 50000, 4444, 'shoes1.jpg', '상품정보클롭', 1, 1);
insert into product values (to_char(product_id_seq.nextval,'0000'), '상품명', 50000, 4444, 'shoes1.jpg', '상품정보클롭', 1, 1);
insert into product values (to_char(product_id_seq.nextval,'0000'), '상품명', 50000, 4444, 'shoes1.jpg', '상품정보클롭', 1, 1);
insert into product values (to_char(product_id_seq.nextval,'0000'), '상품명', 50000, 4444, 'shoes1.jpg', '상품정보클롭', 1, 1);

insert into product values ('상품id2', '상품명', 40000, 2222, 'shoes2.jpg', '상품정보클롭', 2, 1);
insert into product values ('상품id3', '상품명', 3000, 3333, 'shoes3.jpg', '상품정보클롭', 3, 1);
insert into product values ('상품id4', '상품명', 50000, 4444, 'shoes4.jpg', '상품정보클롭', 4, 1);
insert into product values ('상품id5', '상품명', 40000, 2222, 'shoes5.jpg', '상품정보클롭', 5, 1);
insert into product values ('상품id6', '상품명', 3000, 3333, 'shoes6.jpg', '상품정보클롭', 6, 1);
insert into product values ('상품id7', '상품명', 40000, 2222, 'shoes7.jpg', '상품정보클롭', 7, 1);
insert into product values ('상품id8', '상품명', 3000, 3333, 'shoes8.jpg', '상품정보클롭', 8, 1);
select * from PRODUCT order by product_like desc

/* 리뷰 vvvvvv*/
CREATE TABLE review (
	review_no NUMBER NOT NULL, /* 리뷰번호 */
	review_content VARCHAR2(60) NOT NULL, /* 리뷰 내용 */
	review_date DATE NOT NULL, /* 작성일 */
	review_writer VARCHAR2(30) NOT NULL, /* 작성자 */
	product_id VARCHAR2(30) not null, /* 상품ID */
	foreign key(product_id) references product(product_id) on delete cascade
);
drop sequence review_no_seq
create sequence review_no_seq nocache;
insert into review values (review_no_seq.nextval, '리뷰내용', '19901126', '작성자', '상품id');
insert into review values (review_no_seq.nextval, '리뷰내용1', '19911126', '작성자1', '상품id2');
insert into review values (review_no_seq.nextval, '리뷰내용2', '19921126', '작성자2', '상품id3');


/* 스토어QnA vvvvvvvv*/
drop table store_QnA
CREATE TABLE store_QnA (
	storeQnA_no NUMBER primary key, /* QnA번호 */
	storeQnA_title VARCHAR2(30) NOT NULL, /* 문의 제목 */
	storeQnA_content VARCHAR2(4000) NOT NULL, /* 문의 내용 */
	storeQnA_hit NUMBER NOT NULL, /* 문의 조회수 */
	storeQnA_published number(1) NOT NULL, /* 문의 공개 여부 */
	storeQnA_writer VARCHAR2(30) NOT NULL,/*문의 작성자*/
	storeQnA_date DATE NOT NULL, /* 문의 작성일 */
	product_id VARCHAR2(30) not null, /* 상품ID */
	foreign key(product_id) references product(product_id) on delete cascade
);
drop sequence storeQnA_no_seq
create sequence storeQnA_no_seq nocache;
insert into store_qna values (storeQnA_no_seq.nextval, '문의 제목', '문의 내용임', 11, 0, '작성자', '19901126', '상품id');
insert into store_qna values (storeQnA_no_seq.nextval, '문의 제목2', '문의 내용임2', 1, 1, '작성자2', '19911126', '상품id2');
insert into store_qna values (storeQnA_no_seq.nextval, '문의 제목3', '문의 내용임3', 21, 1, '작성자3', '19921126', '상품id3');


/* 장바구니vvvvvvv */
CREATE TABLE cart (
	cart_product_amount NUMBER(4) NOT NULL, /* 장바구니 상품수량 */
	cart_product_option VARCHAR2(100) NOT NULL, /* 장바구니 선택옵션 */
	product_id VARCHAR2(30) NOT NULL, /* 상품ID */
	member_id VARCHAR2(30) NOT NULL, /* 아이디 */
	foreign key(product_id) references product(product_id),
	foreign key(member_id) references member(member_id)
);

/* 주문vvvvvvvvvvvvvv */
drop table orders
CREATE TABLE orders (
	orders_no VARCHAR2(10) primary key, /* 주문번호 */
	orders_receiver VARCHAR2(18) NOT NULL, /* 받는사람 */
	orders_phone CHAR(13) NOT NULL, /* 전화번호 */
	orders_zipcode VARCHAR2(7) NOT NULL, /* 우편번호 */
	orders_address VARCHAR2(180) NOT NULL, /* 주소 */
	orders_sub_address VARCHAR2(90) NOT NULL, /* 세부주소 */
	orders_total_price NUMBER NOT NULL, /* 총주문가격 */
	orders_payment VARCHAR2(21) NOT NULL, /* 결제방식 */
	orders_request VARCHAR2(51), /* 요청사항 */
	payment_status NUMBER(1) NOT NULL, /* 결제여부 */
	orders_status VARCHAR2(15) NOT NULL, /* 주문현황 */
	member_id VARCHAR2(30) NOT NULL,/* 아이디 */
	foreign key(member_id) references member(member_id)
);

/* 상품옵션vvvvvvvv */
drop table product_option
CREATE TABLE product_option (
	option_id NUMBER primary key, /* 상품옵션ID */
	option_name VARCHAR2(30) NOT NULL, /* 옵션명 */
	option_sub_name VARCHAR2(60) NOT NULL, /* 세부 옵션명 */
	option_stock NUMBER(4) NOT NULL, /* 재고량 */
	option_add_price NUMBER(7) not null, /* 추가가격 */
	product_id VARCHAR2(30) NOT NULL, /* 상품ID */
	foreign key(product_id) references product(product_id) on delete cascade
);
drop sequence option_id_seq
create sequence option_id_seq nocache;

insert into product_option values (option_id_seq.nextval, '사이즈/색상', '250/흰색', 10, 1000, '상품id');
insert into product_option values (option_id_seq.nextval, '사이즈/색상', '240/검정색', 20, 5000, '상품id');
insert into product_option values (option_id_seq.nextval, '사이즈/색상', '230/흰색', 110, 4000, '상품id');

/* 소식통(관리자) vvvvvvvv*/
CREATE TABLE notice (
	notice_no NUMBER primary key, /* 소식글 no */
	notice_title VARCHAR2(30) NOT NULL, /* 소식글 제목 */
	notice_content CLOB NOT NULL, /* 소식글 내용 */
	notice_date DATE NOT NULL, /* 소식글 작성일 */
	notice_hit NUMBER NOT NULL /* 소식글 조회수 */
);
drop sequence notice_no_seq
create sequence notice_no_seq nocache;

/* 관리자QnA vvvvvvv*/
CREATE TABLE admin_QnA (
	admin_qna_no NUMBER primary key, /* 관리자QnA no */
	admin_qna_title VARCHAR2(30) NOT NULL, /* 관리자QnA 제목 */
	admin_qna_content CLOB NOT NULL, /* 관리자QnA 내용 */
	admin_qna_writer VARCHAR2(30) NOT NULL, /* 관리자QnA 작성자id */
	admin_qna_date DATE NOT NULL, /* 관리자QnA 작성일 */
	admin_qna_hit NUMBER NOT NULL, /* 관리자QnA 조회수 */
	admin_qna_published VARCHAR2(3) NOT NULL /* 관리자QnA 공개여부 */
);
drop sequence admin_qna_no_seq
create sequence admin_qna_no_seq nocache;

/* 관리자QnA댓글 vvvvvvv*/
CREATE TABLE admin_QnA_reply (
	admin_reply_no NUMBER primary key, /* 댓글번호 */
	admin_reply_content varchar2(4000) NOT NULL, /* 내용 */
	admin_reply_date DATE NOT NULL, /* 작성일 */
	admin_reply_writer VARCHAR2(30) NOT NULL, /* 작성자 */
	admin_qna_no NUMBER not null, /* 관리자QnA no */
	foreign key(admin_qna_no) references admin_qna(admin_qna_no) on delete cascade
);
drop sequence admin_reply_no_seq
create sequence admin_reply_no_seq nocache;

/* 교환신청vvvvvvvvvv */
drop table exchange_request
CREATE TABLE exchange_request (
	exchage_title VARCHAR2(60) NOT NULL, /* 신청제목 */
	exchange_content VARCHAR2(4000) NOT NULL, /* 신청내용 */
	orders_no VARCHAR2(10) not null, /* 주문번호 */
	foreign key(orders_no) references orders(orders_no) on delete cascade
);

/* 환불신청vvvvvvvvvvvv */
CREATE TABLE refund_request (
	refund_title VARCHAR2(60) NOT NULL, /* 신청제목 */
	refund_content VARCHAR2(4000) NOT NULL, /* 신청내용 */
	orders_no VARCHAR2(10) not null, /* 주문번호 */
	foreign key(orders_no) references orders(orders_no) on delete cascade
);

/* 상품상세사진 vvvvvvv*/
CREATE TABLE product_detail_image (
	image_path VARCHAR2(90) NOT NULL, /* 이미지경로 */
	product_id VARCHAR2(30) not null, /* 상품ID */
	foreign key(product_id) references product(product_id) on delete cascade
);

/* 스토어QnA댓글 vvvvvv */
drop table store_QnA_reply
CREATE TABLE store_QnA_reply (
	store_reply_no NUMBER NOT NULL, /* 댓글번호 */
	store_reply_writer VARCHAR2(30) NOT NULL, /* 작성자 */
	store_reply_content varchar2(4000) NOT NULL, /* 내용 */
	store_reply_date DATE NOT NULL, /* 작성일 */
	storeQnA_no NUMBER not null /* QnA번호 */,
	foreign key(storeQnA_no) references store_qna(storeQnA_no) on delete cascade
);
drop sequence store_reply_no_seq
create sequence store_reply_no_seq nocache;

/* 주문상품 vvvvvvv*/
drop table order_product
CREATE TABLE order_product (
	order_amount number(4) not null, /* 상품수량 */
	orders_no VARCHAR2(10) not null, /* 주문번호 */
	product_id VARCHAR2(30) not null, /* 상품ID */
	option_id number not null,
	foreign key(orders_no) references orders(orders_no) on delete cascade,
	foreign key(product_id) references product(product_id),
	foreign key(option_id) references product_option(option_id) on delete set null
);

/* 코드 vvvvvvvv*/
CREATE TABLE code (
	code VARCHAR2(30) NOT NULL, /* 코드 */
	code_name VARCHAR2(30) NOT NULL /* 코드명 */
);

/* 카테고리 vvvvvvv*/
CREATE TABLE category (
	category_id NUMBER primary key, /* 카테고리아이디 */
	category_name VARCHAR2(30) NOT NULL, /* 카테고리명 */
	category_id_ref NUMBER NOT NULL, /* 참조아이디 */
	category_type VARCHAR2(6) NOT NULL /* 분류 */
);
drop sequence category_id_seq
create sequence category_id_seq nocache;
insert into category values (category_id_seq.nextval, '의류', 0, 'first');
insert into category values (category_id_seq.nextval, '공예', 0, 'first');
insert into category values (category_id_seq.nextval, '남성의류', 1, 'second');
insert into category values (category_id_seq.nextval, '도자기', 2, 'second');
insert into category values (category_id_seq.nextval, '여성의류', 1, 'second');
insert into category values (category_id_seq.nextval, '팔찌', 2, 'second');