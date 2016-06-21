package com.hwangdang.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
	@RequestMapping("/noticeQnAList.go")
	public String noticeQnAList(Model model){
		
		ArrayList<AdminQnA> list =(ArrayList<AdminQnA> ) service.getBoardList();
		for(AdminQnA temp : list){
			System.out.println(temp);
			
		}
		model.addAttribute("list" , list);
		
		return "/WEB-INF/view/admin/boardQnA_list.jsp";
	}
	
	
	
}
