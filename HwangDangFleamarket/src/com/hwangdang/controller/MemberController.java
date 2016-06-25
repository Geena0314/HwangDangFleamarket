package com.hwangdang.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwangdang.dao.MemberDao;
import com.hwangdang.service.MemberService;
import com.hwangdang.vo.Member;


@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao dao;
	@Autowired
	private MemberService service;
	
	@RequestMapping("/register") //회원가입 창이 나오게 함
	public String register(){
		return "member/register.tiles";
	}
	
	@RequestMapping("/registerresult") //DB에 내용을 기입하고 회원가입을 완료함
	public ModelAndView member(Member member, HttpSession session) throws Exception{
		System.out.println(member);
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
					System.out.println(service.selectSellerById(memberId));
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
}