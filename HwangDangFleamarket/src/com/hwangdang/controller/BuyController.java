package com.hwangdang.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hwangdang.service.MemberService;
import com.hwangdang.serviceimpl.BuyServiceImpl;
import com.hwangdang.vo.Cart;
import com.hwangdang.vo.Member;
import com.hwangdang.vo.OrderProduct;
import com.hwangdang.vo.Orders;
import com.hwangdang.vo.Product;
import com.hwangdang.vo.ProductOption;
import com.hwangdang.vo.Seller;

@Controller
@RequestMapping("/buy")
public class BuyController {

	
	@Autowired
	private BuyServiceImpl service;
	
	@Autowired
	private MemberService memberService;
	
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
	 * 바로구매 :1개  상품결제 페이지 이동 
	 *   (비로그인상태이면 로그인페이지로 거쳐서 로그인후 구매페이지로 이동  )
	 */
	@RequestMapping("/moveBuyPage.go")
	public String moveBuyPage(@RequestParam(value="page" ,defaultValue="1") int page  ,
			@RequestParam(value="productId" ,required=false) String productId   , int sellerStoreNo , String sellerStoreImage , int amount ,
			@RequestParam(value="memberId" ,required=false) String memberId , String option , Model model /*, HttpSession session*/){
		
		String url = "";
		if(memberId.isEmpty()){ 
			//로그인이 안된상태 로그인페이지로 이동 !! 
			url ="member/login_form.tiles";
			model.addAttribute("errorMsg", "로그인이 필요한서비스입니다. 로그인해주세요");
			model.addAttribute("queryString" ,"page="+page+"&productId="+productId);
		}else{ 
			// *********로그인상태! - 바로구매페이지로 이동 ***************
			if(productId != null){
				ArrayList<OrderProduct> orderProductList = new ArrayList<>();
				//System.out.println(sellerStoreNo);
				Member member = memberService.findById(memberId);
				Product product = service.getProductInfo(productId);
				ProductOption productOption = service.getProductOptionByOptionSubName(option);
				Seller seller = service.getSellerByNo(sellerStoreNo);
				long randomNumber = (int) (Math.random() * 999999999) + 1;
				String ordersNo = "" + randomNumber;
				int orderSeqNo = service.getOrderProductSeq();
				OrderProduct orderProduct = new OrderProduct(orderSeqNo ,amount, ordersNo, productId, productOption.getOptionId()  ,product.getSellerStoreNo() , 0 , product, productOption, seller);
				orderProductList.add(orderProduct);
				model.addAttribute("orderProductList",orderProductList);
				url ="buyer/buyForm.tiles";	
			} 
		
		}
		return url;
	}  
	
	/**
	 * 장바구니 구매  N개 : 상품결제 페이지로 이동 
	 */
	@RequestMapping("/buyCarts.go")
	public String buyCarts(String cartNoList , Model model){
		System.out.println("카트리스트:"+ cartNoList);
		
		//1.주문번호 생성
		long randomNumber = (int) (Math.random() * 999999999) + 1;
		String ordersNo = "" + randomNumber;
		ArrayList<String> listParam = listSplit(cartNoList);
		ArrayList<Cart> cartList = new ArrayList<>();
		ArrayList<OrderProduct> orderProductList = new ArrayList<>();
		for(int i =0;  i < listParam.size();  i++){
			Cart cart = service.getCartByCartNo(Integer.parseInt(listParam.get(i)) );
			Member member = memberService.findById(cart.getMemberId());
			Product product = service.getProductInfo(cart.getProductId());
			ProductOption productOption = service.getProductOptionInfoByoptionNo(cart.getOptionId());
			Seller seller = service.getSellerByNo(product.getSellerStoreNo());
			int orderSeqNo = service.getOrderProductSeq();
			OrderProduct orderProduct = new OrderProduct(orderSeqNo ,cart.getCartProductAmount(), ordersNo, cart.getProductId(), cart.getOptionId(),product.getSellerStoreNo() , 0 , product, productOption, seller);
			orderProductList.add(orderProduct);
		}
		model.addAttribute("ordersNo",ordersNo );
		model.addAttribute("orderProductList",orderProductList);
		
		String url ="buyer/buyForm.tiles";	
		return url;
	}  
	
	/**
	 * 	상품구매 로직  1개 : 
	 */
	@RequestMapping("/buyProductOne.go")
	public String buyProductOne(@RequestParam(value="ordersNo" ,required=false) String ordersNo ,    
			String ordersReceiver , String ordersPhone, String ordersZipcode ,
			String ordersAddress , String ordersSubAddress , int ordersTotalPrice ,
			String ordersPayment , @RequestParam(value="ordersRequest" ,required=false) String ordersRequest , int paymentStatus , String memberId ,
			int orderAmount , String productId , int optionId , int sellerStoreNo , int orderProductStatus ,
			@RequestParam(value="usedMileage" ,defaultValue= "0") int usedMileage  ,  HttpSession session , 
			HttpServletResponse response , HttpServletRequest request ) throws Exception{ // 0 결재대기 , 1 결재완료  
		
		if(ordersNo == null){
			//1.주문번호 생성
			long randomNumber = (int) (Math.random() * 999999999) + 1;
			ordersNo = "" + randomNumber;
		}
		
		//System.out.println("사용한 마일리지 : int :" + usedMileage);
		//2.마일리지 사용했다면 변경하는 로직 
		if(usedMileage != 0){
			Map<String,Object> param = new HashMap<>();
			param.put("memberId", memberId);
			param.put("mileage", usedMileage);
			service.setMemberMileage(param);
		}
		
		Orders orders = new Orders(ordersNo, ordersReceiver, ordersPhone, ordersZipcode, ordersAddress, ordersSubAddress, ordersTotalPrice, ordersPayment, ordersRequest, paymentStatus, new Date(), memberId);
		OrderProduct op = new OrderProduct(orderAmount, ordersNo, productId, optionId, sellerStoreNo, orderProductStatus );
		
		/*
		Product product = service.getProductInfo(productId);
		Seller seller = service.getSellerByNo(sellerStoreNo);
		op.setProduct(product);
		op.setSeller(seller);
		op.setProductOption(productOption);
		ArrayList<OrderProduct> orderProductList = new ArrayList<>();
		orderProductList.add(op);
		orders.setOrderProductList(orderProductList);
		*/
		
		
		
		//****************************************
		//orders TB , orders product TB INSERT 
		int cnt = service.addProductOne(orders ,op);
			
		
		
		String url = "";
		if(cnt == 1){
			//System.out.println("성공"); //   "*/*.tiles"
			/*//뒤로가기이슈 해결 
			//response.setHeader("Cache-Control", "no-store");
			response.setHeader("Cache-Control","no-store");   
			response.setHeader("Pragma","no-cache");   
			response.setDateHeader("Expires",0);   
			if (request.getProtocol().equals("HTTP/1.1")) {
			        response.setHeader("Cache-Control", "no-cache"); 
			}*/
			
			session.setAttribute("orders", orders);
			url = "redirect:/buy/addProductSuccessPage.go?cnt="+cnt+"&ordersNo="+ordersNo+"&productId="+productId;
			
		}else{
			url = "redirect:/error.tiles"; 
		}
	return url; 
	}  
	
	
	/**
	 * 	상품구매 로직   N개 : 
	 */
	//optoinIdList:"+optionIdList+" , sellerStoreNoList :" + sellerStoreNoList +",
		//productIdList: "+ productIdList + ",amountList "+amountList
	@RequestMapping("/buyProducts.go")
	public String buyProducts(@RequestParam(value="ordersNo" ,required=false) String ordersNo ,    
			String ordersReceiver , String ordersPhone, String ordersZipcode ,
			String ordersAddress , String ordersSubAddress , int ordersTotalPrice ,
			String ordersPayment , @RequestParam(value="ordersRequest" ,required=false) String ordersRequest , int paymentStatus , String memberId ,
			String amountList , String productIdList , String optionIdList , String sellerStoreNoList , int orderProductStatus ,
			@RequestParam(value="usedMileage" ,defaultValue= "0") int usedMileage  ,  HttpSession session , 
			HttpServletResponse response , HttpServletRequest request ) throws Exception{ // 0 결재대기 , 1 결재완료  
		
		//1.주문번호 생성
		if(ordersNo == null){
			long randomNumber = (int) (Math.random() * 999999999) + 1;
			ordersNo = "" + randomNumber;
		}
		
		//System.out.println("사용한 마일리지 : int :" + usedMileage);
		//2.마일리지 사용했다면 변경하는 로직 
		if(usedMileage != 0){
			Map<String,Object> param = new HashMap<>();
			param.put("memberId", memberId);
			param.put("mileage", usedMileage);
			service.setMemberMileage(param);
		}
		  
		
		//3. 매개변수 split
		ArrayList<String> amountSplitList =  listSplit(amountList);
		ArrayList<String> productIdSplitList =  listSplit(productIdList);
		ArrayList<String> optoinIdSplitList =  listSplit(optionIdList);
		ArrayList<String> sellerStoreNoSplitList =  listSplit(sellerStoreNoList);
		
		
		
		// 4. 객체생성
		ArrayList<OrderProduct> orderProductList = new ArrayList<>();
		Orders orders = new Orders(ordersNo, ordersReceiver, ordersPhone, ordersZipcode, ordersAddress, ordersSubAddress, ordersTotalPrice, ordersPayment, ordersRequest, paymentStatus, new Date(), memberId);
		
		for(int i=0; i < amountSplitList.size(); i++){
			OrderProduct op = new OrderProduct(Integer.parseInt(amountSplitList.get(i)), 
					ordersNo, productIdSplitList.get(i) , Integer.parseInt(optoinIdSplitList.get(i)), Integer.parseInt(sellerStoreNoSplitList.get(i)), orderProductStatus );
			System.out.println(op);
			
			//List에 add()
			orderProductList.add(op);
			//DB에 INSERT
			int cnt = service.addProductN(op);
			if(cnt == 0){
				throw new Exception("addProductN(OrderProduct) 메소드에서 예외발생");
			}
		
		}
		//****************************************
		 //orders TB , orders product TB INSERT 
		int cnt = service.addProductN(orders);
		
				
		/*
		Product product = service.getProductInfo(productId);
		Seller seller = service.getSellerByNo(sellerStoreNo);
		op.setProduct(product);
		op.setSeller(seller);
		op.setProductOption(productOption);
		ArrayList<OrderProduct> orderProductList = new ArrayList<>();
		orderProductList.add(op);
		orders.setOrderProductList(orderProductList);
		*/
		
		
		
		
		
		
		String url = "";
		if(cnt == 1){
			//System.out.println("성공"); //   "*/*.tiles"
			/*//뒤로가기이슈 해결 
			//response.setHeader("Cache-Control", "no-store");
			response.setHeader("Cache-Control","no-store");   
			response.setHeader("Pragma","no-cache");   
			response.setDateHeader("Expires",0);   
			if (request.getProtocol().equals("HTTP/1.1")) {
			        response.setHeader("Cache-Control", "no-cache"); 
			}*/
			
			session.setAttribute("orders", orders);
			url = "redirect:/buy/addProductSuccessPage.go?cnt="+cnt+"&ordersNo="+ordersNo+"&orderProductList="+orderProductList;
			
		}else{
			url = "redirect:/error.tiles"; 
		}
	return url; 
	}  
	
	
	
	/**
	 * 	구매성공 : 결제성공 페이지 이동 
	 */
	@RequestMapping("/addProductSuccessPage.go")
	public String addProductPage(String ordersNo ,@RequestParam(value="productId" ,required=false ) String productId 
			,@RequestParam(value="orderProductList" ,required=false ) List orderProductList ,Model model ){
		String url = "/";
		//System.out.println(ordersNo +", "+ productId);
		
			url = "buyer/buy_product_one_success.tiles";
			Orders orders = service.getOrdersByOrdersNo(ordersNo);
			model.addAttribute("orders" ,orders);
			model.addAttribute("product",productId);
			model.addAttribute("orderProductList",orderProductList);
			/*url = "error.tiles"; 
			model.addAttribute("errorMsg","결제가실패하였습니다. 관리자에게 문의하세요.");*/
		
		return url;
	}
	/**
	 * 	최근배송지 조회   - 
	 */
	@RequestMapping("/currentDeliveryAddress.go")
	@ResponseBody
	public Orders currentDeliveryAddress(String memberId){
		//System.out.println("아이디:"+memberId);
		Orders orders = service.getcurrentDeliveryAddress(memberId);
		//System.out.println(orders);
		return orders;  //세부주소가진 orders 객체 리턴 
	}
	
	/**
	 * 	체크박스 list  콤마 split 메소드 
	 */
	public ArrayList<String> listSplit(String str){
		String array[] = str.split(",");
		ArrayList<String> param = new ArrayList<>();
		for (int i = 0; i < array.length; i++) {
			param.add(array[i]);
		}
		return param;
	}
	

	/**
	 * 세션의 회원의  마일리지 실시간 조회를 위한 메소드 
	 */
	@RequestMapping("/getMemberMileageAjax.go")
	@ResponseBody
	public int getMemberMileageAjax(String memberId){
		Member member = memberService.findById(memberId);
		return member.getMemberMileage();
	}
	
	
}
