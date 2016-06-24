<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style type="text/css">
table, td {
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
}
input {
	border: none;
}
textarea {
	border: none;
}
span{
	font-size: 9pt;
	color: red;
}
</style>
<form action="/HwangDangFleamarket/sellerNotice/sellerRegisterNotice.go" method="post">
	<input type="hidden" name='page' value="1">
	<table>
		<thead>
			<tr>
				<td width="70px">제목</td>
				<td>
					<input type="text" name="sellerNoticeTitle" size="70" placeholder="제목을 입력하세요.">
				</td>
			</tr>
			<tr>
				<td colspan="2" class="error">
					<form:errors path="sellerNotice.sellerNoticeTitle"/>
				</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td colspan="2">
					<textarea rows="30" cols="60" name="sellerNoticeContent"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="error">
					<form:errors path="sellerNotice.sellerNoticeContent"/>
				</td>
			</tr>
		</tbody>
	</table>
	<p align="right">
	<input type="submit" value="등록">&nbsp;&nbsp;<input type="reset" value="다시작성">&nbsp;&nbsp;
	<input type="button" value="취소" onclick="window.location='/HwangDangFleamarket/sellerNotice/sellerNotice.go?page=1'">
	</p>
</form>
