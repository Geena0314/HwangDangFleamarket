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
	width: 650px;
}

span, td {
	padding: 5px;
	height: auto;
} */
span{
	font-size: 11pt;
	color: red;
}
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
<h2 class="page-header store_look_around">황당 플리마켓 소식통 등록</h2>
<form action="/HwangDangFleamarket/admin/adminRegisterNotice.go" method="post">
	<input type="hidden" name='page' value="1">
	<div class="table-responsive noticeRnE">
		<table class="table" id="adminTable">
			<thead>
				<tr>
					<td>
						<input id="title" type="text" name="noticeTitle" size="71" placeholder="제목을 입력하세요.">
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
						<textarea rows="30" cols="70" name="noticeContent"></textarea>
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
	<input type="submit" value="등록">
	<input type="reset" value="다시작성">
	<input type="button" value="취소" onclick="window.location='/HwangDangFleamarket/admin/adminNotice.go?page=1'">
	</p>
</form>

