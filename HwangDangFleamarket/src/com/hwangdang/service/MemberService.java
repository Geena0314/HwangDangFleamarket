package com.hwangdang.service;

import com.hwangdang.vo.Member;
import com.hwangdang.vo.Seller;

public interface MemberService {

	Member findById(String memberId);

	//멤버 아이디로 셀러정보찾기.
	Seller selectSellerById(String memberId);
}

