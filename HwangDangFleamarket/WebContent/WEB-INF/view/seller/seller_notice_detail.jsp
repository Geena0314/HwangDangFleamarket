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
	<input type="button" value="목록" onclick="window.location='/HwangDangFleamarket/sellerNotice/sellerNotice.go?page=${page}&sellerStoreNo=${requestScope.sellerNotice.sellerStoreNo}'">&nbsp;&nbsp;
	<input type="button" value="공지수정" onclick="window.location='/HwangDangFleamarket/sellerNotice/sellerEditNoticeForm.go?page=${page}&sellerNoticeNo=${requestScope.sellerNotice.sellerNoticeNo}&sellerStoreNo=${requestScope.sellerNotice.sellerStoreNo}'">&nbsp;&nbsp;
	<input type="button" value="공지삭제" onclick="window.location='/HwangDangFleamarket/sellerNotice/sellerRemoveNotice.go?page=${page}&sellerNoticeNo=${requestScope.sellerNotice.sellerNoticeNo}&sellerStoreNo=${requestScope.sellerNotice.sellerStoreNo}'">
</P>
<table>
	<thead>
		<tr>
			<td>등록일</td>
			<td><fmt:formatDate value="${requestScope.sellerNotice.sellerNoticeDate}" pattern="yyyy-MM-dd" /></td>
			<td>조회수</td>
			<td>${requestScope.sellerNotice.sellerNoticeHit}</td>
		</tr>
		<tr>
			<td>제목</td>
			<td colspan="5">${requestScope.sellerNotice.sellerNoticeTitle}</td>
		</tr>
	</thead>
	<tbody>
		<tr id="tbodyTR">
			<td colspan="6">
				${requestScope.sellerNotice.sellerNoticeContent}		
			</td>
		</tr>
	</tbody>
</table>
