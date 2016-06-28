package com.hwangdang.daoimpl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hwangdang.common.util.Constants;
import com.hwangdang.dao.CartDao;
import com.hwangdang.vo.Cart;

@Repository
public class CartDaoImpl implements CartDao{

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertCart(Cart cart) {
		return session.insert("cartMapper.insetCart", cart);
	}

	@Override
	public int deleteCart(int cartNo) {
		return session.delete("cartMapper.deleteCart", cartNo);
	}

	@Override
	public int selectCountCart(String memberId) {
		return session.selectOne("cartMapper.selectCountCart", memberId);
	}

	@Override
	public List<Cart> selectAllCart(int page, String memberId) {
		HashMap map = new HashMap<>();
		map.put("page", page);
		map.put("itemsPerPage", Constants.ITEMS_PER_PAGE);
		map.put("memberId", memberId);
		return session.selectList("cartMapper.selectCartPaging", map);
	}

	@Override
	public Cart selectCartByCartNo(int cartNo) {
		return session.selectOne("cartMapper.selectCartByCartNo", cartNo);
	}
}
