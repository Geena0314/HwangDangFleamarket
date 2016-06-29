<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
table, td {
	border: 1px solid gray;
	text-align: center;
}

table {
	border-collapse: collapse;
	width: 650px;
}

td {
	padding: 5px;
	height: auto;
}
#tbodyTR{
	min-height: 400px;
	height: auto;
}
</style>
<p align="right">
	<input type="button" value="목록" onclick="window.location='/HwangDangFleamarket/admin/adminNotice.go?page=${page}'">&nbsp;&nbsp;
	<c:if test="${sessionScope.login_info.memberId == 'kinghwang'}">
		<input type="button" value="공지수정" onclick="window.location='/HwangDangFleamarket/admin/adminEditForm.go?page=${page}&noticeNo=${requestScope.notice.noticeNo}'">&nbsp;&nbsp;
		<input type="button" value="공지삭제" onclick="window.location='/HwangDangFleamarket/admin/adminRemoveNotice.go?page=${page}&noticeNo=${requestScope.notice.noticeNo}'">
	</c:if>
</P>
<table>
	<thead>
		<tr>
			<td>등록일</td>
			<td><fmt:formatDate value="${requestScope.notice.noticeDate}" pattern="yyyy-MM-dd" /></td>
			<td>조회수</td>
			<td>${requestScope.notice.noticeHit}</td>
		</tr>
		<tr>
			<td>제목</td>
			<td colspan="5">${requestScope.notice.noticeTitle}</td>
		</tr>
	</thead>
	<tbody>
		<tr id="tbodyTR">
			<td colspan="6">
				${requestScope.notice.noticeContent}		
			</td>
		</tr>
	</tbody>
</table>
