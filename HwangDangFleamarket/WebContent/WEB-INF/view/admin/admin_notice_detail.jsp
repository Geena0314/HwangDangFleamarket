<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link type="text/css" rel="stylesheet" href="/HwangDangFleamarket/styles/notice.css">
<style type="text/css">
#adminTable{
	width: 800px;
	min-height: 500px;
	font-size: 13pt;
	border-top: 1px solid lightgray;
	border-collapse: separate;
	position: relative;
}
td{
	text-align: left;
	border-left: none;
	border-right: none;
}
.table-responsive.notice{
	left: 20%;
}
</style>
<h2 class="page-header store_look_around">황당 플리마켓 소식통</h2>
<div class="table-responsive notice">
	<table class="table" id="adminTable">
		<thead>
			<tr style="background-color: whitesmoke;">
				<td width="550px"><b> ${requestScope.notice.noticeTitle}</b></td>
				<td width="150px" style="font-size: 10pt; vertical-align: middle;">등록일 │ <fmt:formatDate value="${requestScope.notice.noticeDate}" pattern="yyyy-MM-dd"/></td>
				<td width="100px" style="font-size: 10pt; vertical-align: middle;">조회수 │ ${requestScope.notice.noticeHit}</td>
			</tr>
		</thead>
		<tbody>
			<tr id="tbodyTR">
				<td colspan="3" style="border-bottom: 1px solid lightgray;">
					${requestScope.notice.noticeContent}
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="3" style="border-top: none;">
					<input class="noticeBtns" type="button" value="목록으로" onclick="window.location='/HwangDangFleamarket/admin/adminNotice.go?page=${page}'">
					<c:if test="${sessionScope.login_info.memberId == 'kinghwang@gmail.com'}">
						<input class="noticeBtns" type="button" value="공지수정" onclick="window.location='/HwangDangFleamarket/admin/adminEditForm.go?page=${page}&noticeNo=${requestScope.notice.noticeNo}'">
						<input class="noticeBtns" type="button" value="공지삭제" onclick="window.location='/HwangDangFleamarket/admin/adminRemoveNotice.go?page=${page}&noticeNo=${requestScope.notice.noticeNo}'">
					</c:if>
				</td>
			</tr>
		</tfoot>
	</table>
</div>
