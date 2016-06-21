package com.hwangdang.daoimpl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.hwangdang.dao.MemberDao;
import com.hwangdang.vo.Member;

public class MemberDaoImpl implements MemberDao{

	private SqlSessionTemplate session;
	
	
	public MemberDaoImpl(SqlSessionTemplate session) {
		this.session = session;
	}

	@Override
	public int insert(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteById(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Member selectById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List selectList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List selectList(int page) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int selectCountById(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int selectMemberCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	

}
