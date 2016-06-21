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
	public ModelAndView productDetail(String productId)
	{
		return new ModelAndView("/WEB-INF/view/seller/product_detail.jsp", service.selectProductDetailById(productId));
	}
	
	@RequestMapping("optionStock")
	@ResponseBody
	public ProductOption optionStock(String optionName)
	{
		return service.selectOptionStockByName(optionName);
	}
}