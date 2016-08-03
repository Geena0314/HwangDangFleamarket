package backup;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.buf.UEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hwangdang.common.util.Constants;
import com.hwangdang.common.util.PagingBean;
import com.hwangdang.service.CartService;
import com.hwangdang.service.MemberService;
import com.hwangdang.serviceimpl.BuyServiceImpl;
import com.hwangdang.vo.Cart;
import com.hwangdang.vo.Code;
import com.hwangdang.vo.Member;
import com.hwangdang.vo.OrderProduct;
import com.hwangdang.vo.Orders;
import com.hwangdang.vo.Product;
import com.hwangdang.vo.ProductOption;
import com.hwangdang.vo.Seller;

@Controller
@RequestMapping("/buy")
public class BuyController_bakcup {

	
	@Autowired
	private BuyServiceImpl service;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CartService cartService;
	
	/**
	 * 바로구매  상품결제 페이지 이동 (1개구매)
	 *   (비로그인상태이면 로그인페이지로 거쳐서 로그인후 구매페이지로 이동  )
	 */
	@RequestMapping("/moveBuyPage.go") 
	public String moveBuyPage(@RequestParam(value="page" ,defaultValue="1") int page , 
								String productId ,int sellerStoreNo ,String sellerStoreImage ,
								int amount ,String memberId ,String option ,Model model){
		String url = "";
		if(memberId == null || memberId.isEmpty()){ 
			//로그인이 안된상태 로그인페이지로 이동 !! 
			url ="member/login_form.tiles";
			model.addAttribute("errorMsg", "로그인이 필요한서비스입니다. 로그인해주세요");
			model.addAttribute("flag" ,"true");
			//아이디 도메인리스트 조회  
			List<Code> emailList = memberService.selectEmailList();
			model.addAttribute("emailList", emailList);
		}else{ 
			// ********* 로그인상태! - 바로구매페이지로 이동 ***************
			url ="buyer/buyForm.tiles";	
			ArrayList<OrderProduct> orderProductList = new ArrayList<>();
			Product product = service.getProductInfo(productId);
			ProductOption productOption = service.getProductOptionByOptionSubName(option);
			Seller seller = service.getSellerByNo(sellerStoreNo);
			long randomNumber = (long) (Math.random() * 999999999) + 1;
			String ordersNo = "" + randomNumber;
			int orderSeqNo = service.getOrderProductSeq();
			OrderProduct orderProduct = new OrderProduct(orderSeqNo ,amount, ordersNo, productId, 
										productOption.getOptionId()  ,product.getSellerStoreNo(), 
										0 , product, productOption, seller);
			orderProductList.add(orderProduct);
			model.addAttribute("orderProductList",orderProductList);
			model.addAttribute("ordersNo",ordersNo);
		}
		return url;
	}  
	
	/**
	 * 장바구니 구매 상품결제 페이지로 이동( N개구매) 
	 */
	@RequestMapping("/buyCarts.go")
	public String buyCarts(String cartNoList , Model model , HttpSession session ){
		
		String url = "/";
		ArrayList<OrderProduct> orderProductList = new ArrayList<>();
		ArrayList<String> cartNoArrayList =  null;
		//1.주문번호 생성
		long randomNumber = (long) (Math.random() * 999999999) + 1;
		String ordersNo = "" + randomNumber;
		//2. 비지니스 로직 
		cartNoArrayList = listSplit(cartNoList);
		for(int i =0;  i < cartNoArrayList.size();  i++){
			Cart cart = service.getCartByCartNo(Integer.parseInt(cartNoArrayList.get(i)) );
			if(cart != null){
				Product product = service.getProductInfo(cart.getProductId());
				ProductOption productOption = service.getProductOptionInfoByoptionNo(cart.getOptionId());
				Seller seller = service.getSellerByNo(product.getSellerStoreNo());
				int orderSeqNo = service.getOrderProductSeq();
				OrderProduct orderProduct = new OrderProduct(orderSeqNo ,cart.getCartProductAmount(), ordersNo, 
													cart.getProductId(), cart.getOptionId(),product.getSellerStoreNo(), 
												     0 , product, productOption, seller);
				orderProductList.add(orderProduct);
			}else{
				//Cart가 비어있을경우 예외page 이동
				url = "error.tiles";
				model.addAttribute("errorMsg" , "cart에 상품이 비어있습니다.");
				return url;
			}
		}
		url ="buyer/buyForm.tiles";	
		model.addAttribute("flag" , "ok");  // flag를 통해 바로구매/장바구니구매 구분 
		model.addAttribute("ordersNo",ordersNo );
		model.addAttribute("orderProductList",orderProductList);
		model.addAttribute("cartNoList",cartNoList);
		return url;
	}  
	
	
	
	/**
	 * 상품구매전 검증작업 (1개구매/N개구매 모두사용)
	 */
	public boolean buyBeforeLogic( int ordersTotalPrice,String bank,String card,String quota,
								   String memberId,int usedMileage,HttpSession session){
		//1.검증 결제예정금액이 마이너스인경우  : 즉 사용한마일리지 > 결제예정금액 인경우!
			boolean flag = false;
			if(ordersTotalPrice < 0) {
				flag = false;
			}else{
				String vitualBankNo ="";
				//*가상번호 생성 로직 (무통장입금)
				if(bank != null  && !bank.isEmpty()){
					long randomNumber1 = (int) (Math.random() * 998) + 1;
					vitualBankNo  = "" + randomNumber1 + "-";
					long randomNumber2 = (int) (Math.random() * 99998) + 1;
					vitualBankNo  = vitualBankNo + "" + randomNumber2 + "-";
					long randomNumber3 = (int) (Math.random() * 998) + 1;
					vitualBankNo  = vitualBankNo + "" + randomNumber3 + "-";
					long randomNumber4 = (int) (Math.random() * 98) + 1;
					vitualBankNo  = vitualBankNo + "" + randomNumber4 ;
					session.setAttribute("vitualBankNo" ,vitualBankNo);
					session.setAttribute("bank",bank);
					}
				if(card != null && quota != null){
					//카드결제
					session.setAttribute("card" ,card);
					session.setAttribute("quota" ,quota); //할부
				}
				//2.마일리지 사용했다면 변경하는 로직 
				if(usedMileage != 0){
					Map<String,Object> param = new HashMap<>();
					param.put("memberId", memberId);
					param.put("mileage", usedMileage);
					service.setMemberMileage(param);
					//마일리지사용 했을경우 세션의 login_info 정보 수정 
					Member newMember = memberService.selectById(memberId);
					session.setAttribute("login_info", newMember);
				}
				flag = true;
			}
		return flag;
	}
	
	
	/**
	 * 	상품구매 로직  1개 : 실제구매로직
	 */
	@RequestMapping("/buyProductOne.go")
	public String buyProductOne(String ordersNo ,String ordersReceiver , String ordersPhone, String ordersZipcode , 
							String ordersAddress , String ordersSubAddress , int ordersTotalPrice , String ordersPayment ,
							@RequestParam(value="ordersRequest" ,required=false) String ordersRequest ,Model model ,
							int paymentStatus , String memberId , int orderAmount , String productId , 
							int optionId , int sellerStoreNo , int orderProductStatus , HttpServletResponse response ,
							@RequestParam(value="usedMileage" ,defaultValue= "0") int usedMileage , HttpServletRequest request ,
							@RequestParam(value="bank" ,required=false) String bank ,
							@RequestParam(value="card" ,required=false) String card , 
							@RequestParam(value="quota" ,required=false) String quota ,
					        @RequestParam(value="fare" ,defaultValue="0") int fare ,HttpSession session ) throws Exception{
		String url = "/";
		//전처리메소드 호출
		boolean flag = buyBeforeLogic(ordersTotalPrice, bank, card, quota,  memberId, usedMileage, session);
		if(flag){
			//비지니스 로직  : orders객체 / ordersProduct객체 생성 
			Orders orders = new Orders(ordersNo, ordersReceiver, ordersPhone, ordersZipcode, ordersAddress, ordersSubAddress, ordersTotalPrice, ordersPayment, ordersRequest, paymentStatus, new Date(), memberId  ,usedMileage);
			OrderProduct op = new OrderProduct(orderAmount, ordersNo, productId, optionId, sellerStoreNo, orderProductStatus , fare);
			Product product = service.getProductInfo(productId);
			Seller seller = service.getSellerByNo(sellerStoreNo);
			ProductOption po = service.getProductOptionInfoByoptionNo(optionId);
			op.setProduct(product);
			op.setSeller(seller);
			op.setProductOption(po);
			ArrayList<OrderProduct> orderProductList = new ArrayList<>();
			orderProductList.add(op);
			orders.setOrderProductList(orderProductList);
			
			//****************************************
			//orders TB , orders product TB INSERT 
			int cnt = service.addProductOne(orders ,op);
			if(cnt == 1){
				//1.개별상품/전체상품 구매한 갯수만큼 재고량 Minus
				Map<String,Object> param = new HashMap<String,Object>();
				param.put("buyStock", orderAmount);
				param.put("optionId", optionId);
				param.put("productId",productId );
				service.setOptionStockByOptionId(param);
				service.setProductStockByProductId(param);
				session.setAttribute("orders", orders);
				//뒤로가기이슈 해결 
				response.setHeader("Cache-Control","no-store");   
				url = "redirect:/buy/addProductSuccessPage.go?cnt="+cnt+"&ordersNo="+ordersNo+"&productId="+productId;
			}
		//검증실패 else 
		}else{
			request.setAttribute("errorMsg","검증을 실패하였습니다. 관리자에게 문의해주세요.");
			url ="error.tiles";
		}
	return url; 
	}  
	
	
	/**
	 * 	상품구매 로직   N개 : 
	 */
	@RequestMapping("/buyProducts.go")
	public String buyProducts(String ordersNo , String ordersReceiver , String ordersPhone, String ordersZipcode ,
			String ordersAddress , String ordersSubAddress , int ordersTotalPrice ,
			String ordersPayment , @RequestParam(value="ordersRequest" ,required=false) String ordersRequest , int paymentStatus , String memberId ,
			String amountList , String productIdList , String optionIdList , String sellerStoreNoList , int orderProductStatus ,
			@RequestParam(value="usedMileage" ,defaultValue= "0") int usedMileage  ,   @RequestParam(value="fareList" ,required=false) String fareList , HttpSession session , 
			HttpServletResponse response , HttpServletRequest request ,String cartNoList, 
			@RequestParam(value="bank" ,required=false) String bank , @RequestParam(value="card" ,required=false) String card , 
			@RequestParam(value="quota" ,required=false) String quota) throws Exception{ // 0 결재대기 , 1 결재완료  
		
		String url = "";
		boolean flag = buyBeforeLogic(ordersTotalPrice, bank, card, quota, memberId, usedMileage, session);
		if(flag){
			//전처리 성공 
			//1. 매개변수 split
			ArrayList<String> amountSplitList =  listSplit(amountList);
			ArrayList<String> productIdSplitList =  listSplit(productIdList);
			ArrayList<String> optoinIdSplitList =  listSplit(optionIdList);
			ArrayList<String> sellerStoreNoSplitList =  listSplit(sellerStoreNoList);
			ArrayList<String> fareListSplitList =  listSplit(fareList);
			
			// 2. 비지니스 로직  : orders / orderProduct 객체생성
			ArrayList<OrderProduct> orderProductList = new ArrayList<>();
			Orders orders = new Orders(ordersNo, ordersReceiver, ordersPhone, ordersZipcode, ordersAddress, ordersSubAddress, ordersTotalPrice, ordersPayment, ordersRequest, paymentStatus, new Date(), memberId , usedMileage);
			
			for(int i=0; i < amountSplitList.size(); i++){
				Product product = service.getProductInfo(productIdSplitList.get(i));
				Seller seller = service.getSellerByNo(Integer.parseInt(sellerStoreNoSplitList.get(i)));
				ProductOption productOption = service.getProductOptionInfoByoptionNo(Integer.parseInt(optoinIdSplitList.get(i)));
				OrderProduct op = new OrderProduct(Integer.parseInt(amountSplitList.get(i)), 
						ordersNo, productIdSplitList.get(i) , Integer.parseInt(optoinIdSplitList.get(i)), Integer.parseInt(sellerStoreNoSplitList.get(i)), orderProductStatus ,product ,productOption , seller );
				op.setFare(Integer.parseInt(fareListSplitList.get(i)));
				orderProductList.add(op); //List에 add()
			}
			orders.setOrderProductList(orderProductList);
			
			//****************************************
			// 5.orders TB , orders product TB INSERT 
			int cnt = service.addProductN(orders);
			for(OrderProduct op : orderProductList ){
				//DB에 INSERT
				cnt = service.addProductN(op);
				if(cnt == 0){
					//구매실패시 에러페이지로 이동!
					session.setAttribute("errorMsg","구매가 실패하였습니다. 관리자에게문의해주세요!");
					return "redirect:/error.tiles"; 
				}
			}
			
			//6-1. DB에 INSERT  : 결재완료라면 Cart에서 삭제
			if(cnt == 1){
				ArrayList<String> cartList = null;
				cartList = listSplit(cartNoList);
				for(String temp : cartList){
					int cartNo = Integer.parseInt(temp);
					cartService.removeCart(cartNo);
				}
				
				// 6-2결재완료라면  구매한 상품 수량 마이너스 
				Map<String,Object> param = new HashMap<String,Object>();
				for(int i=0; i < amountSplitList.size(); i++){
					int optionStock = Integer.parseInt(amountSplitList.get(i));
					param.put("buyStock", optionStock);
					param.put("optionId",orders.getOrderProductList().get(i).getProductOption().getOptionId() );
					param.put("productId", productIdSplitList.get(i));
					//1.해당옵션의상품수량 Minus
					service.setOptionStockByOptionId(param);
					//2.해당상품의 총수량 Minus
					service.setProductStockByProductId(param);
				}
				//뒤로가기이슈 해결 
				response.setHeader("Cache-Control","no-store");      
				session.setAttribute("orders", orders);
				url = "redirect:/buy/addProductSuccessPage.go?cnt="+cnt+"&ordersNo="+ordersNo+"&orderProductList="+orderProductList;
			} //if 
		
		}else{
			//전처리실패
			request.setAttribute("errorMsg","검증을 실패하였습니다. 관리자에게 문의해주세요.");
			url ="error.tiles";
		}
		
	return url; 
	}  
	
	
	/**
	 * 	구매성공 : 결제성공 페이지 이동 
	 */
	@RequestMapping("/addProductSuccessPage.go")
	public String addProductPage(String ordersNo ,@RequestParam(value="productId" ,required=false ) String productId 
					,@RequestParam(value="orderProductList" ,required=false ) List orderProductList ,Model model ){
			Orders orders = service.getOrdersByOrdersNo(ordersNo);
			model.addAttribute("orders" ,orders);
			model.addAttribute("product",productId);
			model.addAttribute("orderProductList",orderProductList);
		return "buyer/buy_success.tiles";
	}
	/**
	 * 	최근배송지 조회   - 
	 */
	@RequestMapping("/currentDeliveryAddress.go")
	@ResponseBody
	public Orders currentDeliveryAddress(String memberId){
		Orders orders = service.getcurrentDeliveryAddress(memberId);
		return orders;  //세부주소가진 orders 객체 리턴 
	}
	
	/**
	 * 	체크박스 list  콤마 split 메소드 
	 */
	public ArrayList<String> listSplit(String str){
		String array[] = str.split(",");
		ArrayList<String> list = new ArrayList<>();
		for (int i = 0; i < array.length; i++) {
			list.add(array[i]);
		}
		return list;
	}
	/**
	 * 세션의 회원의  마일리지 실시간 조회를 위한 메소드 
	 */
	@RequestMapping("/getMemberMileageAjax.go")
	@ResponseBody
	public int getMemberMileageAjax(String memberId){
		Member member = memberService.findById(memberId);
		int mileage = 0;
		if(member != null){
			mileage =  member.getMemberMileage();
		}
		return mileage;
	}
	
	
	/**
	 메인페이지 상품검색 기능 : 키워드로 상품이나 스토어 검색!
	 * */
	@RequestMapping("/findProductByKeyword.go")
	public String findProductByKeyword(Model model,
					@RequestParam(value="keyword" ,required=false) String keyword , 
					@RequestParam(value="page" , defaultValue="1") int page){
		//System.out.println("키워드:"+keyword);
		if(!keyword.isEmpty()){
			Map<String ,Object> param = new HashMap<String,Object>();
			param.put("keyword", keyword);
			param.put("itemPerPage", Constants.ITEMS_PER_PAGE);
			param.put("page" , page);
			List<Product> productList = service.getProductByLikeKeyword(param);
			/*for(Product p : productList){
				System.out.println(p);
			}*/
			int totalItems = service.getProductTotalByLikeKeyword(keyword);
			PagingBean pagingBean = new PagingBean(totalItems, page);
			
			model.addAttribute("pagingBean", pagingBean);
			model.addAttribute("productList", productList);
			model.addAttribute("keyword" ,keyword);
		}		
		return "buyer/product_list.tiles";
	}
	
	
} //class
