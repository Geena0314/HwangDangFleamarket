package com.hwangdang.serviceimpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwangdang.daoimpl.DirectBuyDaoImpl;

@Service
public class DirectBuyServiceImpl {

	@Autowired
	private DirectBuyDaoImpl dao;
	
	public DirectBuyServiceImpl () { }
	
	//바로구매페이지 이동전 재고량조회
	public int getProductStockByProductId(String productId){
		return dao.selectProductStockByProductId(productId);
	}
	
}
