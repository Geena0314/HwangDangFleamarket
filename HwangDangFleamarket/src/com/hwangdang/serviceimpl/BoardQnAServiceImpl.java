package com.hwangdang.serviceimpl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.hwangdang.daoimpl.BoardQnADaoImpl;
import com.hwangdang.service.Service;
import com.hwangdang.vo.AdminQnA;
import com.hwangdang.vo.AdminQnAReply;


@org.springframework.stereotype.Service
public class BoardQnAServiceImpl implements Service {
	
	@Autowired
	private BoardQnADaoImpl adminDao;
	

	
	//QnA게시판 시퀀스값 조회 
	@Transactional(rollbackFor=Exception.class)
	public int getQnABoardSeq(){
		return adminDao.selectQnABoardSeq();
	}
		
	//페이징 게시판 글 등록 
	@Transactional(rollbackFor=Exception.class)
	public int registerNewQnA(AdminQnA newQnA){
		return adminDao.insertQnABoard(newQnA);
	}
	
	//페이징 게시판 리스트 조회 
	@Transactional(rollbackFor=Exception.class)
	public List getBoardList(int page){
		return adminDao.selectAllQnABoard(page);
	}
	//게시판의 전체글 갯수 조회 
	@Transactional(rollbackFor=Exception.class)
	public int getTotalItems(){
		return adminDao.selectTotalItems();
	}
	//글번호로 글조회
	@Transactional(rollbackFor=Exception.class)
	public AdminQnA getAdminQnAByNo(int no){
		return adminDao.selectByNo(no);
	}
	//글번호로 글삭제
	@Transactional(rollbackFor=Exception.class)
		public void removeAdminQnAByNo(int no){
			int cnt = adminDao.deleteByNo(no);
			/*if(cnt ==1){
				System.out.println("삭제성공");
			}*/
		}
	//글번호로 글삭제
	@Transactional(rollbackFor=Exception.class)
	public int setAdminQnAByNo(HashMap param){
		return adminDao.updateByNo(param);
	}
	
	//댓글 입력 add
	@Transactional(rollbackFor=Exception.class)
	public int addReply(AdminQnAReply reply){
		return adminDao.insertReploy(reply);
	}	
	//댓글 삭제 remove
	@Transactional(rollbackFor=Exception.class)
	public void removeReplyByNo(int replyNo , int contentNo ){
		adminDao.deleteReployByNo(replyNo ,contentNo );
	}			
	//댓글 수정 remove
	@Transactional(rollbackFor=Exception.class)
	public void setReplyByNo(HashMap param ){
		adminDao.updateReployByNo(param);
	}		  
	  
}
