package com.hwangdang.daoimpl;

import java.util.ArrayList;
import java.util.HashMap;
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
	
	//배송현황조회 - 0:입금대기중 ,1:결제완료 , 2:배송준비중 , 3:배송중  
	@Transactional
	public List<Orders> selectOrdersMain(String buyper ){
		return session.selectList("myorder.select-diliver-status" , buyper);
	}
	//배송완료 조회  - 4: 배송완료 
	@Transactional
	public List<Orders> selectOrdersSuccess(String buyper ){
		return session.selectList("myorder.select-diliver-success" , buyper);
	}
	
	//주문 취소리스트 조회  - 5:주문취소 , 6:교환신청 , 7:환불신청
	@Transactional
	public List<Orders> selectOrdersCancel(String buyper ){
		return session.selectList("myorder.select-diliver-cancel" , buyper);
	}
	
	//0:입금대기중 ,1:결제완료 , 2:배송준비중 삭제  == 주문취소 실행 
	@Transactional
	public int deleteOrdersCancel(String orderNo ){
		return session.delete("myorder.delete-by-orderNo" , orderNo);
	}
	
	//배송중 3: 배송완료4: 를 환불신청 :6으로 변경 
	@Transactional
	public int updateOrdersStatus(HashMap<String,Object> map ){
		return session.delete("myorder.update-by-orderNo" , map);
	}
		
	
	
}
