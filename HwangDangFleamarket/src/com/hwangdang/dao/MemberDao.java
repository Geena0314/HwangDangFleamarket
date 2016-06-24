package com.hwangdang.dao;

import java.util.List;

import com.hwangdang.vo.Member;

public interface MemberDao {
	/**
	 * 회원정보 insert
	 */
	int insert(Member member);

	/**
	 * 특정 ID의 회원의 나머지 정보 update
	 */
	int update(Member member);

	/**
	 * ID로 회원 delete
	 */
	int deleteById(String memberId);

	/**
	 * Id로 회원 select
	 */
	
	Member selectById(String memberId);

	/**
	 */
	List selectList();

	List selectList(int page);
	

	int selectCountById(String memberId);

	int selectMemberCount();
}
