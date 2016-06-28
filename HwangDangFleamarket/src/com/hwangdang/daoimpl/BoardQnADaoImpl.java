package com.hwangdang.daoimpl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.hwangdang.common.util.Constants;
import com.hwangdang.dao.Dao;
import com.hwangdang.vo.AdminQnA;
import com.hwangdang.vo.AdminQnAReply;

@Repository
public class BoardQnADaoImpl implements Dao {

	@Autowired
	private SqlSessionTemplate session;

	//QnA게시판 전체 조회 -페이징
	
	public List selectAllQnABoard(int page){
		HashMap<String ,Object> map = new HashMap();
		map.put("page", page);
		map.put("itemPerPage", Constants.ITEMS_PER_PAGE);
		return session.selectList("boardQnA.select-list-paging" , map);
	}
	//게시판 전체글갯수 조회 
	public int selectTotalItems(){
		return session.selectOne("boardQnA.select-list-count");
	}
	
	//글번호로 게시글 조회
	public AdminQnA selectByNo(int no){
		session.update("boardQnA.update-hit", no);
		return session.selectOne("boardQnA.select-one-detail" ,no);
	}
	//글번호로 게시글 삭제
	public int deleteByNo(int no){
		return session.delete("boardQnA.delete-by-no", no);
	}
	//글번호로 게시글 수정변경 
	public void updateByNo(HashMap param){
		session.update("boardQnA.update-by-no", param);
	}
	//댓글등록 add
	public void insertReploy(AdminQnAReply reply){
		session.insert("boardQnA.insert-reply", reply);
	}
	//댓글삭제 remove
	public void deleteReployByNo(int no){
		session.delete("boardQnA.delete-reply-by-no", no);
	}
	//댓글수정 update
	public void updateReployByNo(HashMap param){
		session.update("boardQnA.update-reply-by-no", param);
	}
	
}
