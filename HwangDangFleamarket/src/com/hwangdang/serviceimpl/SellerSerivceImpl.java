package com.hwangdang.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwangdang.dao.SellerDao;
import com.hwangdang.service.SellerService;

@Service
public class SellerSerivceImpl implements SellerService{

	@Autowired
	private SellerDao dao;
	
	@Override
	public int getCountSeller() {
		return dao.selectCountSeller();
	}

	@Override
	public List getAllSeller(int page) {
		return dao.selectAllSeller(page);
	}
	
}
