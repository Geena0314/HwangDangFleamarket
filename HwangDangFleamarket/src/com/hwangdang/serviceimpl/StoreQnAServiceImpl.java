package com.hwangdang.serviceimpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwangdang.dao.StoreQnADao;
import com.hwangdang.service.StoreQnAService;
import com.hwangdang.vo.StoreQnA;

@Service
public class StoreQnAServiceImpl implements StoreQnAService
{
	@Autowired
	private StoreQnADao dao;
	
	public StoreQnAServiceImpl()
	{
		// TODO Auto-generated constructor stub
	}

	@Override
	public int insertStoreQnA(StoreQnA qna)
	{
		// TODO Auto-generated method stub
		return dao.insertStoreQnA(qna);
	}

	@Override
	public int selectQnAPublished(int storeQnANo)
	{
		// TODO Auto-generated method stub
		return dao.selectQnAPublished(storeQnANo);
	}
}