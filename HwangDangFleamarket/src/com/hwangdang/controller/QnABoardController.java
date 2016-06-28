package com.hwangdang.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hwangdang.common.util.PagingBean;
import com.hwangdang.serviceimpl.BoardQnAServiceImpl;
import com.hwangdang.vo.AdminQnA;
import com.hwangdang.vo.AdminQnAReply;

@Controller
@RequestMapping("/admin")
public class QnABoardController {

	@Autowired
	private BoardQnAServiceImpl service;
	
	
	//QnA게시판 글등록 
	@RequestMapping("/register.go")
	public String registerQnAContent( String loginId , String title , String password , String published ,String content  ){
		System.out.println("로그인아이디 :" + loginId +"title : "+title+", published :" + published + "content: " + content);
		int seq = service.getQnABoardSeq();
		System.out.println(seq);
		AdminQnA newQnA = new AdminQnA(seq , title, content, loginId.trim(), new Date(), 1, published, password);
		service.registerNewQnA(newQnA);
		return "/admin/boardQnADetail.go?page="+1 +"&no="+seq;
	} 
	
	/**
	 *  QnA게시판 전체목록조회 
	 */
	@RequestMapping("/boardQnAList.go")
	public String noticeQnAList(Model model, int page){
		//System.out.println("page: " + page);
		PagingBean pasingBean = new PagingBean(service.getTotalItems() ,page);
		ArrayList<AdminQnA> list = (ArrayList<AdminQnA>) service.getBoardList(page);
		model.addAttribute("list", list);
		model.addAttribute("pasingBean",pasingBean);
		return "admin/boardQnA_list.tiles";
	}
	
	/**
	 *  QnA게시판 NO번호로 세부조회  
	 */
	@RequestMapping("/boardQnADetailBefore.go")
	public String boardQnADetailBefore(int page , int no , Model model){
		
		String url = "";
		AdminQnA findQnA = service.getAdminQnAByNo(no);
		if(findQnA.getAdminQnaPublished().equals("t")){
			//공개
			url ="/admin/boardQnADetail.go"; 
		}else{
			//비공개 
			//System.out.println("비밀번호:" + findQnA.getAdminQnaPassword()); 
			model.addAttribute("password" , findQnA.getAdminQnaPassword());
			url="admin/boardQnA_detail_before.tiles";
		}
	return url;
	}
	
	/**
	 *  QnA게시판 NO번호로 세부조회  
	 */
	@RequestMapping("/boardQnADetail.go")
	public String boardQnADetail(int page , int no , String password , Model model){
		
		System.out.println("디테일메소드:" + "페이지 :"+page +",NO: " +no + "password :" + password); 
		String url = "";
		AdminQnA findQnA = service.getAdminQnAByNo(no);
		
		if(findQnA.getAdminQnaPublished().equals("f")){
			if(password.equals(findQnA.getAdminQnaPassword() )){
				//비공개에 비밀번호가 일치하면 
				//System.out.println(findQnA);
				//System.out.println(findQnA.getReply());
				model.addAttribute("findQnA",findQnA);
				model.addAttribute("page",page);
				url = "admin/boardQnA_detail.tiles";
			}else{
				//비공개에 비밀번호가 불일치
				System.out.println("비밀번호가 틀렸습니다.");
				url="admin/boardQnA_detail_before.tiles";
				model.addAttribute("errorMsg","비밀번호가 틀렸습니다.");
			}
		}else{
			//공개이면
			model.addAttribute("findQnA",findQnA);
			model.addAttribute("page",page);
			url = "admin/boardQnA_detail.tiles";
		}
		
	return url;  
	}
	/**
	 *  QnA게시판 No번호로 글 수정 - 작성자만 가능  
	 */
	@RequestMapping("/boardQnASet.go")
	@ResponseBody
	public AdminQnA boardQnASet( int no , int page , String content, Model model){
		HashMap<String,Object> param = new HashMap<>();
		param.put("no", no);
		param.put("content", content);
		param.put("setDate", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		//수정처리
		service.setAdminQnAByNo(param);
		//수정된 공지글 조회 
		AdminQnA obj = service.getAdminQnAByNo(no);
		//System.out.println(obj);
	return obj;  
	}
	/**
	 *  QnA게시판 No번호로 질문글 삭제 - 작성자만 가능  
	 */
	@RequestMapping("/boardQnARemove.go")
	public String boardQnARemove( int no , int page , Model model){
		service.removeAdminQnAByNo(no);
	return "/admin/boardQnAList.go";
	}
	
	/**
	 *  QnA게시판 댓글달기 add - 관리자만가능  
	 */			
	@RequestMapping("/addBoardQnAReply.go")
	public String addBoardQnAReply( int contentNo , int contentPage , String replyTa , Model model){
		//System.out.println(contentNo + "," + replyTa);
		String writeDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		AdminQnAReply reply = new AdminQnAReply(replyTa, writeDate, "관리자", contentNo);
		service.addReply(reply);
		model.addAttribute("reply", reply);
	return "/admin/boardQnADetail.go?page="+contentPage +"&no="+contentNo;
	}
	  /**
	   * QnA게시판 관리자 댓글삭제
	   */
	@RequestMapping("/removeBoardQnAReply.go")
	public String removeBoardQnAReply( int contentNo , int replyNo ,int contentPage ){
		service.removeReplyByNo(replyNo);  
		return "/admin/boardQnADetail.go?page="+contentPage +"&no="+contentNo;
	}
	 /**
	   * QnA게시판 관리자 댓글삭제
	   */
	@RequestMapping("/setBoardQnAReply.go")
	public String setBoardQnAReply( int contentNo , int replyNo ,int contentPage ,String replyTa ){
		/*System.out.println("댓글수정 -  댓글번호:" + replyNo + " , 글번호 no :" +contentNo +"페이지번호:" + contentPage);
		System.out.println("수정한 댓글내용" + replyTa);*/
		HashMap<String,Object> param = new HashMap<>();
		param.put("replyNo", replyNo);
		param.put("replyTa", replyTa);
		param.put("setDate", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		service.setReplyByNo(param);
	return "/admin/boardQnADetail.go?page="+contentPage +"&no="+contentNo;
	}
	

	
}
