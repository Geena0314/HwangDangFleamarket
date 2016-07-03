package com.hwangdang.serviceimpl;

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
	
	
	//상품 정보 조회
	public Product getProductInfo(String productId){
		return dao.selectProductByProductId(productId);
	}
	//상품옵션 조회 
		public ProductOption getProductOptionInfo(String optionSubName){
			return dao.selectProductOptionByLike(optionSubName);
		}
	
}
