package com.hwangdang.daoimpl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hwangdang.dao.ProductDao;
import com.hwangdang.vo.Product;

@Repository
public class ProductDaoImpl implements ProductDao
{
	@Autowired
	private SqlSessionTemplate session;
	
	public ProductDaoImpl() 
	{

	}

	@Override
	//상품 리스트 조회.
	public List<Product> selectAllProduct(HashMap<String, Object> map)
	{
		// TODO Auto-generated method stub
		return session.selectList("productMapper.selectAll", map);
	}

	@Override
	public int selectCountProduct()
	{
		return session.selectOne("productMapper.selectCount");
	}
}