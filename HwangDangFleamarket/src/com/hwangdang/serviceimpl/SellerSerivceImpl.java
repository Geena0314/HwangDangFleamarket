package com.hwangdang.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwangdang.dao.SellerDao;
import com.hwangdang.service.SellerService;
import com.hwangdang.vo.Seller;

@Service
public class SellerSerivceImpl implements SellerService{

	@Autowired
	private SellerDao dao;
	
	@Override
	public int getCountSeller() {
		return dao.selectCountSeller();
	}

	@Override
	public List getAllSeller(int page) {
		List<Seller> list = dao.selectAllSeller(page);
		for(Seller seller : list){
			seller.setSellerIntroduction(seller.getSellerIntroduction().replace(">", "&gt;"));
			seller.setSellerIntroduction(seller.getSellerIntroduction().replace("<", "&lt;"));
			seller.setSellerIntroduction(seller.getSellerIntroduction().replace("\n", "<br>"));
			seller.setSellerIntroduction(seller.getSellerIntroduction().replace(" ", "&nbsp;"));
		}
		return list;
	}

	@Override
	public Seller getSellerBySellerStoreNo(int sellerStoreNo) {
		Seller seller =  dao.selectSellerBySellerStoreNo(sellerStoreNo);
		return seller;
	}

	@Override
	public int insertSeller(Seller seller)
	{
		// TODO Auto-generated method stub
		return dao.insertSeller(seller);
	}
}