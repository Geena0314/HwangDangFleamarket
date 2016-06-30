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
	
	//나의주문 - 메인페이지 (배송현황 조회 ) 이동 
	@RequestMapping("/main.go")
	public String goMainPage(String loginId , Model model ){
		//System.out.println("메인페이지 , 구매자아이디 : " + loginId);
		List<Orders> orderList =  service.getOrdersMain(loginId);
		for(Orders temp : orderList){
			System.out.println(temp.toString());
		}
		model.addAttribute("orderList" ,orderList); 
	return "myorder/myorder_main.tiles";  
	}
	
	//나의주문- 배송완료 페이지이동 
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
	// 주문취소 ,환불 , 교환 페이지 이동 
	@RequestMapping("/cancel.go")
	public String goCancelPage(String loginId , Model model ){
		//System.out.println("cancel페이지 , 구매자아이디 : " + loginId);
		List<Orders> orderList =  service.getOrdersCancel(loginId);
		/*for(Orders temp : orderList){
			System.out.println(temp.toString());
		}  */
		model.addAttribute("orderList" ,orderList); 
		return "myorder/myorder_cancel.tiles";  
	}
	
	//체크박스 list  콤마 split 메소드 
	public ArrayList<String> listSplit(String str){
		String array[] = str.split(",");
		ArrayList<String> param = new ArrayList<>();
		for (int i = 0; i < array.length; i++) {
			param.add(array[i]);
		}
		return param;
	}
	
	//주문취소 로직수행 0:입금대기중 ,1:결제완료 , 2:배송준비중 삭제   
	@RequestMapping("/orderCancelList.go") 
	public String orderCancelList(String orderCancelList , String loginId){
		//System.out.println(orderCancelList);
		ArrayList<String> param  = listSplit(orderCancelList);
		service.removeOrderList(param);
		return "redirect:/myorder/main.go?loginId="+loginId;
	}
	
	//주문:환불신청 3:배송중 , 4:배송완료만 가능 
	@RequestMapping("/orderStatusRefund.go") 
	public String orderStatusRefund(String orderRefundList ,String loginId){
		//System.out.println("오더체인지리스트 :: "+ orderChangeList);
		ArrayList<String> param  = listSplit(orderRefundList);   
		service.setOrderStatus(param);
		return "redirect:/myorder/cancel.go?loginId="+loginId;
	}
	
	@RequestMapping("/orderStatusChange.go") 
	public String orderStatusChange(String orderChangeList ,String loginId){
		//System.out.println("오더체인지리스트 :: "+ orderChangeList);
		ArrayList<String> param  = listSplit(orderChangeList);   
		
		
		return "redirect:/myorder/cancel.go?loginId="+loginId;
	}
	
}
 