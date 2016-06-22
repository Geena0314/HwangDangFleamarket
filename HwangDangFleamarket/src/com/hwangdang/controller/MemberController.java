package com.hwangdang.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/member")
public class MemberController {
	@RequestMapping("/register")
	public String register(){
		return "member/register.tiles";
	}
}

