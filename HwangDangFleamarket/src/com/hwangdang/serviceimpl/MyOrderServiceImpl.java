package com.hwangdang.serviceimpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwangdang.common.util.Constants;
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
		HashMap<String ,Object> map = new HashMap<>();
		map.put("page", page);
		map.put("itemPerPage", Constants.ITEMS_PER_PAGE);
		map.put("buyer", buyer);
		List<Orders> list = dao.selectOrdersMain(map);
		return list;
	}
	public List<Orders> getOrdersCancel(String buyer ,int page){
		return dao.selectOrdersCancel(buyer , page);
	}
	
	public List<Orders> getOrdersSuccess(String buyer,int page){
		return dao.selectOrdersSuccess(buyer,page);
	}
	
	
	//0:입금대기중 ,1:결제완료 , 2:배송준비중   ==> 주문취소 실행 
	public int setOrderStatus(ArrayList<String> param, int status){
		int cnt = 0;
		for(int i=0;  i< param.size();  i++){
			HashMap<String,Object> map = new HashMap<>();
			map.put("no", param.get(i));
			map.put("status", status);
			cnt = dao.updateOrdersStatus(map);
		}
		return cnt;
	}
	
	//셀러 정보 조회 1명 
	public Seller getSellerDetailBySellerName(String sellerName){
		return dao.selectSellerBySellerName(sellerName);
	}
	//전체튶플수 조회 -Orders TB  
	public int getOrdersTotalItems(Map<String ,Integer> param ){
		return dao.selectOrdersTotalItems( param );
	}
	
	
	
	//교환신청 요청사항 처리 : 글 + 내용  
		public int addExchageRequest(ExchangeRequest exchage){
			return dao.insertExchangeRequestByOrdersNo(exchage);
		}
		
	
	
	
}
