package com.hwangdang.serviceimpl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwangdang.common.util.PagingBean;
import com.hwangdang.dao.ProductDao;
import com.hwangdang.service.ProductService;
import com.hwangdang.vo.ProductOption;
import com.hwangdang.vo.Review;
import com.hwangdang.vo.StoreQnA;

@Service
public class ProductServiceImpl implements ProductService
{
	@Autowired
	private ProductDao dao;
	
	public ProductServiceImpl()
	{
		// TODO Auto-generated constructor stub
	}

	@Override
	//상품 리스트 조회.
	public HashMap<String, Object> selectAllProduct(int page, int sellerStoreNo)
	{
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<>();
		PagingBean bean = new PagingBean(dao.selectCountProductByNo(sellerStoreNo), page);
		map.put("itemPerPage", 6);//한 페이지에 표시할 갯수.
		map.put("page", page);//현재 페이지.
		map.put("sellerStoreNo", sellerStoreNo);
		map.put("productList", dao.selectAllProduct(map));
		map.put("bean", bean);
		
		return map;
	}

	@Override
	//상품 ID로 조회.
	public HashMap<String, Object> selectProductDetailById(int page, String productId)
	{
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<>();
		map.put("product", dao.selectProductDetailById(productId));
		map.put("optionList", dao.selectOptionById(productId));
		String image = dao.selectDetailImageById(productId);
		try
		{
			String[] detailImage = image.split("/");
			map.put("detailimage", detailImage);
		}
		catch (Exception e)
		{
			
		}
		
		//Review조회 및 페이징.
		PagingBean bean = new PagingBean(dao.selectCountById(productId), page);
		map.put("itemPerPage", 6);
		map.put("page", page);
		map.put("productId", productId);
		map.put("reviewList", dao.selectReviewById(map));
		map.put("bean", bean);
		
		//Store_QnA조회 및 페이징.
		map.put("qnaMap", selectStoreQnAPaging(page, productId));
		return map;
	}

	@Override
	public ProductOption selectOptionStockByName(String optionName)
	{
		// TODO Auto-generated method stub
		return dao.selectOptionStockByName(optionName);
	}

	@Override
	public HashMap<String, Object> selectReviewPaging(int page, String productId)
	{
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<>();
		PagingBean bean = new PagingBean(dao.selectCountById(productId), page);
		map.put("itemPerPage", 6);
		map.put("page", page);
		map.put("productId", productId);
		map.put("review", dao.selectReviewById(map));
		map.put("bean", bean);
		return map;
	}
	
	@Override
	public HashMap<String, Object> selectStoreQnAPaging(int page, String productId)
	{
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<>();
		PagingBean qnaBean = new PagingBean(dao.selectQnACountById(productId), page);
		map.put("itemPerPage", 6);
		map.put("page", page);
		map.put("productId", productId);
		map.put("qna", dao.selectQnAById(map));
		map.put("qnaBean", qnaBean);
		return map;
	}

	@Override
	public boolean reviewWriteCheck(String memberId)
	{
		// TODO Auto-generated method stub
		System.out.println(memberId);
		List<String> list = dao.selectOrderNo(memberId);
		for(int i = 0; i < list.size(); i++)
		{
			if(dao.selectOrderProduct(list.get(i)) > 0)
				return true;
		}
		return false;
	}

	@Override
	public int insertReview(String memberId, String reviewContent, String productId, int productLike)
	{
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("productId", productId);
		map.put("productLike", productLike);
		if(dao.reviewRegisterCheck(map) == 0)
		{
			dao.updateProductLikes(map);
			dao.insertReview(new Review(0, reviewContent, new Date(), "isj4216", productId));
			return dao.selectProductLike(productId);
		}
		else 
			return 0;
	}

	@Override
	public int deleteReview(String memberId, String productId)
	{
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("productId", productId);
		return dao.deleteReview(map);
	}

	@Override
	public StoreQnA selectQnAByNo(int storeQnANo)
	{
		// TODO Auto-generated method stub
		return dao.selectQnAByNo(storeQnANo);
	}

	@Override
	public StoreQnA selectQnAJoin(int storeQnANo)
	{
		// TODO Auto-generated method stub
		return dao.selectQnAJoin(storeQnANo);
	}

	@Override
	public int insertQnAReply(int sellerStoreNo, String storeReplyContent, int storeQnANo)
	{
		// TODO Auto-generated method stub
		//스토어 판매자 아이디 조회
		String memberId = dao.selectSellerByNo(sellerStoreNo);
		/*
		 * 세션에 등록되어있는(로그인한) 아이디와 조회한 아이디 비교 후 맞으면 등록해줌.(판매자만등록)
		 */
		HashMap<String, Object> map = new HashMap<>();
		map.put("storeReplyWriter", memberId);
		map.put("storeReplyContent", storeReplyContent);
		map.put("storeQnANo", storeQnANo);
		return dao.insertQnAReply(map);
	}
}