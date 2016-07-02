
SELECT * FROM cart

/* 장바구니vvvvvvv */
CREATE TABLE cart (
	cart_no NUMBER primary key,/* 장바구니 번호 */
	cart_product_amount NUMBER(4) NOT NULL, /* 장바구니 상품수량 */
	cart_product_option VARCHAR2(100) NOT NULL, /* 장바구니 선택옵션 */
	product_id VARCHAR2(30) NOT NULL, /* 상품ID */
	member_id VARCHAR2(30) NOT NULL, /* 아이디 */
	foreign key(product_id) references product(product_id),
	foreign key(member_id) references member(member_id)
);


SELECT * FROM  notice
SELECT * FROM  product_detail_image


SELECT * FROM store_QnA_reply 
CREATE TABLE store_QnA_reply (
	store_reply_writer VARCHAR2(30) NOT NULL, /* 작성자 */
	store_reply_content varchar2(4000) NOT NULL, /* 내용 */
	store_reply_date DATE NOT NULL, /* 작성일 */
	storeQnA_no NUMBER primary key /* QnA번호 */,
	foreign key(storeQnA_no) references store_qna(storeQnA_no) on delete cascade
);



SELECT * FROM store_QnA  
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

SELECT * FROM review   

SELECT * FROM exchange_request 
SELECT * FROM  refund_request
SELECT * FROM  code

SELECT * FROM category
SELECT * FROM  seller_notice 

SELECT * FROM PRODUCT

SELECT product_stock 
FROM   product
WHERE product_id = '상품id4'

update PRODUCT
SET product_stock = 3
WHERE product_id = '상품id4'
