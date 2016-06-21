package com.hwangdang.daoimpl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hwangdang.common.util.Constants;
import com.hwangdang.dao.Dao;

@Repository
public class BoardQnADaoImpl implements Dao {

	@Autowired
	private SqlSessionTemplate session;

	//QnA게시판 전체 조회
	public List selectAllQnABoard(int page){
		HashMap<String ,Object> map = new HashMap();
		map.put("page", page);
		map.put("itemPerPage", Constants.ITEMS_PER_PAGE);
		return session.selectList("boardQnA.select-list-paging" , map);
	}
	public int selectTotalItems(){
		return session.selectOne("boardQnA.select-list-count");
	}
	
}
