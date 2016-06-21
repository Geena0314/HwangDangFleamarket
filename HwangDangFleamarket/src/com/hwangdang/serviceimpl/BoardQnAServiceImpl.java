package com.hwangdang.serviceimpl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.hwangdang.common.util.Constants;
import com.hwangdang.common.util.PagingBean;
import com.hwangdang.daoimpl.BoardQnADaoImpl;
import com.hwangdang.service.Service;


@org.springframework.stereotype.Service
public class BoardQnAServiceImpl implements Service {
	
	@Autowired
	private BoardQnADaoImpl adminDao;
	
	public List getBoardList(int page){
		return adminDao.selectAllQnABoard(page);
	}
	public int getTotalItems(){
		return adminDao.selectTotalItems();
	}
	
	
}
