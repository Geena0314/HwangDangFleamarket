package com.hwangdang.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

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
	/**
	 *  QnA게시판 NO번호로 세부조회  
	 */
	@Transactional
	@RequestMapping("/boardQnADetail.go")
	public String boardQnADetail(int page , int no , Model model){
		//System.out.println(page +"," +no);
		AdminQnA findQnA = service.getAdminQnAByNo(no);
		//System.out.println(findQnA);
		model.addAttribute("findQnA",findQnA);
		model.addAttribute("page",page);
		return "admin/boardQnA_detail.tiles";  
	}
	/**
	 *  QnA게시판 No번호로 글 수정 - 작성자만 가능  
	 */
	@Transactional
	@RequestMapping("/boardQnASet.go")
	public String boardQnASet( int no , int page , Model model){
		
		return "admin/boardQnA_list.tiles?page="+page;
	}
	/**
	 *  QnA게시판 No번호로 글 삭제 - 작성자만 가능  
	 */
	@Transactional
	@RequestMapping("/boardQnARemove.go")
	public String boardQnARemove( int no , int page , Model model){
		service.removeAdminQnAByNo(no);
	return "admin/boardQnA_list.tiles?page="+page;
	}
	
	/**
	 *  QnA게시판 댓글달기 - 관리자만가능  
	 */
	@Transactional
	@RequestMapping("/boardQnAReply.go")
	public String boardQnAReply( int no , int page , Model model){
		
	return "";
	}
	
}
