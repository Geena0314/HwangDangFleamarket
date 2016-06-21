package com.hwangdang.daoimpl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hwangdang.dao.NoticeDao;
import com.hwangdang.vo.Notice;

@Repository
public class NoticeDaoImpl implements NoticeDao{
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Notice> selectAllNotice() {
		return session.selectList("adminNoticeMapper.selectAllNotice");
	}
	
	
	

}
