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
}

a {
	text-decoration: none;
}

a:HOVER {
	text-decoration: underline;
}
b {
	font-size: 15pt;
}
</style>
<script type="text/javascript">

</script>
<p align="right">
	<b>스토어 소식통</b>
	<c:if test="${sessionScope.seller.sellerStoreNo == param.sellerStoreNo}">
	<input type="button" id="rgstBtn" value="소식글등록" onclick="window.location='/HwangDangFleamarket/sellerNotice/sellerRegisterNoticeForm.go?sellerStoreNo=${requestScope.sellerStoreNo}&sellerStoreImage=${param.sellerStoreImage}'">
	</c:if>
</p>
<table>
	<thead>
		<tr>
			<td>제목</td>
			<td>등록일</td>
			<td>조회수</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="list" items="${requestScope.list}">
			<tr>
				<td>
					<a href="/HwangDangFleamarket/sellerNotice/sellerNoticeDetail.go?page=${requestScope.pagingBean.page}&sellerNoticeNo=${list.sellerNoticeNo}&sellerStoreNo=${requestScope.sellerStoreNo}&sellerStoreImage=${param.sellerStoreImage}">
						${list.sellerNoticeTitle}
					</a>
				</td>
				<td><fmt:formatDate value="${list.sellerNoticeDate}" pattern="yyyy-MM-dd" /></td>
				<td>${list.sellerNoticeHit}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
	
	<%-- 페이징 처리 --%>
<p align="center">
	<%-- ◀이전 페이지 그룹 처리 --%>
<c:choose>
	<c:when test="${requestScope.pagingBean.previousPageGroup}">
		<a href="/HwangDangFleamarket/sellerNotice/sellerNotice.go?page=${requestScope.pagingBean.beginPage-1}">
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
			<a href="/HwangDangFleamarket/sellerNotice/sellerNotice.go?page=${page}">
				${page} 
			</a>
		</c:otherwise>
	</c:choose>
&nbsp;&nbsp;
</c:forEach>
	<%--다음 페이지 그룹 처리 ▶--%>
	<c:choose>
		<c:when test="${requestScope.pagingBean.nextPageGroup}">
			<a href="/HwangDangFleamarket/sellerNotice/sellerNotice.go?page=${requestScope.pagingBean.endPage+1}">
				▶
			</a>
		</c:when>
		<c:otherwise>▶</c:otherwise>
	</c:choose>
</p>