package com.hwangdang.dao;

import java.util.List;

import com.hwangdang.vo.Notice;
import com.hwangdang.vo.Seller;

public interface SellerDao {

	int selectCountSeller();
	
	Seller selectSellerBySellerStoreNo(int sellerStoreNo);
	
	List<Notice> selectAllSeller(int page);
	
	//셀러 정보 등록
	int insertSeller(Seller seller);
}
