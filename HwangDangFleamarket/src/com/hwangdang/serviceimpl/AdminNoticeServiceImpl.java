package com.hwangdang.serviceimpl;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwangdang.common.util.Constants;
import com.hwangdang.common.util.PagingBean;
import com.hwangdang.dao.AdminNoticeDao;
import com.hwangdang.service.AdminNoticeService;

@Service
public class AdminNoticeServiceImpl implements AdminNoticeService{
	
	@Autowired
	private AdminNoticeDao dao;
	
	@Override
	public HashMap<String, Object> selectAllNotice() {
		HashMap<String ,Object> map = new HashMap<>();
		PagingBean pasingBean = new PagingBean(dao.selectCountNotice() ,Constants.ITEMS_PER_PAGE);
		map.put("list", dao.selectAllNotice(map));
		map.put("pasingBean", pasingBean);
		return map;
	}
}
