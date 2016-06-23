package com.hwangdang.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hwangdang.service.ProductService;
import com.hwangdang.vo.ProductOption;

@Controller
@RequestMapping("/product/")
public class ProductController
{
	@Autowired
	private ProductService service;
	
	@RequestMapping("list")
	//상품 리스트 조회.
	public ModelAndView productList(int page, int sellerStoreNo)
	{
		HashMap<String, Object> map = service.selectAllProduct(page, sellerStoreNo);
		return new ModelAndView("seller/product_list.tiles", map);
	}
	
	@RequestMapping("detail")
	public ModelAndView productDetail(int page, String productId)
	{
		return new ModelAndView("/WEB-INF/view/seller/product_detail.jsp", service.selectProductDetailById(page, productId));
	}
	
	@RequestMapping("optionStock")
	@ResponseBody
	public ProductOption optionStock(String optionName)
	{
		return service.selectOptionStockByName(optionName);
	}
	
	@RequestMapping("reviewPaging")
	@ResponseBody
	public HashMap<String, Object> reviewPaging(int page, String productId)
	{
		return service.selectReviewPaging(page, productId);
	}
	
	@RequestMapping("reviewWriteCheck")
	@ResponseBody
	public boolean reviewWriteCheck(String memberId)
	{
		return service.reviewWriteCheck(memberId);
	}
	
	@RequestMapping("reviewRegister")
	@ResponseBody
	public HashMap<String, Object> reviewRegister(String memberId, String reviewContent, String productId, int productLike)
	{
		//session에서 로그인한 회원의 정보를 가져옴.(멤버객체 or 멤버아이디 보내주기.(작성자));
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
	public HashMap<String, Object> reviewDelete(String memberId, String productId)
	{
		int reviewDelete = service.deleteReview(memberId, productId);
		HashMap<String, Object> map = reviewPaging(1, productId);
		map.put("reviewDelete", reviewDelete);
		return map;
	}
}