package com.hwangdang.daoimpl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hwangdang.common.util.Constants;
import com.hwangdang.dao.SellerDao;
import com.hwangdang.vo.Notice;
import com.hwangdang.vo.Seller;

@Repository
public class SellerDaoImpl implements SellerDao{
	
	@Autowired
	private SqlSessionTemplate session;

	public SellerDaoImpl(){}

	@Override
	public int selectCountSeller() {
		return session.selectOne("sellerMapper.selectCountSeller");
	}
	
	@Override
	public Seller selectSellerBySellerStoreNo(int sellerStoreNo) {
		return session.selectOne("sellerMapper.selectSellerBySellerStoreNo", sellerStoreNo);
	}

	@Override
	public List<Notice> selectAllSeller(int page) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("page", page);
		map.put("itemsPerPage", Constants.ITEMS_PER_PAGE);
		return session.selectList("sellerMapper.selectSellerPaging", map);
	}

	@Override
	public int insertSeller(Seller seller)
	{
		// TODO Auto-generated method stub
		return session.insert("sellerMapper.insertSeller", seller);
	}

	@Override
	public List<Seller> selectSellerRegister(HashMap<String, Object> map)
	{
		// TODO Auto-generated method stub
		return session.selectList("sellerMapper.selectSellerRegister", map);
	}

	@Override
	public int selectCountSellerRegister()
	{
		// TODO Auto-generated method stub
		return session.selectOne("sellerMapper.selectCountSellerRegister");
	}

	@Override
	public Seller selectSellerMember(int sellerStoreNo)
	{
		// TODO Auto-generated method stub
		return session.selectOne("sellerMapper.selectSellerMember", sellerStoreNo);
	}

	@Override
	public int sellerAssignUpdate(int sellerStoreNo)
	{
		// TODO Auto-generated method stub
		return session.update("sellerMapper.sellerAssignUpdate", sellerStoreNo);
	}

	@Override
	public int deleteSellerByNo(int sellerStoreNo)
	{
		// TODO Auto-generated method stub
		return session.delete("sellerMapper.deleteSellerByNo", sellerStoreNo);
	}
}