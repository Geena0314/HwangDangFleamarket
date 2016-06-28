package com.hwangdang.dao;

import java.util.List;

import com.hwangdang.vo.Cart;

public interface CartDao {
	
	int insertCart(Cart cart);
	
	int deleteCart(int cartNo);
	
	int selectCountCart(String memberId);
	
	List<Cart> selectAllCart(int page, String memberId);
	
	Cart selectCartByCartNo(int cartNo);
}
