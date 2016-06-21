package com.hwangdang.dao;

import java.util.HashMap;
import java.util.List;

import com.hwangdang.vo.Product;
import com.hwangdang.vo.ProductOption;

public interface ProductDao 
{
	//상품 리스트 조회.  페이징 처리.
	List<Product> selectAllProduct(HashMap<String, Object> map);
	
	//상품 전체 갯수 조회.
	int selectCountProduct();
	
	//판매자번호로 상품갯수 조회.
	int selectCountProductByNo(int sellerStoreNo);
	
	//상품 메인 상품ID로 상품검색.
	Product selectProductDetailById(String productId);
	
	//상품 ID로 옵션 검색.
	List<ProductOption> selectOptionById(String productId);
	
	String selectDetailImageById(String productId);
	
	//옵션 상세 이름으로 추가가격과, 재고량 조회.
	ProductOption selectOptionStockByName(String optionName);
}