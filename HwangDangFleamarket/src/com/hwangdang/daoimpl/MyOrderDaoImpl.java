package com.hwangdang.daoimpl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hwangdang.dao.MyOrderDao;

@Repository
public class MyOrderDaoImpl implements MyOrderDao {

	@Autowired
	private SqlSessionTemplate session;
	
	public MyOrderDaoImpl() { }
	
}
