package com.hwangdang.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
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
	public String register(){
		return "member/register.tiles";
	}
	
	@RequestMapping("/registerresult") //DB에 내용을 기입하고 회원가입을 완료함
	public ModelAndView member(Member member, HttpSession session) throws Exception{
		service.add(member);
		//mv.setViewName("/member/registerResult.go");
		return new ModelAndView("member/registerResult.tiles");
	}
	
	@RequestMapping("/login") //로그인 화면폼이 나오게 함
	public String login(){
		return "/WEB-INF/view/member/login_form.jsp";
	}
	
	@RequestMapping("/loginResult.go") //로그인 후 화면
	public ModelAndView loginResult(String memberId, String memberPassword, HttpSession session){
		Member member = service.findById(memberId);
		if(member!=null){
			//아이디가 존재함.
			if(memberPassword.equals(member.getMemberPassword())){ //아이디와 패스워드가 맞는 경우
				if(member.getMemberAssign() == 1)
				{
					//판매자인경우
					session.setAttribute("seller", service.selectSellerById(memberId));
				}
				else
				{
					//판매자가 아닌데 셀러신청을 한경우.
					if(service.selectSellerById(memberId) != null)
					{
						session.setAttribute("sellerRegister", 1);
					}
				}
				session.setAttribute("login_info", member);
				return new ModelAndView("member/login_success.tiles");
				
				
			}else{//패스워드가 틀린 경우
				return new ModelAndView("member/login_form.tiles", "passwordError", "패스워드가 일치하지 않습니다.");
			}
		}else{//id가 없는 경우
			return new ModelAndView("member/login_form.tiles", "idError", "아이디가 존재하지 않습니다.");
		}
	}
	
	//로그인 이후 상품 디테일페이지로 이동 
	/*파람 셀러스토어 넘버 : ${param.sellerStoreNo }
	파람  어마운트 : ${param.amount }
	셀러스토어 넘버 : ${param.sellerStoreNo }
	셀러스토어 이미지 : ${param.sellerStoreImage }
	어마운트 : ${param.amount }
	옵션 : ${param.option }*/
	@RequestMapping("/loginAfterProductDetailPage.go") //로그인 후 화면
	public String loginAfterProductDetailPage(String memberId, String memberPassword, HttpSession session ){
		//@RequestParam(value="page" ,defaultValue="1") int page  ,
		// String productId ,String sellerStoreNo   , String sellerStoreImage , String amount , String option
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
		//상품 디테일페이지 
		//return "/product/detail.go?"+queryString;
		// 구매페이지로 이동 
		return "buyer/buyForm.tiles";
	}
	@RequestMapping("/logout")
	public String logout(HttpSession session)
	{
		session.invalidate();
		return "redirect:/main.go";
	}
	
	@RequestMapping("/mypageCheck")
	public String mypageCheck()
	{
		return "member/mypage_check.tiles";
	}
	
	@RequestMapping("/mypage")
	public ModelAndView mypage(String memberPassword, HttpSession session)
	{
		if(memberPassword.equals(((Member)session.getAttribute("login_info")).getMemberPassword()))
			return new ModelAndView("member/mypage.tiles");
		else
			return new ModelAndView("member/mypage_check.tiles", "passwordError", "패스워드가 일치하지 않습니다.");
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
	    String OriginalfileName = sellerMainImage.getOriginalFilename();//업로드 된 파일명.
		
		//임시 저장소에 저장된 업로드 된 파일을 최종 저장소로 이동.
		//최종 저장소 디렉토리 조회.
		//new File(디렉토리, 파일)
		String path = "C:\\Users\\kosta\\gits\\HwangDangFleamarket\\HwangDangFleamarket\\WebContent\\image_storage";
		File image = new File(path, OriginalfileName);
		
	    //file중복체크
	    if (image.exists())
	    {
			OriginalfileName = System.currentTimeMillis() + OriginalfileName;
			image = new File(path, OriginalfileName);
	    }
	    // /는 application의 루트경로 => 파일경로로 알려준다.
	    try
		{
	    	//톰캣 경로의 image_storage로 파일복사.
	    	String imageStorage = request.getServletContext().getRealPath("/image_storage");
	    	FileCopyUtils.copy(sellerMainImage.getInputStream(), new FileOutputStream(imageStorage+"/"+OriginalfileName));
	    	
	    	//gits경로로 이미지 이동.
 			sellerMainImage.transferTo(image);
		} catch (IllegalStateException | IOException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	    seller.setSellerStoreImage(OriginalfileName);
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
}