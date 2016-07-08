package com.hwangdang.service;

import java.util.List;

import com.hwangdang.vo.Code;
import com.hwangdang.vo.Member;
import com.hwangdang.vo.Seller;
import com.hwangdang.vo.Zipcode;

public interface MemberService {
	void add(Member member);
	
	Member findById(String memberId);

	//멤버 아이디로 셀러정보찾기.
	Seller selectSellerById(String memberId);
	
	//스토어 이름으로 중복체크
	int selectSellerStoreName(String sellerStoreName);
	
	//이메일리스트
	List<Code> selectEmailList();
	
	//동명으로 검색한 주소 리스트.
	List<Zipcode> selectZipcode(String dong);
	
	//회원가입 id 중복체크
	Member selectById(String memberId);

	int deleteMemberByMemberId(String memberId);
	   
	//회원정보수정 
	public int setMemberInfoByMemberId(Member setMember);
}

