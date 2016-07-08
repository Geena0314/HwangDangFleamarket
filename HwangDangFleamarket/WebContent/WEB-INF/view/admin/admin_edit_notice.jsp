<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style type="text/css">
/* table, td {
	border: 1px solid gray;
	text-align: center;
}

table {
	border-collapse: collapse;
	width: 300px;
}

span, td {
	padding: 5px;
	height: auto;
}
 */
#title {
	border: none;
	background-color: whitesmoke;
}
textarea {
	border: none;
	background-color: whitesmoke;
}
span{
	font-size: 11pt;
	color: red;
}
#adminTable{
	width: 500px;
	min-height: 300px;
	font-size: 13pt;
	border-top: 1px solid lightgray;
	border-bottom: 1px solid lightgray;
	border-collapse: separate;
}
.noticeRnE{
	width: 800px;
}
</style>
<h2 class="page-header store_look_around">황당 플리마켓 소식통 수정</h2>
<form action="/HwangDangFleamarket/admin/adminEditNotice.go" method="post">
	<input type="hidden" name="page" value="${param.page}">
	<input type="hidden" name="noticeNo" value="${requestScope.notice.noticeNo}">
	<div class="table-responsive noticeRnE">
		<table class="table" id="adminTable">
			<thead>
				<tr>
					<td>
						<input id="title" type="text" name="noticeTitle" size="71" value="${requestScope.notice.noticeTitle}">
					</td>
				</tr>
				<c:if test="${not empty requestScope.errors}">
					<tr>
						<td class="error">
							<form:errors path="notice.noticeTitle" delimiter=" & "/>
						</td>
					</tr>
				</c:if>
			</thead>
			<tbody>
				<tr>
					<td>
						<textarea rows="30" cols="70" name="noticeContent">${requestScope.notice.noticeContent}</textarea>
					</td>
				</tr>
				<c:if test="${not empty requestScope.errors}">
					<tr>
						<td class="error">
							<form:errors path="notice.noticeContent"/>
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<p align="left">
	<input type="submit" value="수정">
	<input type="reset" value="다시작성">
	<input type="button" value="취소" onclick="window.location='/HwangDangFleamarket/admin/adminNotice.go?page=${param.page}'">
	</p>
</form>
