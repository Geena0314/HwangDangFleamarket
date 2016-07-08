<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
/* table, td {
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
} */
#adminTable{
	width: 800px;
	min-height: 500px;
	font-size: 13pt;
	border-top: 1px solid lightgray;
	border-bottom: 1px solid lightgray;
	border-collapse: separate;
}
td{
	text-align: left;
	border-left: none;
	border-right: none;
}
</style>
<h2 class="page-header store_look_around">황당 플리마켓 소식통</h2>
<p align="right">
	<input type="button" value="목록" onclick="window.location='/HwangDangFleamarket/admin/adminNotice.go?page=${page}'">&nbsp;&nbsp;
	<c:if test="${sessionScope.login_info.memberId == 'kinghwang'}">
		<input type="button" value="공지수정" onclick="window.location='/HwangDangFleamarket/admin/adminEditForm.go?page=${page}&noticeNo=${requestScope.notice.noticeNo}'">&nbsp;&nbsp;
		<input type="button" value="공지삭제" onclick="window.location='/HwangDangFleamarket/admin/adminRemoveNotice.go?page=${page}&noticeNo=${requestScope.notice.noticeNo}'">
	</c:if>
</P>
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
				<td colspan="6">
					${requestScope.notice.noticeContent}		
				</td>
			</tr>
		</tbody>
	</table>
</div>
