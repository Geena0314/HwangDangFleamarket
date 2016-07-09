<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style type="text/css">
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

수정폼이동!
no :${param.no}
page :${param.page}


<h2 class="page-header store_look_around">황당 플리마켓 QnA게시판</h2>
<form action="/HwangDangFleamarket/admin/boardQnASet.go" method="post">
	<input type="hidden" name="page" value="${param.page}">
	<input type="hidden" name="noticeNo" value="${requestScope.notice.noticeNo}">
	<div class="table-responsive noticeRnE ">
		<table class="table" id="adminTable">
			<thead>
				<tr>
					<td>
						<b><input id="title" type="text" name="noticeTitle" size="71" value="${requestScope.adminQnA.adminQnaTitle}"></b>
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
						<textarea rows="30" cols="70" name="noticeContent">${requestScope.adminQnA.adminQnaContent}</textarea>
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
	<p class="text-center">
	<input type="submit" value="수정" class="btn btn-default" role="button"  >
	<input type="reset" value="다시작성" class="btn btn-default" role="button" >
	<input type="button" value="취소"class="btn btn-default" role="button"
	 onclick="window.location='/HwangDangFleamarket/admin/adminNotice.go?page=${param.page}'">
	</p>
</form>



