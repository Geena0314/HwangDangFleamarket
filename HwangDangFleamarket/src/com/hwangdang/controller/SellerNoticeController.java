package com.hwangdang.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwangdang.common.util.PagingBean;
import com.hwangdang.service.SellerNoticeService;
import com.hwangdang.vo.SellerNotice;

@Controller
@RequestMapping("sellerNotice")
public class SellerNoticeController {
	
	@Autowired
	private SellerNoticeService service;
	
	@RequestMapping("/sellerNotice")
	public ModelAndView sellerNoticeList(int page, int sellerStoreNo){
		HashMap map = new HashMap<>();
		PagingBean pagingBean = new PagingBean(service.getCountSellerNotice(sellerStoreNo),page);
		ArrayList list = (ArrayList) service.getAllSellerNotice(page, sellerStoreNo);
		map.put("list", list);
		map.put("pagingBean",pagingBean);
		map.put("sellerStoreNo", sellerStoreNo);
		return new ModelAndView("seller/seller/seller_notice_list.tiles", map);
	}
	
	@RequestMapping("/sellerNoticeDetail")
	public ModelAndView sellerNoticeDetail(int page, int sellerNoticeNo){
		SellerNotice sellerNotice = service.getSellerNoticeByNoticeNo(sellerNoticeNo);
		HashMap map = new HashMap<>();
		map.put("sellerNotice", sellerNotice);
		map.put("page", page);
		return new ModelAndView("seller/seller/seller_notice_detail.tiles", map);
	}
	
	@RequestMapping("/sellerRegisterNoticeForm")
	public ModelAndView sellerRegisterNoticeForm(int sellerStoreNo){
		System.out.println(sellerStoreNo);
		return new ModelAndView("seller/seller/seller_register_notice.tiles", "sellerStoreNo", sellerStoreNo);
	}
	
	@RequestMapping("/sellerRegisterNotice")
	public ModelAndView sellerRegisterNotice(@ModelAttribute @Valid SellerNotice sellerNotice,  BindingResult errors, int page, int sellerStoreNo){
		System.out.println(sellerStoreNo);
		if(errors.hasErrors()){
			return new ModelAndView("seller/seller/seller_register_notice.tiles");
		}
		sellerNotice.setSellerNoticeDate(new Date());
		sellerNotice.setSellerStoreNo(sellerStoreNo);
		service.sellerRegisterNotice(sellerNotice);
		HashMap map = new HashMap<>();
		map.put("page", page);
		return new ModelAndView("seller/seller/seller_notice_detail.tiles", map);
	}
	
	@RequestMapping("/sellerEditNoticeForm")
	public ModelAndView sellerEditNoticeForm(int page, int sellerNoticeNo, int sellerStoreNo){
		SellerNotice sellerNotice = service.getSellerNoticeByNoticeNo(sellerNoticeNo);
		HashMap map = new HashMap<>();
		map.put("sellerNotice", sellerNotice);
		map.put("page", page);
		map.put("sellerStoreNo", sellerStoreNo);
		return new ModelAndView("seller/seller/seller_edit_notice.tiles", map);
	}

	@RequestMapping("/sellerEditNotice")
	public ModelAndView sellerEditNotice(@ModelAttribute @Valid SellerNotice sellerNotice, BindingResult errors, int page, int sellerStoreNo){
		if(errors.hasErrors()){
			return new ModelAndView("seller/seller/seller_edit_notice.tiles");
		}
		sellerNotice.setSellerNoticeDate(new Date());
		service.sellerEditNotice(sellerNotice);
		HashMap map = new HashMap<>();
		map.put("page", page);
		map.put("sellerStoreNo",sellerStoreNo);
		return new ModelAndView("seller/seller/seller_notice_detail.tiles", map);
	}
	
	@RequestMapping("/sellerRemoveNotice")
	public ModelAndView sellerRemoveNotice(int page, int sellerNoticeNo, int sellerStoreNo){
		service.removeSellerNotice(sellerNoticeNo);
		HashMap map = new HashMap<>();
		PagingBean pagingBean = new PagingBean(service.getCountSellerNotice(sellerStoreNo),page);
		ArrayList list = (ArrayList) service.getAllSellerNotice(page, sellerStoreNo);
		map.put("list", list);
		map.put("pagingBean",pagingBean);
		map.put("sellerStoreNo",sellerStoreNo);
		return new ModelAndView("seller/seller/seller_notice_list.tiles", map);
	}
}
