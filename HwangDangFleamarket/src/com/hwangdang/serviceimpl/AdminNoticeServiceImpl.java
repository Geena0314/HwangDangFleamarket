package com.hwangdang.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwangdang.dao.AdminNoticeDao;
import com.hwangdang.service.AdminNoticeService;

@Service
public class AdminNoticeServiceImpl implements AdminNoticeService{
	
	@Autowired
	private AdminNoticeDao dao;

	@Override
	public List getAllNotice(int page) {
		return dao.selectAllNotice(page);
	}

	@Override
	public int getCountNotice() {
		return dao.selectCountNotice();
	}
}
