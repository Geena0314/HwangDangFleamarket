package com.hwangdang.dao;

import java.util.HashMap;
import java.util.List;

import com.hwangdang.vo.Notice;

public interface AdminNoticeDao {
	
	int insertNotice(Notice notice);
	
	int updateNotice(Notice notice);
	
	int deleteNotice(int noticeNo);

	int selectCountNotice();
	
	List<Notice> selectAllNotice(HashMap<String, Object> map);
	
	Notice selectNoticeByNoticeNo(int noticeNo);
	
	
}
