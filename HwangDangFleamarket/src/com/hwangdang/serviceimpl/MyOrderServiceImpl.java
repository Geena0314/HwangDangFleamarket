package com.hwangdang.serviceimpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwangdang.daoimpl.MyOrderDaoImpl;
import com.hwangdang.service.MyOrderService;
import com.hwangdang.vo.ExchangeRequest;
import com.hwangdang.vo.Orders;
import com.hwangdang.vo.RefundRequest;
import com.hwangdang.vo.Seller;

@Service
public class MyOrderServiceImpl implements MyOrderService {

	@Autowired
	private MyOrderDaoImpl dao;

	public MyOrderServiceImpl() { } 
	
	//나의주문 - 메인페이지 
	public List<Orders> getOrdersMain(String buyer , int page ){
		List<Orders> list = dao.selectOrdersMain(buyer , page);
		return list;
	}
	public List<Orders> getOrdersSuccess(String buyer){
		return dao.selectOrdersSuccess(buyer);
	}
	public List<Orders> getOrdersCancel(String buyer){
		return dao.selectOrdersCancel(buyer);
	}
	
	//0:입금대기중 ,1:결제완료 , 2:배송준비중 삭제  == 주문취소 실행 
	public void setOrderStatus(ArrayList<String> param, int status){
		int flag = 0;
		HashMap<String,Object> map = new HashMap<>();
		for(int i=0;  i< param.size();  i++){
			map.put("no", param.get(i));
			map.put("status", status);
			flag = dao.updateOrdersStatus(map);
			//System.out.println("flag:"+flag + "개 환불/교환 신청 변경 성공");
			if(flag == 0){
				break;  
			}
		}
	} // 메소드
	
	//셀러 정보 조회 1명 
	public Seller getSellerDetailBySellerName(String sellerName){
		return dao.selectSellerBySellerName(sellerName);
	}
	//전체튶플수 조회 -Orders TB 
	public int getOrdersTotalItems(){
		return dao.selectOrdersTotalItems();
	}
	
	//교환신청 요청사항 처리 : 글 + 내용  
		public int addExchageRequest(ExchangeRequest exchage){
			return dao.insertExchangeRequestByOrdersNo(exchage);
		}
		
	
	
	
}
