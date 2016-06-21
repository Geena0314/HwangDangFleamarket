package com.hwangdang.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwangdang.service.ProductService;

@Controller
@RequestMapping("/product/")
public class ProductController
{
	@Autowired
	private ProductService service;
	
	@RequestMapping("list")
	//상품 리스트 조회.
	public ModelAndView productList(int page)
	{
		HashMap<String, Object> map = service.selectAllProduct(page);
		return new ModelAndView("/WEB-INF/view/seller/product_list.jsp", map);
	}
}