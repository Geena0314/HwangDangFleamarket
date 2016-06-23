package com.hwangdang.serviceimpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwangdang.dao.MemberDao;
import com.hwangdang.service.MemberService;
@Service
public class MemberServiceImpl implements MemberService{
@Autowired
private MemberDao dao;

public MemberServiceImpl(){}



}
