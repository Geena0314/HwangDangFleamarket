package com.hwangdang.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwangdang.daoimpl.MyOrderDaoImpl;
import com.hwangdang.service.MyOrderService;
import com.hwangdang.vo.Orders;

@Service
public class MyOrderServiceImpl implements MyOrderService {

	@Autowired
	private MyOrderDaoImpl dao;

	public MyOrderServiceImpl() { } 
	
	public List<Orders> getOrders(String buyerId){
		return dao.selectOrders(buyerId);
	}
	
	
}
