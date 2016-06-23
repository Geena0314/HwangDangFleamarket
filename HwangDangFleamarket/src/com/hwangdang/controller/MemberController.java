package com.hwangdang.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwangdang.daoimpl.MemberDaoImpl;
import com.hwangdang.vo.Member;


@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	MemberDaoImpl dao;
	
	@RequestMapping("/register") //회원가입 창이 나오게 함
	public String register(){
		return "member/register.tiles";
	}
	
	@RequestMapping("/registered") //DB에 내용을 기입하고 회원가입을 완료함
	public ModelAndView member(Member member, HttpSession session) throws Exception{
		ModelAndView mv=new ModelAndView();
		mv.setViewName("/registered.jsp");
		dao.insert(member);
		return mv;
	}
}

