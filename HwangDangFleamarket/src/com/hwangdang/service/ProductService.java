package com.hwangdang.service;

import java.util.HashMap;

public interface ProductService 
{
	//상품 리스트 조회. 페이징 처리.
	HashMap<String, Object> selectAllProduct(int page);
}