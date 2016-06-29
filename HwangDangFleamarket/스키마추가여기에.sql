
--스키마 추가있으면 sql 여기에 !!


--QnA게시판 비밀번호 컬럼추가 
ALTER TABLE admin_QnA ADD admin_QnA_password char(4)

--QnA게시판 답변여부 컬럼추가 
ALTER TABLE admin_QnA ADD admin_QnA_reply_exist char(1)
ALTER TABLE admin_QnA DROP COLUMN  admin_QnA_reply_exist 

-- 주문테이블 스키마 변경 배송상태 varchar -> number(1)
ALTER TABLE orders MODIFY  orders_status number(1);
