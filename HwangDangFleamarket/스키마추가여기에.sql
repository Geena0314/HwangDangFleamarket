
--스키마 추가있으면 sql 여기에 !!


--QnA게시판 비밀번호 컬럼추가 
ALTER TABLE admin_QnA ADD admin_QnA_password char(4)

--QnA게시판 답변여부 컬럼추가 
ALTER TABLE admin_QnA ADD admin_QnA_reply_exist char(1)
ALTER TABLE admin_QnA DROP COLUMN  admin_QnA_reply_exist 

