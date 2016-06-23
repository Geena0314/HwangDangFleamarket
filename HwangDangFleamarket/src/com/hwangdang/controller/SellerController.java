package com.hwangdang.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwangdang.common.util.PagingBean;
import com.hwangdang.service.SellerService;


@Controller
@RequestMapping("/seller")
public class SellerController {
	
	@Autowired
	private SellerService service;
	
	@RequestMapping("/sellerList")
	public ModelAndView sellerList(int page){
		HashMap map = new HashMap<>();
		PagingBean pagingBean = new PagingBean(service.getCountSeller(), page);
		ArrayList list = (ArrayList)service.getAllSeller(page);
		map.put("list", list);
		map.put("pagingBean", pagingBean);
		return new ModelAndView("seller/seller_list.tiles", map);
	}

}
