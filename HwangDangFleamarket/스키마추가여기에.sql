
--스키마 추가있으면 sql 여기에 !!


--QnA게시판 비밀번호 컬럼추가 
ALTER TABLE admin_QnA ADD admin_QnA_password char(4)

--QnA게시판 답변여부 컬럼추가 
ALTER TABLE admin_QnA ADD admin_QnA_reply_exist char(1)
ALTER TABLE admin_QnA DROP COLUMN  admin_QnA_reply_exist 


	--배송현황 - 입금대기중 : 0 
	--배송현황 - 결제완료 : 1
	--배송현황 - 배송준비중 : 2
	--배송현황 - 배송중 : 3
	--배송완료 - 배송완료 : 4
	--교환/환불/취소 -  교환신청 : 5
	--교환/환불/취소 -  환불신청 :  6 
	--교환/환불/취소 - 구매취소(배송전) :  7 
-- 
ALTER TABLE orders MODIFY  orders_status number(1);
    

    
-- order_product TB 스키마 변경 
--1
drop table order_product
--2
CREATE TABLE order_product  (
	order_seq_no number primary key ,  -- PK 
	order_amount number(4) not null, /* 상품수량  */
	orders_no VARCHAR2(10) not null, /* 주문번호 FK */
	product_id VARCHAR2(30) not null, /* 상품ID FK */
	option_id number not null ,      --  상품옵션ID_FK  
	seller_store_no number not null,     -- 판매자스토어NO_FK
	foreign key(orders_no) references orders(orders_no) on delete cascade,
	foreign key(product_id) references product(product_id) on delete set null ,
	foreign key(option_id) references product_option(option_id) on delete set null ,
	foreign key(seller_store_no) references seller(seller_store_no) on delete set null
);
--3
insert into order_product values (order_product_seq.nextval , 5, 'order_no43', '상품id1', 12 , 15 );
insert into order_product values (order_product_seq.nextval ,4, 'order_no17', '상품id2', 13, 15 );
insert into order_product values (order_product_seq.nextval ,4, 'order_no37', '상품id3', 14, 15 );
insert into order_product values (order_product_seq.nextval ,1, 'order_no28', '상품id4', 15, 16);
insert into order_product values (order_product_seq.nextval ,2, 'order_no13', '상품id5', 16, 16);
insert into order_product values (order_product_seq.nextval ,1, 'order_no11', '상품id6', 17, 16);
insert into order_product values (order_product_seq.nextval , 1, 'order_no42', '상품id7', 18, 17);
insert into order_product values (order_product_seq.nextval ,4, 'order_no34', '상품id1', 12, 17);

