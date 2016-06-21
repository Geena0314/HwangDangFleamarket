package com.hwangdang.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwangdang.common.util.PagingBean;
import com.hwangdang.service.AdminNoticeService;

@Controller
@RequestMapping("/admin")
public class AdminNoticeController{
	
	@Autowired
	private AdminNoticeService service;
	
	@Transactional
	@RequestMapping("/adminNotice")
	public ModelAndView noticeList(Model model, int page){
		HashMap map = new HashMap<>();
		PagingBean pasingBean = new PagingBean(service.getCountNotice() ,page);
		ArrayList list = (ArrayList) service.getAllNotice(page);
		map.put("list", list);
		map.put("pasingBean",pasingBean);
		return new ModelAndView("admin/adminNotice.tiles", map);
	}
}
