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
import com.hwangdang.service.SellerService;
import com.hwangdang.vo.Cart;
import com.hwangdang.vo.Product;

@Controller
@RequestMapping("/cart")
public class CartController {

			@Autowired
			private CartService service;
		
			@RequestMapping("/cartList")
			public ModelAndView cartList(String memberId){
				HashMap map = new HashMap<>();
				ArrayList list = (ArrayList)service.getAllCart(memberId);
				map.put("cartList", list);
				return new ModelAndView("buyer/cart_list.tiles", map);
			}
			
			@RequestMapping("/addCart")
			@ResponseBody
			public HashMap<String, Object> addCart(Cart cart){
				service.addCart(cart);
				HashMap map = new HashMap<>();
				map.put("cart", cart);
				return map; 
			}
}
