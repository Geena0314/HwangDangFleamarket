package com.hwangdang.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwangdang.common.util.PagingBean;
import com.hwangdang.service.CartService;
import com.hwangdang.vo.Cart;

@Controller
@RequestMapping("/cart")
public class CartController {

			@Autowired
			private CartService service;
		
			@RequestMapping("/cartList")
			public ModelAndView cartList(int page, String memberId){
				HashMap map = new HashMap<>();
				PagingBean pagingBean = new PagingBean(service.getCountCart(memberId), page);
				ArrayList list = (ArrayList)service.getAllCart(page, memberId);
				return new ModelAndView("buyer/cart_list.tiles", map);
			}
			
			@RequestMapping("/addCart")
			public ModelAndView addCart(Cart cart, int page, String productName, int productPrice){
				service.addCart(cart);
				HashMap map = new HashMap<>();
				map.put("page", page);
				map.put("productName",  productName);
				map.put("productPrice", productPrice);
				return new ModelAndView("buyer/cart_list.tiles", map); // controller로 보내줘야하나 뭐지
			}
			
			
}
