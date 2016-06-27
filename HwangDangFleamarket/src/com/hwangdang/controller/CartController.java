package com.hwangdang.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/cart")
public class CartController {

	@RequestMapping("/cartList")
	public ModelAndView cartList(){
		return new ModelAndView("buyer/cart_list.tiles");
	}
}
