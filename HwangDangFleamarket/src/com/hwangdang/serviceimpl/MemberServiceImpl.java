package com.hwangdang.serviceimpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwangdang.dao.MemberDao;
import com.hwangdang.service.MemberService;
import com.hwangdang.vo.Member;
@Service
public class MemberServiceImpl implements MemberService{
@Autowired
private MemberDao dao;

public MemberServiceImpl(){}

@Override
public Member findById(String memberId) {
	// TODO Auto-generated method stub
	return dao.selectById(memberId);
}



}
