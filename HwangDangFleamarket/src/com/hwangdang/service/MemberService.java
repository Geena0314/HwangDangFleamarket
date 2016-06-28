package com.hwangdang.service;

import com.hwangdang.vo.Member;
import com.hwangdang.vo.Seller;

public interface MemberService {
	void add(Member member);
	
	Member findById(String memberId);

	//멤버 아이디로 셀러정보찾기.
	Seller selectSellerById(String memberId);
	
	//스토어 이름으로 중복체크
	int selectSellerStoreName(String sellerStoreName);
}

