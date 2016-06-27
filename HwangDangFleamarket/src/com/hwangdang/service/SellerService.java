package com.hwangdang.service;

import java.util.List;

import com.hwangdang.vo.Seller;

public interface SellerService {
	
	public int getCountSeller();
	
	public Seller getSellerBySellerStoreNo(int sellerStoreNo);
	
	public List getAllSeller(int page);
	
	//셀러 정보 등록
	int insertSeller(Seller seller);
}
