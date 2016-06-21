package com.hwangdang.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hwangdang.common.util.PagingBean;
import com.hwangdang.serviceimpl.BoardQnAServiceImpl;
import com.hwangdang.vo.AdminQnA;

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
	public String noticeQnAList(Model model, int page){
		
		PagingBean pasingBean = new PagingBean(service.getTotalItems() ,page);
		ArrayList<AdminQnA> list = (ArrayList<AdminQnA>) service.getBoardList(page);
		model.addAttribute("list", list);
		model.addAttribute("pasingBean",pasingBean);
		return "admin/boardQnA_list.tiles";
	}
	
	
	
}
