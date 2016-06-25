package com.hwangdang.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hwangdang.dao.SellerNoticeDao;
import com.hwangdang.service.SellerNoticeService;
import com.hwangdang.vo.SellerNotice;

@Service
public class SellerNoticeServiceImpl implements SellerNoticeService{
	
	@Autowired
	private SellerNoticeDao dao;

	@Override
	public List getAllSellerNotice(int page, int sellerStoreNo) {
		return dao.selectAllSellerNotice(page, sellerStoreNo);
	}

	@Override
	public int getCountSellerNotice(int sellerStoreNo) {
		return dao.selectCountSellerNotice(sellerStoreNo);
	}

	@Override
	public SellerNotice getSellerNoticeByNoticeNo(int sellerNoticeNo) {
		SellerNotice sellerNotice = dao.selectSellerNoticeByNoticeNo(sellerNoticeNo);
		dao.updateSellerNoticeHit(sellerNoticeNo);
		String replace = sellerNotice.getSellerNoticeContent().replace("\n", "<br>");
		sellerNotice.setSellerNoticeContent(replace);
		return sellerNotice;
	}
	
	@Transactional
	@Override
	public int sellerRegisterNotice(SellerNotice sellerNotice) {
		return dao.insertSellerNotice(sellerNotice);
	}

	@Transactional
	@Override
	public int sellerEditNotice(SellerNotice sellerNotice) {
		return dao.updateSellerNotice(sellerNotice);
	}

	@Override
	public int removeSellerNotice(int sellerNoticeNo) {
		return dao.deleteSellerNotice(sellerNoticeNo);
	}
}
