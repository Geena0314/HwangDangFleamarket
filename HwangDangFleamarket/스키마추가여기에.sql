
--스키마 추가있으면 sql 여기에 !!


--QnA게시판 비밀번호 컬럼추가 
ALTER TABLE admin_QnA ADD admin_QnA_password char(4)

--QnA게시판 답변여부 컬럼추가 
ALTER TABLE admin_QnA ADD admin_QnA_reply_exist char(1)
ALTER TABLE admin_QnA DROP COLUMN  admin_QnA_reply_exist 

--order_product 테이블에 주문현황 컬럼 추가.
ALTER TABLE order_product ADD order_product_status number(1)
ALTER TABLE order_product DROP COLUMN order_product_status

--order_product 테이블 order_product_status 타입변경
ALTER TABLE order_product MODIFY (order_product_status number(2))


	--배송완료 -  구매확정 : -1 
	--배송현황 - 입금대기중 : 0 
	--배송현황 - 결제완료 : 1
	--배송현황 - 배송준비중 : 2
	--배송현황 - 배송중 : 3
	--배송현황  - 배송완료 : 4
	--교환/환불/취소 -  교환신청 : 5
	--교환/환불/취소 -  환불신청 :  6 
	--교환/환불/취소 - 구매취소(배송전) :  7 
	--교환/환불/취소 -   교환신청 승인 : 8 
	--교환/환불/취소 -   환불신청 승인  : 9
    
ALTER TABLE order_product MODIFY order_product_status number(2);
