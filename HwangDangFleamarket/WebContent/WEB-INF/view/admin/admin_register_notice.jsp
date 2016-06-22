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
input {
	border: none;
}
textarea {
	border: none;
}
</style>
<form action="/HwangDangFleamarket/admin/adminRegisterNotice.go?page=1" method="post">
	<table>
		<thead>
			<tr>
				<td width="70px">제목</td>
				<td>
					<input type="text" name="noticeTitle" size="70" placeholder="제목을 입력하세요.">
				</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td colspan="2">
					<textarea rows="30" cols="60" name="noticeContent"></textarea>
				</td>
			</tr>
		</tbody>
	</table>
	<p align="right">
	<input type="submit" value="등록">&nbsp;&nbsp;<input type="reset" value="다시작성">
	</p>
</form>

