package com.hwangdang.service;

import com.hwangdang.vo.StoreQnA;

public interface StoreQnAService
{
	//스토어 QnA 등록.
	int insertStoreQnA(StoreQnA qna);
	
	//스토어 QnA 공개여부.
	int selectQnAPublished(int storeQnANo);
}
