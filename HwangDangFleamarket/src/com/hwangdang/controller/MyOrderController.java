package com.hwangdang.controller;

import java.util.ArrayList;
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
		//System.out.println("메인페이지 , 구매자아이디 : " + loginId);
		List<Orders> orderList =  service.getOrdersMain(loginId);
		/*for(Orders temp : orderList){
			System.out.println(temp.toString());
		}*/
		model.addAttribute("orderList" ,orderList); 
	return "myorder/myorder_main.tiles";  
	}
	
	//메인페이지 - 배송완료 
	@RequestMapping("/success.go")
	public String goDeriveryPage(String loginId , Model model ){
		//System.out.println("derivery페이지 , 구매자아이디 : " + loginId);
		List<Orders> orderList =  service.getOrdersSuccess(loginId);
		/*for(Orders temp : orderList){
			System.out.println(temp.toString());
		}*/
		model.addAttribute("orderList" ,orderList); 
		return "myorder/myorder_success.tiles";  
	}
	// 주문취소 ,환불 , 교환 
	@RequestMapping("/cancel.go")
	public String goCancelPage(String loginId , Model model ){
		//System.out.println("cancel페이지 , 구매자아이디 : " + loginId);
		List<Orders> orderList =  service.getOrdersCancel(loginId);
		for(Orders temp : orderList){
			System.out.println(temp.toString());
		}  
		model.addAttribute("orderList" ,orderList); 
		return "myorder/myorder_cancel.tiles";  
	}
	  
	@RequestMapping("/orderCancelList.go")
	public String orderCancelList(String orderCancelList , Model model ){
		//System.out.println(orderCancelList);
		String array[] = orderCancelList.split(",");
		ArrayList<String> param = new ArrayList<>();
		for (int i = 0; i < array.length; i++) {
			param.add(array[i]);
		}
		service.removeOrderList(param);
		
		return "myorder/myorder_main.tiles";
	}
	
}
 