package com.hwangdang.daoimpl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hwangdang.dao.SellerDao;

@Repository
public class SellerDaoImpl implements SellerDao{
	
	@Autowired
	private SqlSessionTemplate session;

	public SellerDaoImpl(){}
	

}
