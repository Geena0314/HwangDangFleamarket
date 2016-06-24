package com.hwangdang.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwangdang.dao.MemberDao;
import com.hwangdang.daoimpl.MemberDaoImpl;
import com.hwangdang.vo.Member;


@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao dao;
	
	@RequestMapping("/register") //회원가입 창이 나오게 함
	public String register(){
		return "member/register.tiles";
	}
	
	@RequestMapping("/registered") //DB에 내용을 기입하 고 회원가입을 완료함
	public ModelAndView member(Member member, HttpSession session) throws Exception{
		System.out.println(member);
		ModelAndView mv=new ModelAndView();
		dao.insert(member);
		//mv.setViewName("/member/registerResult.go");
		return new ModelAndView("member/registerResult.tiles");
	}
}

