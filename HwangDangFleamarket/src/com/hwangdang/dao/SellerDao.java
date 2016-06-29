package com.hwangdang.dao;

import java.util.HashMap;
import java.util.List;

import com.hwangdang.vo.Notice;
import com.hwangdang.vo.Seller;

public interface SellerDao {

	int selectCountSeller();
	
	Seller selectSellerBySellerStoreNo(int sellerStoreNo);
	
	List<Seller> selectAllSeller(int page);
	
	//셀러 정보 등록
	int insertSeller(Seller seller);
	
	//셀러 등록신청 조회.
	List<Seller> selectSellerRegister(HashMap<String, Object> map);
	
	//셀러 등록신청한 사람수 조회.
	int selectCountSellerRegister();
	
	//셀러 - 멤버 조인.
	Seller selectSellerMember(int sellerStoreNo);
	
	//셀러 assign 1로변경(판매자등록승인)
	int sellerAssignUpdate(int sellerStoreNo);
	
	//셀러정보삭제(관리자가 거부)
	int deleteSellerByNo(int sellerStoreNo);
}
