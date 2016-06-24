package com.hwangdang.dao;

import java.util.List;

import com.hwangdang.vo.SellerNotice;

public interface SellerNoticeDao {
	int insertSellerNotice(SellerNotice sellerNotice);

	int updateSellerNotice(SellerNotice sellerNotice);

	int updateSellerNoticeHit(int sellerNoticeNo);

	int deleteSellerNotice(int sellerNoticeNo);

	int selectCountSellerNotice();

	List<SellerNotice> selectAllSellerNotice(int page);

	SellerNotice selectSellerNoticeByNoticeNo(int sellerNoticeNo);
}
