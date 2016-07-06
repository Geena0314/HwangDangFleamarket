package com.hwangdang.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hwangdang.service.MemberService;
import com.hwangdang.service.ProductService;
import com.hwangdang.service.SellerService;
import com.hwangdang.vo.Member;
import com.hwangdang.vo.Seller;
import com.hwangdang.vo.Zipcode;


@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberService service;
	
	@Autowired
	private SellerService sellerService;
	
	@Autowired
	private ProductService productService;
	
	@RequestMapping("/register") //회원가입 창이 나오게 함
	public ModelAndView register(){
		//이메일 셀렉트.
		return new ModelAndView("member/register.tiles", "emailList", service.selectEmailList());
	}
	
	@RequestMapping("/registerIdCheck")
	@ResponseBody
	public String registerIdCheck(String memberId)
	{
		if(service.selectById(memberId) == null)
			return "success";//가입가능(회원아이디 중복아님.)
		return "fail";//가입불가(회원아이디 중복.)
	}
	 
	@RequestMapping("/registerresult") //DB에 내용을 기입하고 회원가입을 완료함
	public ModelAndView member(@ModelAttribute @Valid Member member, BindingResult result, HttpSession session, String domain,String hp1, String hp2, String hp3) throws Exception{
		
		
		member.setMemberPhone(hp1+"-"+hp2+"-"+hp3);
		member.setMemberId(member.getMemberId()+"@"+domain);
		service.add(member);
		return new ModelAndView("redirect:/member/registerSuccess.go");
	}
	
	@RequestMapping("/registerSuccess") //DB에 내용을 기입하고 회원가입을 완료함
	public String registerSuccess()
	{
		return "member/register_success.tiles";
	}
	
	@RequestMapping("/login") //로그인 화면폼이 나오게 함
	public ModelAndView login()
	{
		return new ModelAndView("/WEB-INF/view/member/login_form.jsp", "emailList", service.selectEmailList());
	}
	
	@RequestMapping("/loginResult.go") //로그인 후 화면
	public ModelAndView loginResult(String memberId, String domain, String memberPassword, HttpSession session, HttpServletRequest request){
		String memberIds = memberId + "@" + domain;
		Member member = service.findById(memberIds);
		if(member!=null){
			//아이디가 존재함.
			if(memberPassword.equals(member.getMemberPassword())){ //아이디와 패스워드가 맞는 경우
				if(member.getMemberAssign() == 1)
				{
					//판매자인경우
					session.setAttribute("seller", service.selectSellerById(memberIds));
				}
				else
				{
					//판매자가 아닌데 셀러신청을 한경우.
					if(service.selectSellerById(memberIds) != null)
					{
						session.setAttribute("sellerRegister", 1);
						session.setAttribute("seller", service.selectSellerById(memberIds));
					}
				}
				session.setAttribute("login_info", member);
				return new ModelAndView("member/login_success.tiles");
				
				
			}else{//패스워드가 틀린 경우
				request.setAttribute("loginId", memberId);
				request.setAttribute("domain", domain);
				return new ModelAndView("/member/login.go", "passwordError", "패스워드가 일치하지 않습니다.");
			}
		}else{//id가 없는 경우
			return new ModelAndView("/member/login.go", "idError", "아이디가 존재하지 않습니다.");
		}
	}
	
	//로그인 이후 상품 디테일페이지로 이동 
	@RequestMapping("/loginAfterProductDetailPage.go") //로그인 후 화면
	public String loginAfterProductDetailPage(String memberId, String memberPassword, HttpSession session , @RequestParam(value="page" ,defaultValue="1") int page  ,
		 String productId , String sellerStoreNo   , String sellerStoreImage , String amount , String option){
		
		//System.out.println(memberId +" , " + memberPassword);
		//System.out.println("page :" +page +", productId:"+productId + ",sellerStoreNo:" +sellerStoreNo  +",sellerSotreImage:"+sellerStoreImage+", amount:"+amount + ",option" +option);
		Member member = service.findById(memberId);
		if(member!=null){
			//아이디가 존재함.
			if(memberPassword.equals(member.getMemberPassword())){ 
				//아이디와 패스워드가 맞는 경우
				session.setAttribute("login_info", member);
			}
		}
		
		// 구매페이지로 이동 
		return "buyer/buyForm.tiles";
	}
	@RequestMapping("/logout")
	public String logout(HttpSession session)
	{
		session.invalidate();   
		return "redirect:/main.go";
	}
	
	@RequestMapping("/mypage")
	public String mypage(String memberPassword, HttpSession session)
	{
		return "member/mypage.tiles";
	}
	
	@RequestMapping("/sellerRegister")
	public ModelAndView sellerRegister()
	{
		//여기서 업종카테고리 가지고가기.
		return new ModelAndView("member/seller_register.tiles", "firstCategory", productService.selectFirstCategory());
	}
	
	@RequestMapping("/sellerStoreNameCheck")
	@ResponseBody
	public int sellerStoreNameCheck(String sellerStoreName)
	{
		return service.selectSellerStoreName(sellerStoreName);
	}
	
	@RequestMapping("/sellerRegisterRequest")
	public ModelAndView sellerRegisterRequest(Seller seller, MultipartFile sellerMainImage, HttpServletRequest request, HttpSession session)
	{
		//셀러 등록 신청.
		//대표이미지 저장처리.(sellerMainImage -> setSellerStoreImage)이름만 저장.
	    String originalFileName = sellerMainImage.getOriginalFilename();//업로드 된 파일명.
		
		//임시 저장소에 저장된 업로드 된 파일을 최종 저장소로 이동.
		//최종 저장소 디렉토리 조회.
		//new File(디렉토리, 파일)
		String path = "C:\\Users\\kosta\\gits\\HwangDangFleamarket\\HwangDangFleamarket\\WebContent\\image_storage";
		File image = new File(path, originalFileName);
		
	    //file중복체크
	    if (image.exists())
	    {
			originalFileName = System.currentTimeMillis() + originalFileName;
			image = new File(path, originalFileName);
	    }
	    // /는 application의 루트경로 => 파일경로로 알려준다.
	    try
		{
	    	//톰캣 경로의 image_storage로 파일복사.
	    	String imageStorage = request.getServletContext().getRealPath("/image_storage");
	    	FileCopyUtils.copy(sellerMainImage.getInputStream(), new FileOutputStream(imageStorage+"/"+originalFileName));
	    	
	    	//gits경로로 이미지 이동.
 			sellerMainImage.transferTo(image);
		} catch (IllegalStateException | IOException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	    seller.setSellerStoreImage(originalFileName);
	    int result = sellerService.insertSeller(seller);
	    if(result == 1)
		    return new ModelAndView("redirect:/member/sellerRegisterSuccess.go?result=1");
	    else
	    	return new ModelAndView("redirect:/member/sellerRegisterSuccess.go?result=0");
	}
	
	@RequestMapping("sellerRegisterSuccess")
	public String sellerRegisterSuccess(int result, HttpServletRequest request)
	{
		if(result == 0)
			request.setAttribute("result", "등록에 실패했습니다.");
		else
			request.setAttribute("result", "등록에 성공했습니다.");
		return "member/seller_register_success.tiles";
	}
	
	@RequestMapping("findAddress")
	public String findAddress()
	{
		return "/WEB-INF/view/member/address.jsp";
	}
	
	@RequestMapping("findZipcode")
	@ResponseBody
	public List<Zipcode> findZipcode(String dong)
	{
		return service.selectZipcode(dong);
	}
	
	@RequestMapping("findSellerAddress")
	public String findSellerAddress()
	{
		return "/WEB-INF/view/member/seller_address.jsp";
	}
	@RequestMapping("memberWithdrawal")
	public String memberWithdrawal(String memberId, HttpSession session)
	{
		session.invalidate();
		service.deleteMemberByMemberId(memberId);
		return "member/member_withdrawal.tiles";
	}
}