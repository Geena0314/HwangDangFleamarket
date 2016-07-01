package com.hwangdang.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hwangdang.service.ProductService;
import com.hwangdang.service.StoreQnAService;
import com.hwangdang.vo.Category;
import com.hwangdang.vo.Member;
import com.hwangdang.vo.ProductOption;
import com.hwangdang.vo.StoreQnA;

@Controller
@RequestMapping("/product/")
public class ProductController
{
	@Autowired
	private ProductService service;
	
	@Autowired
	private StoreQnAService qnaService;
	
	public ProductController()
	{
		// TODO Auto-generated constructor stub
	}
	
	@RequestMapping("list")
	//상품 리스트 조회.
	public ModelAndView productList(int page, int sellerStoreNo)
	{
		HashMap<String, Object> map = service.selectAllProduct(page, sellerStoreNo);
		return new ModelAndView("seller/seller/product_list.tiles", map);
	}
	
	@RequestMapping("detail")
	public ModelAndView productDetail(int page, String productId, int sellerStoreNo)
	{
		return new ModelAndView("seller/seller/product_detail.tiles", service.selectProductDetailById(page, productId, sellerStoreNo));
	}
	
	@RequestMapping("optionStock")
	@ResponseBody
	public ProductOption optionStock(String optionName, String productId)
	{
		return service.selectOptionStockByName(optionName, productId);
	}
	
	@RequestMapping("reviewPaging")
	@ResponseBody
	public HashMap<String, Object> reviewPaging(int page, String productId)
	{
		return service.selectReviewPaging(page, productId);
	}
	
	@RequestMapping("reviewWriteCheck")
	@ResponseBody
	public boolean reviewWriteCheck(String memberId, HttpSession session)
	{
		memberId = ((Member)session.getAttribute("login_info")).getMemberId();
		return service.reviewWriteCheck(memberId);
	}
	
	@RequestMapping("reviewRegister")
	@ResponseBody
	public HashMap<String, Object> reviewRegister(String memberId, String reviewContent, String productId, int productLike, HttpSession session)
	{
		//session에서 로그인한 회원의 정보를 가져옴.(멤버객체 or 멤버아이디 보내주기.(작성자));
		memberId = ((Member)session.getAttribute("login_info")).getMemberId();
		if(reviewContent == null || reviewContent.trim().length() < 3 || reviewContent.length() > 20)
		{
			return null;
		}
		int productLikes = service.insertReview(memberId, reviewContent, productId, productLike);
		HashMap<String, Object> map = reviewPaging(1, productId);
		map.put("productLike", productLikes);
		return map;
	}
	
	@RequestMapping("reviewDelete")
	@ResponseBody
	public HashMap<String, Object> reviewDelete(String memberId, String productId, HttpSession session)
	{
		HashMap<String, Object> map = reviewPaging(1, productId);
		try
		{
			memberId = ((Member)session.getAttribute("login_info")).getMemberId();
		}
		catch (Exception e)
		{
			map.put("reviewDelete", 3);
			return map;
		}
		int reviewDelete = service.deleteReview(memberId, productId);
		map.put("reviewDelete", reviewDelete);
		return map;
	}
	
	@RequestMapping("qnaPaging")
	@ResponseBody
	public HashMap<String, Object> qnaPaging(int page, String productId)
	{
		return service.selectStoreQnAPaging(page, productId);
	}
	
	/*@RequestMapping("qnaShow")
	@ResponseBody
	public StoreQnA qnaShow(int storeQnANo)
	{
		return service.selectQnAByNo(storeQnANo);
	}*/
	
	@RequestMapping("qnaShow")
	@ResponseBody
	public StoreQnA qnaShow(int storeQnANo, int sellerStoreNo, HttpSession session)
	{
		//공개여부 체크.
		if(qnaService.selectQnAPublished(storeQnANo) == 0)
		{
			//비공개인경우.
			try
			{
				if(((Member)session.getAttribute("login_info")).getMemberId().equals(qnaService.selectSellerByNo(sellerStoreNo)) || 
						((Member)session.getAttribute("login_info")).getMemberId().equals(qnaService.selectQnAWriterByNo(storeQnANo)))
				{
					//스토어넘버로 조회해서 얻은 판매자 아이디와 내아이디가 같은경우(판매자인경우.)
					//						로그인한 회원의 아이디와 작성자가 같은경우.
					StoreQnA qna = service.selectQnAJoin(storeQnANo);
					if(qna == null)
					{
						return service.selectQnAByNo(storeQnANo);
					}
					return qna;
				}
				else
				{
					//아이디가 다른경우(판매자가 아니거나... 등록한회원이 아닌경우.)
					StoreQnA qna = service.selectQnAByNo(storeQnANo);
					qna.setStoreQnAPublished(3);
					return qna;
				}
			}
			catch(Exception e)
			{
				//로그인 안한경우.
				//아이디가 다른경우(판매자가 아니거나... 등록한회원이 아닌경우.)
				StoreQnA qna = service.selectQnAByNo(storeQnANo);
				qna.setStoreQnAPublished(3);
				return qna;
			}
		}
		else
		{
			StoreQnA qna = service.selectQnAJoin(storeQnANo);
			if(qna == null)
			{
				return service.selectQnAByNo(storeQnANo);
			}
			return qna;
		}
	}
	
	@RequestMapping("qnaReplyRegister")
	@ResponseBody
	public StoreQnA qnaReplyRegister(int sellerStoreNo, String storeReplyContent, int storeQnANo, HttpSession session)
	{
		try
		{
			if(((Member)session.getAttribute("login_info")).getMemberId().equals(qnaService.selectSellerByNo(sellerStoreNo)))
			{
				int result = service.insertQnAReply(sellerStoreNo, storeReplyContent, storeQnANo);
				if(result == 0)
				{
					return null;
				}
				return service.selectQnAJoin(storeQnANo);
			}
			else
			{
				return null;
			}
		}
		catch (Exception e)
		{
			return null;
		}
	}
	
	@RequestMapping("sellerSubIndustry")
	@ResponseBody
	public List<Category> sellerSubIndustry(String categoryIdRef)
	{
		return service.selectSecondCategory(categoryIdRef);
	}
}