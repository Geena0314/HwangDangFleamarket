package com.hwangdang.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.hwangdang.vo.Notice;

public class NoticeValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return clazz.isAssignableFrom(Notice.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Notice notice = (Notice)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "noticeTitle", "", "제목 안넣어서 오류 발생");
		
		if(notice.getNoticeTitle() != null || notice.getNoticeTitle().length()>30){
			errors.rejectValue("noticeTitle", "", "제목은 10글자 이하로 입력 가능합니다.");
		}
		if(notice.getNoticeContent() == null || notice.getNoticeContent().trim().isEmpty()){
			errors.rejectValue("noticeContent", "", "내용을 입력하세요.");
		}
	}
}
