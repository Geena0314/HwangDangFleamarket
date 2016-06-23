package com.hwangdang.service;

import java.util.HashMap;

import com.hwangdang.vo.ProductOption;
import com.hwangdang.vo.StoreQnA;

public interface ProductService 
{
	//상품 리스트 조회. 페이징 처리.
	HashMap<String, Object> selectAllProduct(int page, int sellerStoreNo);
	
	//상품 상세정보 조회. 아이디로.
	HashMap<String, Object> selectProductDetailById(int page, String productId);
	
	//옵션세부내용으로 재고량과 추가가격 조회.
	ProductOption selectOptionStockByName(String optionName);
	
	//리뷰 페이징.
	HashMap<String, Object> selectReviewPaging(int page, String productId);
	
	//리뷰등록하기전 구매여부 체크.
	boolean reviewWriteCheck(String memberId);
	
	//리뷰 등록하기. 멤버객체or멤버아이디가져와서 작성자 입력해주기.
	int insertReview(String memberId, String reviewContent, String productId, int productLike);
	
	//리뷰 삭제하기.
	int deleteReview(String memberId, String productId);
	
	//스토어QnA 페이징.
	HashMap<String, Object> selectStoreQnAPaging(int page, String productId);
	
	//QnA번호로 QnA조회.
	StoreQnA selectQnAByNo(int storeQnANo);
	
	//QnA Join
	StoreQnA selectQnAJoin(int storeQnANo);
}