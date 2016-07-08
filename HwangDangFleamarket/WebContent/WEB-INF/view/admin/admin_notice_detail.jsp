<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
#adminTable{
	width: 800px;
	min-height: 500px;
	font-size: 13pt;
	border-top: 1px solid lightgray;
	border-collapse: separate;
}
td{
	text-align: left;
	border-left: none;
	border-right: none;
}
</style>
<h2 class="page-header store_look_around">황당 플리마켓 소식통</h2>
<div class="table-responsive adminNotice">
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
					<input type="button" value="목록" onclick="window.location='/HwangDangFleamarket/admin/adminNotice.go?page=${page}'">
					<c:if test="${sessionScope.login_info.memberId == 'kinghwang@gmail.com'}">
						<input type="button" value="공지수정" onclick="window.location='/HwangDangFleamarket/admin/adminEditForm.go?page=${page}&noticeNo=${requestScope.notice.noticeNo}'">
						<input type="button" value="공지삭제" onclick="window.location='/HwangDangFleamarket/admin/adminRemoveNotice.go?page=${page}&noticeNo=${requestScope.notice.noticeNo}'">
					</c:if>
				</td>
			</tr>
		</tfoot>
	</table>
</div>
