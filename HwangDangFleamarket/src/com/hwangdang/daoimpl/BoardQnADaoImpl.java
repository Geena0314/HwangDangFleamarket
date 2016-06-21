package com.hwangdang.daoimpl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.hwangdang.dao.Dao;

public class BoardQnADaoImpl implements Dao {

	private SqlSessionTemplate session;
	
	public BoardQnADaoImpl(SqlSessionTemplate session){
		this.session = session;
	}
	
	//QnA게시판 전체 조회
	public List selectAllQnABoard(){
		return session.selectList("boardQnA.select-list");
	}
	
}
