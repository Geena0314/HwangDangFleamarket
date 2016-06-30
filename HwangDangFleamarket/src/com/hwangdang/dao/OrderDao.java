package com.hwangdang.dao;

import java.util.HashMap;

public interface OrderDao
{
	/*환불 승인 처리.
	주문상품 주문현황 변경.(환불승인처리 9번)*/
	int updateOrderProductStatus(int orderSeqNo);
	
	//주문상품 번호로 옵션 id, 구매상품수량 조회.
	HashMap<String, Object> selectOptionAmount(int orderSeqNo);
	
	//반품된 수량만큼 옵션의 재고량 증가.
	int updateOptionStock(HashMap<String, Object> map);
}