package com.hwangdang.dao;

import com.hwangdang.vo.StoreQnA;

public interface StoreQnADao
{
	//스토어 QnA 등록.
	int insertStoreQnA(StoreQnA qna);
	
	//스토어 QnA 공개여부 체크.
	int selectQnAPublished(int storeQnANo);
}
