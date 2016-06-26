package com.hwangdang.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.hwangdang.daoimpl.BoardQnADaoImpl;
import com.hwangdang.service.Service;
import com.hwangdang.vo.AdminQnA;


@org.springframework.stereotype.Service
public class BoardQnAServiceImpl implements Service {
	
	@Autowired
	private BoardQnADaoImpl adminDao;
	
	//페이징 게시판 리스트 조회 
	@Transactional(rollbackFor=Exception.class)
	public List getBoardList(int page){
		return adminDao.selectAllQnABoard(page);
	}
	//게시판의 전테글수 조회 
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
		
	  
}
