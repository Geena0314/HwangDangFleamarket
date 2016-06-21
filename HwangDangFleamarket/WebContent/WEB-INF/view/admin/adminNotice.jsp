<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="/HwangDangFleamarket/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#registerBtn").on("click", function(){
		
		
	
	});
});
</script>
${requestScope.pasingBean}
 <table>
 	<thead id="thead">
 		<tr>
 			<td>번호</td>
 			<td>제목</td>
 			<td>작성자</td>
 			<td>등록일</td>
 			<td>조회수</td>
 		</tr>
 	</thead>
 	<tbody id="tbody">
 		<c:forEach var="list" items="${requestScope.list}" >
			<tr>
				<td>${list.noticeNo}</td>
				<td>${list.noticeTitle}</td>
				<td>${list.noticeContent}</td>
				<td><fmt:formatDate value="${list.noticeDate}" pattern="yyyy-MM-dd"/></td>
				<td>${list.noticeHit}</td>
			</tr>
		</c:forEach>
 	</tbody>
 </table>
 <p>
 <input type="button" value="소식글등록" id="registerBtn">
