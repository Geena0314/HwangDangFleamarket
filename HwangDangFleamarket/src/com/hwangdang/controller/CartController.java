package com.hwangdang.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
				int sum = 0;
				HashMap map = new HashMap<>();
				ArrayList list = (ArrayList)service.getAllCart(memberId);
				map.put("cartList", list);
				Cart cart = new Cart();
				for(int idx=0; idx<list.size(); idx++){
					cart = (Cart)list.get(idx);
					int amount = cart.getCartProductAmount();
					int addPrice = amount*cart.getProductList().get(0).getProductOption().getOptionAddPrice();
					sum = sum + amount * cart.getProductList().get(0).getProductPrice() +addPrice;
				}
				map.put("sum", sum);
				return new ModelAndView("buyer/cart_list.tiles", map);
			}
			
			@RequestMapping("/addCart")
			@ResponseBody
			public Cart addCart(Cart cart){
				service.addCart(cart);
				return cart; 
			}
			
			@RequestMapping("/removeCart")
			@ResponseBody
			public HashMap<String, Object> removeCart(String memberId, @RequestParam String [] checkBasket){
				HashMap<String, Object> map =new HashMap<>();
				for(int idx=0; idx<checkBasket.length; idx++){
					String no = checkBasket[idx];
					int cartNo = (int)Integer.parseInt(no);
					service.removeCart(cartNo);
				}
				map.put("result", "success");
				return map;
			}
}
