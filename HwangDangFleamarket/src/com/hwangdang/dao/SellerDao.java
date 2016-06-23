package com.hwangdang.dao;

import java.util.List;

import com.hwangdang.vo.Notice;

public interface SellerDao {

	int selectCountSeller();
	
	List<Notice> selectAllSeller(int page);
}
