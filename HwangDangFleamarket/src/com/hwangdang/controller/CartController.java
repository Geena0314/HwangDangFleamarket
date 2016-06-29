package com.hwangdang.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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
			@ResponseBody
			public HashMap<String, Object> addCart( String productName, int productPrice, Cart cart){
				service.addCart(cart);
				HashMap map = new HashMap<>();
				map.put("cart", cart);
				map.put("productName",  productName);
				map.put("productPrice", productPrice);
				return map; // ajax로 돌아가야겠지
			}
			
			
}
