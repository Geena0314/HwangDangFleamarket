package com.hwangdang.dao;

import java.util.List;

import com.hwangdang.vo.Notice;
import com.hwangdang.vo.Seller;

public interface SellerDao {

	int selectCountSeller();
	
	Seller selectSellerBySellerStoreNo(int sellerStoreNo);
	
	List<Notice> selectAllSeller(int page);
}
