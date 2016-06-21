package com.hwangdang.dao;

import java.util.HashMap;
import java.util.List;

import com.hwangdang.vo.Product;

public interface ProductDao 
{
	//상품 리스트 조회.  페이징 처리.
	List<Product> selectAllProduct(HashMap<String, Object> map);
	int selectCountProduct();
}