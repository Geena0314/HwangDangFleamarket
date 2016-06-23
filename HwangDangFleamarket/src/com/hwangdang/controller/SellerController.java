package com.hwangdang.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping("/seller")
public class SellerController {
	
	@RequestMapping("/sellerList")
	public ModelAndView sellerList(){
		return new ModelAndView("seller/seller_list.tiles");
	}
}
