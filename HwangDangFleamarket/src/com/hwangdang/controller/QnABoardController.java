package com.hwangdang.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hwangdang.serviceimpl.BoardQnAServiceImpl;

@Controller
@RequestMapping("/admin")
public class QnABoardController {

	@Autowired
	private BoardQnAServiceImpl service;
	
	/**
	 *  QnA게시판 전체목록조회 
	 */
	@Transactional
	@RequestMapping("/boardQnAList.go")
	public String noticeQnAList(Model model ){
		HashMap<String,Object> map = service.getBoardList();
		model.addAttribute("list", map.get("list"));
		model.addAttribute("pasingBean", map.get("pasingBean"));
		return "admin/boardQnA_list.tiles";
	}
	
	
	
}
