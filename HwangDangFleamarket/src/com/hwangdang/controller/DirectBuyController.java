package com.hwangdang.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hwangdang.serviceimpl.DirectBuyServiceImpl;

@Controller
@RequestMapping("/buy")
public class DirectBuyController {

	
	@Autowired
	DirectBuyServiceImpl service;
	
	
	//구매전 재고수량 확인 로직
	@ResponseBody
	@RequestMapping("/checkStock.go")
	public String checkStock(@RequestParam(value="page" ,defaultValue="1") int page ,
			String productId ,int sellerStoreNo , String sellerStoreImage , int amount){
		//System.out.println("구매할 상품아이디 : "+productId +",셀러스토어넘버 :" + sellerStoreNo);
		//System.out.println("page :" + page + ", 셀러스토어이미지:"+sellerStoreImage);
		
		//재고확인로직
		int stock = service.getProductStockByProductId(productId);
		String msg = "";
		if(amount > stock){
			//주문수량이 재고량보다 큼 
			//System.out.println("주문수량이 재고량보다 큼 : 주문실패 ");
			 msg = "재고수량부족";
			
			
		}else if(amount <= stock){
			//주문수량이 재고량보다 작거나 같을때 : 주문가능 
			//System.out.println("주문가능상태 : 재고량가능!");
			msg="재고수량가능";
		}
		return msg;
	}  
	
	
	//?page=1&productId=상품id4&sellerStoreNo=2&sellerStoreImage=꿀빵#
	@RequestMapping("/moveBuyPage.go")
	public String moveBuyPage(@RequestParam(value="page" ,defaultValue="1") int page  ,
			String productId ,int sellerStoreNo , String sellerStoreImage , int amount ,
			@RequestParam(value="memberId" ,required=false) String memberId , String option , Model model){
		//System.out.println("구매할 상품아이디 : "+productId +",셀러스토어넘버 :" + sellerStoreNo);
		//System.out.println("page :" + page + ", 셀러스토어이미지:"+sellerStoreImage);
		//System.out.println("멤버아이디:"+memberId);
		String url = "";
		
		
		if(memberId.isEmpty()){ 
			//로그인이 안된상태 로그인페이지로 이동 !! 
			url ="member/login_form.tiles";
			model.addAttribute("errorMsg", "로그인이 필요한서비스입니다. 로그인해주세요");
			model.addAttribute("queryString" ,"page="+page+"&productId="+productId);
			model.addAttribute("page"+page);
			model.addAttribute("productId" ,productId);
			model.addAttribute("amount",amount);
		}else{ // 로그인상태! - 바로구매페이지로 이동 
			url ="buyer/buyForm.tiles";
		}
		
		
		return url;
	}  
	
	
	
	
}
