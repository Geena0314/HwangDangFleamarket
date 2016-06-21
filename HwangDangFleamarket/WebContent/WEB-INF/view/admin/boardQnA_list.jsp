<%@ page contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt"   uri="http://java.sun.com/jsp/jstl/fmt" %>
<h1>황당 플리마켓 QnA</h1>
	<table>
		<thead>
			<tr>
				<td>글번호</td>
				<td>글제목</td>
				<td>작성자</td>
				<td>작성일</td>
				<td>조회수</td>
				<td>공개여부</td>
			</tr>
		</thead>
		<tbody>
			
				<c:forEach var="list" items="${requestScope.list }" >
				<tr>
					<td>${list.adminQnaNo }</td>
					<td><a href="#">${list.adminQnaTitle }</a></td>
					<td>${list.adminQnaWriter }</td>
					<td><fmt:formatDate value="${list.adminQnaDate }" pattern="yyyy년MM월dd일"/></td>
					<td>${list.adminQnaHit }</td>
					 <c:choose>
						<c:when test="${list.adminQnaPublished == 't'}">
							<td>공개</td>
						</c:when>
						<c:otherwise>
							<td>비공개</td>
						</c:otherwise>   
					</c:choose>
				</tr>
				</c:forEach>
		</tbody>
	</table>
	<!-- ◀버튼처리 -->  
	<c:choose>
		<c:when test="${requestScope.pasingBean.previousPageGroup }">
			<a href="/HwangDangFleamarket/admin/boardQnAList.go?page=${requestScope.pasingBean.beginPage-1}">
			◀
			</a>
		</c:when>
		<c:otherwise>
		 	◁	  
		</c:otherwise>
	</c:choose>
	
		<!-- 페이징처리 -->
		<c:forEach begin="${requestScope.pasingBean.beginPage }" end="${requestScope.pasingBean.endPage }" var="page">
			<c:choose>
				<c:when test="${requestScope.pasingBean.page == page }">
					[ ${page} ]
				</c:when>
				<c:otherwise>
					<a href="/HwangDangFleamarket/admin/boardQnAList.go?page=${page }">${page}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	
		<!-- ▶버튼 처리  -->
	<c:choose>
		<c:when test="${requestScope.pasingBean.nextPageGroup}">
				<a href="/HwangDangFleamarket/admin/boardQnAList.go?page=${requestScope.pasingBean.endPage +1 }">▶ </a>
		</c:when>
		<c:otherwise>
			▷	  
		</c:otherwise>
	</c:choose>
	
	
	