package com.hwangdang.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hwangdang.dao.MemberDao;
import com.hwangdang.service.MemberService;
import com.hwangdang.service.ProductService;
import com.hwangdang.service.SellerService;
import com.hwangdang.vo.Member;
import com.hwangdang.vo.Seller;


@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao dao;
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
		ModelAndView mv=new ModelAndView();
		dao.insert(member);
		//mv.setViewName("/member/registerResult.go");
		return new ModelAndView("member/registerResult.tiles");
	}
	
	@RequestMapping("/login") //로그인 화면폼이 나오게 함
	public String login(){
		return "member/login_form.tiles";
	}
	
	@RequestMapping("/loginResult") //로그인 후 화면
	public ModelAndView loginResult(String memberId, String memberPassword, HttpSession session){
		Member member = service.findById(memberId);
		if(member!=null){
			//아이디가 존재함.
			if(memberPassword.equals(member.getMemberPassword())){ //아이디와 패스워드가 맞는 경우
				if(member.getMemberAssign() == 1)
				{
					session.setAttribute("seller", service.selectSellerById(memberId));
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
			sellerMainImage.transferTo(image);
		} catch (IllegalStateException | IOException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	    seller.setSellerStoreImage(OriginalfileName);
	    int result = sellerService.insertSeller(seller);
	    if(result == 1)
		    return new ModelAndView("redirect:/member/sellerRegisterSuccess.go", "result", "등록에 성공했습니다.");
	    else
	    	return new ModelAndView("redirect:/member/seller_register_success.jsp", "result", "등록에 실패했습니다.");
	}
	
	@RequestMapping("sellerRegisterSuccess")
	public String sellerRegisterSuccess()
	{
		return "member/seller_register_success.tiles";
	}
	
}