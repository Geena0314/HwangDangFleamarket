package com.hwangdang.daoimpl;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.hwangdang.dao.MyOrderDao;
import com.hwangdang.vo.Orders;

@Repository
public class MyOrderDaoImpl implements MyOrderDao {

	@Autowired
	private SqlSessionTemplate session;
	
	public MyOrderDaoImpl() { }
	
	@Transactional
	public List<Orders> selectOrders(String buyerId){
		return session.selectList("myorder.select-diliver-status" , buyerId);
	}
	
}
