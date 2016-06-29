package com.hwangdang.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/myorder")
public class MyOrderController {
	
	//메인페이지 - 배송현황 조회 
	@RequestMapping("/main.go")
	public String goMainPage(){
		
		
	return "myorder/myorder_main.tiles";  
	}
	
	  
	
}
 