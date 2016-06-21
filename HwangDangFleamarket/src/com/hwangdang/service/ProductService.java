package com.hwangdang.service;

import java.util.HashMap;

import com.hwangdang.vo.ProductOption;

public interface ProductService 
{
	//상품 리스트 조회. 페이징 처리.
	HashMap<String, Object> selectAllProduct(int page, int sellerStoreNo);
	
	//상품 상세정보 조회. 아이디로.
	HashMap<String, Object> selectProductDetailById(String productId);
	
	//옵션세부내용으로 재고량과 추가가격 조회.
	ProductOption selectOptionStockByName(String optionName);
}