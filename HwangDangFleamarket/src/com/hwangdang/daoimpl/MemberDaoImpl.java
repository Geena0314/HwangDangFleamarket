package com.hwangdang.daoimpl;

import java.util.HashMap;
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
		return session.insert("member-Mapper.insert", member);
	}

	@Override
	public int update(Member member) {
		return session.update("membe-Mapper.update", member);
	}

	@Override
	public int deleteById(String memberId) {
		// TODO Auto-generated method stub
		return session.delete("member-Mapper.deleteById", memberId);
	}

	@Override
	public Member selectById(String memberId) {
		// TODO Auto-generated method stub
		return session.selectOne("memberMapper.selectById", memberId);
	}

	@Override
	public List selectList() {
		// TODO Auto-generated method stub
		return session.selectList("memberMapper.selectAll");
	}

	@Override
	public List selectList(int page) {
		// TODO Auto-generated method stub
		HashMap param = new HashMap();
		param.put("itemPerPage", 10);
		param.put("page", page);
		return session.selectList("memberMapper.selectList", param);
	}

	@Override
	public int selectCountById(String memberId) {
		// TODO Auto-generated method stub
		return session.selectOne("memberMapper.selectCountById", memberId);
	}

	@Override
	public int selectMemberCount() {
		// TODO Auto-generated method stub
		return session.selectOne("memberMapper.selectMemberCount");
	}

	

}




