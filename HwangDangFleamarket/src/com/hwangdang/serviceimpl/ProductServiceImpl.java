package com.hwangdang.serviceimpl;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwangdang.common.util.PagingBean;
import com.hwangdang.dao.ProductDao;
import com.hwangdang.service.ProductService;
import com.hwangdang.vo.ProductOption;

@Service
public class ProductServiceImpl implements ProductService
{
	@Autowired
	private ProductDao dao;
	
	public ProductServiceImpl()
	{
		// TODO Auto-generated constructor stub
	}

	@Override
	//상품 리스트 조회.
	public HashMap<String, Object> selectAllProduct(int page, int sellerStoreNo)
	{
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<>();
		PagingBean bean = new PagingBean(dao.selectCountProductByNo(sellerStoreNo), page);
		map.put("itemPerPage", 6);//한 페이지에 표시할 갯수.
		map.put("page", page);//현재 페이지.
		map.put("sellerStoreNo", sellerStoreNo);
		map.put("productList", dao.selectAllProduct(map));
		map.put("bean", bean);
		
		return map;
	}

	@Override
	//상품 ID로 조회.
	public HashMap<String, Object> selectProductDetailById(String productId)
	{
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<>();
		map.put("product", dao.selectProductDetailById(productId));
		map.put("optionList", dao.selectOptionById(productId));
		String image = dao.selectDetailImageById(productId);
		String[] detailImage = image.split("/");
		map.put("detailimage", detailImage);
		return map;
	}

	@Override
	public ProductOption selectOptionStockByName(String optionName)
	{
		// TODO Auto-generated method stub
		return dao.selectOptionStockByName(optionName);
	}
}