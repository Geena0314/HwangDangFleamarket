package com.hwangdang.daoimpl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.hwangdang.vo.OrderProduct;
import com.hwangdang.vo.Orders;
import com.hwangdang.vo.Product;
import com.hwangdang.vo.ProductOption;

@Repository
public class BuyDaoImpl {

	
	public BuyDaoImpl(){ } 
	
	@Autowired
	private SqlSessionTemplate session;
	
	
	//재고량 조회
	@Transactional
	public int selectProductStockByProductId(String productId){
		return session.selectOne("buy.product-stock-by-productId" ,productId);
	}
	
	//orders INSERT
	@Transactional
	public int insertOrdersOne(Orders orders){
		return session.insert("buy.insert-orders" ,orders);
	}
	//order_product INSERT
	@Transactional
	public int insertOrderProductOne(OrderProduct orderProduct){
		return session.insert("buy.insert-order-product" ,orderProduct);
	}	
	//product select
	public Product selectProductByProductId(String productId){
		return session.selectOne("buy.select-product-by-productId" ,productId);
	}	
	//제품옵션조회
	public ProductOption selectProductOptionByLike(String optionSubName){
		return session.selectOne("buy.select-product-option-by-like", optionSubName);
	}
	//셀러상호명 조회 
	public String selectSellerStoreNameByNo(int sellerStoreNo){
		return session.selectOne("buy.select-seller-by-seller-store-no", sellerStoreNo);
	}
	
	//최근배송주소지 조회  
	public Orders selectCurrentDeliveryAddress(String memberId){
		return session.selectOne("buy.select-orders-by-date", memberId);
	}
	
	
}