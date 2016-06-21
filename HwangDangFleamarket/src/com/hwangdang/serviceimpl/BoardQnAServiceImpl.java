package com.hwangdang.serviceimpl;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;

import com.hwangdang.common.util.Constants;
import com.hwangdang.common.util.PagingBean;
import com.hwangdang.daoimpl.BoardQnADaoImpl;
import com.hwangdang.service.Service;


@org.springframework.stereotype.Service
public class BoardQnAServiceImpl implements Service {
	
	@Autowired
	private BoardQnADaoImpl adminDao;
	
	public HashMap getBoardList(){
		HashMap<String ,Object> map = new HashMap<>();
		PagingBean pasingBean = new PagingBean(getTotalItems() ,Constants.ITEMS_PER_PAGE);
		map.put("list", adminDao.selectAllQnABoard());
		map.put("pasingBean", pasingBean);
		return map;
	}
	public int getTotalItems(){
		return adminDao.selectTotalItems();
	}
	
	
}
