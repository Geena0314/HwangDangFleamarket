package com.hwangdang.service;

import java.util.List;

import com.hwangdang.vo.SellerNotice;

public interface SellerNoticeService {
	public List getAllSellerNotice(int page);

	public int getCountSellerNotice();

	public SellerNotice getSellerNoticeByNoticeNo(int sellerNoticeNo);

	public int sellerRegisterNotice(SellerNotice sellerNotice);

	public int sellerEditNotice(SellerNotice sellerNotice);

	public int removeSellerNotice(int sellerNoticeNo);
}
