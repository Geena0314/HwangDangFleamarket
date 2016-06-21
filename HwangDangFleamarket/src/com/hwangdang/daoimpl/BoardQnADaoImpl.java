package com.hwangdang.daoimpl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hwangdang.dao.Dao;

@Repository
public class BoardQnADaoImpl implements Dao {

	@Autowired
	private SqlSessionTemplate session;

	//QnA게시판 전체 조회
	public List selectAllQnABoard(){
		return session.selectList("boardQnA.select-list");
	}
	public int selectTotalItems(){
		return session.selectOne("boardQnA.select-list-count");
	}
	
}
