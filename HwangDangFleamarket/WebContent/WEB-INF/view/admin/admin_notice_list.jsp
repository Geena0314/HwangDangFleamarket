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
}

a {
	text-decoration: none;
}

a:HOVER {
	text-decoration: underline;
}
b {
	font-size: 15pt;
}*/
.main{
	min-height: 600px;
}
#adminTable{
	width: 700px;
	font-size: 13pt;
}
.table-responsive{
	overflow-x: hidden; 
}
</style>
<h2 class="page-header store_look_around">황당 플리마켓 소식통</h2>
<p align="right">
	<c:if test="${sessionScope.login_info.memberId == 'kinghwang'}">
		<input type="button" value="소식글등록" onclick="window.location='/HwangDangFleamarket/admin/adminRegisterForm.go'">
	</c:if>
</p>
<div class="table-responsive adminNotice">
	<table class="table table-striped" id="adminTable">
		<thead>
			<tr class="trInput">
				<td width="100px" class="tdName">번호</td>
				<td width="325px" class="tdName">제목</td>
				<td width="175px" class="tdName">등록일</td>
				<td width="100px" class="tdName">조회수</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="list" items="${requestScope.list}">
				<tr class="trInput">
					<td class="tdName">${list.noticeNo}</td>
					<td class="tdName">
						<a href="/HwangDangFleamarket/admin/adminNoticeDetail.go?page=${requestScope.pagingBean.page}&noticeNo=${list.noticeNo}">
							${list.noticeTitle}
						</a>
					</td>
					<td class="tdName"><fmt:formatDate value="${list.noticeDate}" pattern="yyyy-MM-dd" /></td>
					<td class="tdName">${list.noticeHit}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
		<%-- 페이징 처리 --%>
	<div class="pageGroup adminNoticePaging" align="center">
		<%-- ◀이전 페이지 그룹 처리 --%>
	<c:choose>
		<c:when test="${requestScope.pagingBean.previousPageGroup}">
			<a href="/HwangDangFleamarket/admin/adminNotice.go?page=${requestScope.pagingBean.beginPage-1}">
				◀ 
			</a>
		</c:when>
		<c:otherwise>◀</c:otherwise>
	</c:choose>
	&nbsp;&nbsp;
	<%--페이지 처리 --%>
	<c:forEach begin="${requestScope.pagingBean.beginPage}"
		end="${requestScope.pagingBean.endPage}" var="page">
		<c:choose>
			<c:when test="${page == requestScope.pagingBean.page}">
	  				<b>${page}</b>
	 			</c:when>
			<c:otherwise>
				<a href="/HwangDangFleamarket/admin/adminNotice.go?page=${page}">
					${page} 
				</a>
			</c:otherwise>
		</c:choose>
	&nbsp;&nbsp;
	</c:forEach>
		<%--다음 페이지 그룹 처리 ▶--%>
		<c:choose>
			<c:when test="${requestScope.pagingBean.nextPageGroup}">
				<a href="/HwangDangFleamarket/admin/adminNotice.go?page=${requestScope.pagingBean.endPage+1}">
					▶
				</a>
			</c:when>
			<c:otherwise>▶</c:otherwise>
		</c:choose>
	</div>
</div>