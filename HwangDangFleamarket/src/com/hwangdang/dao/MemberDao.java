package com.hwangdang.dao;

import java.util.List;

import com.hwangdang.vo.Member;

public interface MemberDao {
	/**
	 * 회원정보 insert
	 * @param member
	 * @return
	 */
	int insert(Member member);

	/**
	 * 특정 ID의 회원의 나머지 정보 update
	 * @param member
	 * @return
	 */
	int update(Member member);

	/**
	 * ID로 회원 delete
	 * @param id
	 * @return
	 */
	int deleteById(String id);

	/**
	 * Id로 회원 select
	 * @param id
	 * @return
	 */
	
	Member selectById(String id);

	/**
	 * 모든 회원 정보 조회
	 * @return
	 */
	List selectList();

	List selectList(int page);
	

	int selectCountById(String id);

	int selectMemberCount();
}
