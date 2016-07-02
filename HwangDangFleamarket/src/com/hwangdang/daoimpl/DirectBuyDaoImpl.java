package com.hwangdang.daoimpl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class DirectBuyDaoImpl {

	
	public DirectBuyDaoImpl(){ } 
	
	@Autowired
	private SqlSessionTemplate session;
	
	
	//재고량 조회
	@Transactional
	public int selectProductStockByProductId(String productId){
		return session.selectOne("directBuy.product-stock-by-productId" ,productId);
	}
}
