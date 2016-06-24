package com.hwangdang.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hwangdang.dao.AdminNoticeDao;
import com.hwangdang.service.AdminNoticeService;
import com.hwangdang.vo.Notice;

@Service
public class AdminNoticeServiceImpl implements AdminNoticeService{
	
	@Autowired
	private AdminNoticeDao dao;

	@Override
	public int adminRegisterNotice(Notice notice) {
		return dao.insertNotice(notice);
	}

	@Override
	public int adminEditNotice(Notice notice) {
		return dao.updateNotice(notice);
	}

	@Override
	public List getAllNotice(int page) {
		return dao.selectAllNotice(page);
	}

	@Override
	public int getCountNotice() {
		return dao.selectCountNotice();
	}

	@Override
	public Notice getNoticeByNoticeNo(int noticeNo){
		Notice notice = dao.selectNoticeByNoticeNo(noticeNo);
		dao.updateNoticeHit(noticeNo);
		String replace = notice.getNoticeContent().replaceAll("\n", "<br>");
		notice.setNoticeContent(replace);
		return notice;
	}

	@Override
	public int removNotice(int noticeNo) {
		return dao.deleteNotice(noticeNo);
	}
}
