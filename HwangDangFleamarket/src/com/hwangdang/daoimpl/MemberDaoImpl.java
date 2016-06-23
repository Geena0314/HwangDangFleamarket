package com.hwangdang.daoimpl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hwangdang.dao.MemberDao;
import com.hwangdang.vo.Member;

@Repository
public class MemberDaoImpl implements MemberDao{
	@Autowired
	private SqlSessionTemplate session;

	
	public MemberDaoImpl(SqlSessionTemplate session) {
		this.session = session;
	}
	@Override
	public int insert(Member member) {
		return session.insert("memberMapper.insert", member);
	}

	@Override
	public int update(Member member) {
		return session.update("membeMapper.update", member);
	}

	@Override
	public int deleteById(String memberId) {
		return session.delete("memberMapper.deleteById", memberId);
	}

	@Override
	public Member selectById(String memberId) {
		return session.selectOne("memberMapper.selectById", memberId);
	}

	@Override
	public List selectList() {
		return session.selectList("memberMapper.selectAll");
	}

	@Override
	public List selectList(int page) {
		HashMap param = new HashMap();
		param.put("itemPerPage", 10);
		param.put("page", page);
		return session.selectList("memberMapper.selectList", param);
	}

	@Override
	public int selectCountById(String memberId) {
		return session.selectOne("memberMapper.selectCountById", memberId);
	}

	@Override
	public int selectMemberCount() {
		return session.selectOne("memberMapper.selectMemberCount");
	}
}