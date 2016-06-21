package com.hwangdang.daoimpl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hwangdang.dao.ProductDao;
import com.hwangdang.vo.Product;
import com.hwangdang.vo.ProductOption;

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

	@Override
	public int selectCountProductByNo(int sellerStoreNo)
	{
		// TODO Auto-generated method stub
		return session.selectOne("productMapper.selectCountByNo", sellerStoreNo);
	}

	@Override
	public Product selectProductDetailById(String productId)
	{
		// TODO Auto-generated method stub
		return session.selectOne("productMapper.selectProductById", productId);
	}

	@Override
	public List<ProductOption> selectOptionById(String productId)
	{
		// TODO Auto-generated method stub
		return session.selectList("productMapper.selectOptionById", productId);
	}

	@Override
	public ProductOption selectOptionStockByName(String optionName)
	{
		// TODO Auto-generated method stub
		return session.selectOne("productMapper.selectOptionStockByName", optionName);
	}

	@Override
	public String selectDetailImageById(String productId)
	{
		// TODO Auto-generated method stub
		return session.selectOne("productMapper.selectDetailImageById", productId);
	}
}