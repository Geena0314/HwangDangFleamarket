package com.hwangdang.controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hwangdang.serviceimpl.BuyServiceImpl;
import com.hwangdang.vo.OrderProduct;
import com.hwangdang.vo.Orders;
import com.hwangdang.vo.Product;
import com.hwangdang.vo.ProductOption;

@Controller
@RequestMapping("/buy")
public class BuyController {

	
	@Autowired
	private BuyServiceImpl service;
	
	/*@Autowired
	private MemberService memberService;*/
	
	//구매전 재고수량 확인 로직 - ajax 
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
	
	/**
	 * 비로그인상태이면 로그인페이지로 이동
	 * 로그인 상태이면  buyForm.jsp이동  
	 * //?page=1&productId=상품id4&sellerStoreNo=2&sellerStoreImage=꿀빵#
	 */
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
		}else{ // 로그인상태! - 바로구매페이지로 이동 
			
			url ="buyer/buyForm.tiles";
			Product product = service.getProductInfo(productId);
			model.addAttribute("product" ,product);
			ProductOption productOption = service.getProductOptionInfo(option);
			model.addAttribute("productOption" ,productOption);
		}
		return url;
	}  
	
	//바로구매 로직  - 상품품목 한개구매  
	/*@ModelAttribute(value="orders") Orders orders ,@ModelAttribute OrderProduct orderProduct*/ 
	@RequestMapping("/buyProductOne.go")
	public String buyProductOne(String ordersNo, String ordersReceiver , String ordersPhone, String ordersZipcode ,
			String ordersAddress , String ordersSubAddress , int ordersTotalPrice ,
			String ordersPayment , String ordersRequest , int paymentStatus , String memberId ,
			int orderAmount , String productId , int optionId , int sellerStoreNo , int orderProductStatus ) throws Exception{ // 0 결재대기 , 1 결재완료  
		
		//주문번호 생성로직
		int n = (int) (Math.random() * 9999) + 1;
		ordersNo = ordersNo +"" + n;
		//System.out.println(ordersNo);
		Orders orders = new Orders(ordersNo, ordersReceiver, ordersPhone, ordersZipcode, ordersAddress, ordersSubAddress, ordersTotalPrice, ordersPayment, ordersRequest, paymentStatus, new Date(), memberId);
		OrderProduct op = new OrderProduct(orderAmount, ordersNo, productId, optionId, sellerStoreNo, orderProductStatus);
		int cnt = service.addProductOne(orders ,op);
		String url = "";
		if(cnt ==1){
			//System.out.println("성공"); //   "*/*.tiles"
			String address= ordersAddress + ordersSubAddress;
			url = "redirect:/buy/addProductPage.go?cnt="+cnt+"&ordersReceiver="+ordersReceiver+"&address="+address +"&phone="+ordersPhone;
		}else{
			url = "redirect:/error.tiles"; 
		}
	return url; 
	}  
	
	@RequestMapping("/addProductPage.go")
	public String addProductPage(int cnt ,String ordersReceiver ,String address,String phone ,Model model ){
		String url = "/";
		if(cnt == 1){
			url = "buyer/buy_product_one_success.tiles";
			
		}else{
			url = "error.tiles"; 
			model.addAttribute("errorMsg","결제가실패하였습니다. 관리자에게 문의하세요.");
		}
		 
		
		return url;
	}
	
	//장바구니 구매
	@RequestMapping("/buyCarts.go")
	public String buyCarts(@RequestParam(value="page" ,defaultValue="1") int page  ,
				String productId ,int sellerStoreNo , String sellerStoreImage , int amount ,
				@RequestParam(value="memberId" ,required=false) String memberId , String option , Model model){
			//System.out.println("구매할 상품아이디 : "+productId +",셀러스토어넘버 :" + sellerStoreNo);
			//System.out.println("page :" + page + ", 셀러스토어이미지:"+sellerStoreImage);
			//System.out.println("멤버아이디:"+memberId);
			String url = "";
			
			
			return url;
		}  
	
}
