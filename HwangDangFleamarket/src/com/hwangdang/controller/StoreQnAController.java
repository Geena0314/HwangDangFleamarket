package com.hwangdang.controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hwangdang.service.StoreQnAService;
import com.hwangdang.vo.StoreQnA;

@Controller
@RequestMapping("/storeQnA/")
public class StoreQnAController
{
	@Autowired
	private StoreQnAService service;
	
	public StoreQnAController()
	{
		// TODO Auto-generated constructor stub
	}
	
	@RequestMapping("storeQnARegisterForm")
	public String storeQnARegisterForm()
	{
		return "/WEB-INF/view/seller/storeQnA_register.jsp";
	}
	
	@RequestMapping("storeQnARegister")
	public String storeQnARegister(String storeQnATitle, String storeQnAContent, int storeQnAPublished, String storeQnAWriter, String productId)
	{
		StoreQnA qna = new StoreQnA(0, storeQnATitle, storeQnAContent, 0, storeQnAPublished, storeQnAWriter, new Date(), productId);
		service.insertStoreQnA(qna);
		return "/WEB-INF/view/seller/storeQnA_register_success.jsp";
	}
}