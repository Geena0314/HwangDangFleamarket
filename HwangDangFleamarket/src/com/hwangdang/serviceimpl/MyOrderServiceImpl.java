package com.hwangdang.serviceimpl;

import java.util.ArrayList;
import java.util.HashMap;
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
	
	
	public List<Orders> getOrdersMain(String buyer){
		return dao.selectOrdersMain(buyer);
	}
	public List<Orders> getOrdersSuccess(String buyer){
		return dao.selectOrdersSuccess(buyer);
	}
	public List<Orders> getOrdersCancel(String buyer){
		return dao.selectOrdersCancel(buyer);
	}
	
	//0:입금대기중 ,1:결제완료 , 2:배송준비중 삭제  == 주문취소 실행 
	public void removeOrderList(ArrayList<String> param){
		int flag = 0;
		for(int i=0;  i<param.size();  i++){
			flag = dao.deleteOrdersCancel(param.get(i));
			System.out.println("flag:"+flag + "개 삭제성공");
			if(flag == 0){
				break;  
			}
		}
	} // 메소드
	
	//0:입금대기중 ,1:결제완료 , 2:배송준비중 삭제  == 주문취소 실행 
	public void setOrderStatus(ArrayList<String> param){
		int flag = 0;
		for(int i=0;  i< param.size();  i++){
			flag = dao.updateOrdersStatus(param.get(i));
			System.out.println("flag:"+flag + "개 환불신청 변경 성공");
			if(flag == 0){
				break;  
			}
		}
	} // 메소드
	
	
}
