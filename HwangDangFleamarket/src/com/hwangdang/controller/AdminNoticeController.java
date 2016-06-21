package com.hwangdang.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hwangdang.service.AdminNoticeService;

@Controller
@RequestMapping("/admin")
public class AdminNoticeController {
	
	@Autowired
	private AdminNoticeService service;
	
	@Transactional
	@RequestMapping("/adminNoticeList")
	public String adminNoticeList(Model model){
		HashMap<String,Object> map = service.selectAllNotice();
		model.addAttribute("list", map.get("list"));
		model.addAttribute("pasingBean", map.get("pasingBean"));
		return "admin/adminNotice.tiles";
	}
}
