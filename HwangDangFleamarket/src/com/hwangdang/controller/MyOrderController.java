package com.hwangdang.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hwangdang.serviceimpl.MyOrderServiceImpl;
import com.hwangdang.vo.Orders;

@Controller
@RequestMapping("/myorder")
public class MyOrderController {
	
	@Autowired
	MyOrderServiceImpl service;
	
	//메인페이지 - 배송현황 조회 
	@RequestMapping("/main.go")
	public String goMainPage(String loginId , Model model ){
		//System.out.println("메인페지이 , 구매자아이디 : " + loginId);
		List<Orders> orderList =  service.getOrders(loginId);
		for(Orders temp : orderList){
			System.out.println(temp.toString());
		}
		model.addAttribute("orderList" ,orderList); 
	return "myorder/myorder_main.tiles";  
	}
	
	  
	
}
 