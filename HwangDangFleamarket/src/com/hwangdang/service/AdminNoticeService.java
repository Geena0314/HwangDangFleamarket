package com.hwangdang.service;

import java.util.List;

import com.hwangdang.vo.Notice;

public interface AdminNoticeService {
	
	public List getAllNotice(int page);
	
	public int getCountNotice();
	
	public Notice getNoticeByNoticeNo(int noticeNo);
	
	public int adminRegisterNotice(Notice notice);
	
	public int adminEditNotice(Notice notice);
	
	public int removNotice(int noticeNo);

}
