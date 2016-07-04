package com.hwangdang.serviceimpl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwangdang.daoimpl.BuyDaoImpl;
import com.hwangdang.vo.OrderProduct;
import com.hwangdang.vo.Orders;
import com.hwangdang.vo.Product;
import com.hwangdang.vo.ProductOption;

@Service
public class BuyServiceImpl {

	@Autowired
	private BuyDaoImpl dao;
	
	public BuyServiceImpl () { }
	
	//바로구매페이지 이동전 재고량조회
	public int getProductStockByProductId(String productId){
		return dao.selectProductStockByProductId(productId);
	}
	
	//바로구매하기 - Orders , Order_product INSERT 
	public int addProductOne(Orders orders , OrderProduct orderProduct){
		int flag = dao.insertOrdersOne(orders);
		flag = dao.insertOrderProductOne(orderProduct);
		
		return flag;
	}
	
	
	//상품 정보 조회 - Product TB 
	public Product getProductInfo(String productId){
		return dao.selectProductByProductId(productId);
	}
	//상품옵션 조회 - product_option TB 
	public ProductOption getProductOptionInfo(String optionSubName){
		return dao.selectProductOptionByLike(optionSubName);
	}
		
	// 셀러의 스토어상호명 조회 
	public String getSellerStoreName(int sellerStoreNo){
		return dao.selectSellerStoreNameByNo(sellerStoreNo);
	}
	
	//상품옵션 조회 
	public Orders getcurrentDeliveryAddress(String memberId){
		return dao.selectCurrentDeliveryAddress(memberId);
	}
	
	//orders TB조회  구매성공한후 buy-product-one-success.jsp 에서 보여주기위해  
	public Orders getOrdersByOrdersNo(String ordersNo){
		return dao.selectOrdersByOrdersNo(ordersNo);
	}
	
	// 구매시 마일리지 사용하면 마일리지 수정  
	public void setMemberMileage(Map param){
		dao.updateMemberMileage(param);
	}
}
