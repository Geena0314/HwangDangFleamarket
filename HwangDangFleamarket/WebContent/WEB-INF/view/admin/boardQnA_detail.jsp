<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style type="text/css">
section{
	width:700px;
	border:1px solid gray;
}
#title{
font-weight: bold;
border-bottom: 1px solid gray;
padding: 10px;
}
#info{
	font-size: 13px;
	border-bottom: 1px dotted gray;
	padding-top: 15px;
	padding-right: 5px;
	padding-bottom: 10px;
	text-align: right;
}
#content{
	min-height:300px; /*최소 높이 300px*/
	height:auto;/*자동으로 늘어나기*/
	padding: 10px;

}
</style>

<h3>세부조회</h3>
<!-- 	private int adminQnaNo;
	private String adminQnaTitle;
	private String adminQnaContent;
	private String adminQnaWriter;
	private Date adminQnaDate;
	private int adminQnaHit;
	private String adminQnaPublished; -->
	페이지저장 : ${requestScope.page }
<section>
	<header>
		<div id="title">${requestScope.findQnA.adminQnaTitle }</div>
		<div id="info">작성일 : <fmt:formatDate value="${requestScope.findQnA.adminQnaDate }"
		 pattern="yyyy년MM월dd일"/> | 조회수 : ${requestScope.findQnA.adminQnaHit } | 작성자 : ${requestScope.findQnA.adminQnaWriter } | 공개여부 : ${requestScope.findQnA.adminQnaPublished }</div>
	</header>
	<article id="content">${requestScope.findQnA.adminQuaContent }</article>
	<textarea rows="5" cols="35"></textarea>
</section>
<p>

<!-- 관리자일경우만 댓글달기 가능  -->
<c:if test="${sessionScope.loginId == 'admin'  }">
	<a href="/HwangDangFleamarket/admin/boardQnAReply.go?no=${requestScope.findQnA.adminQnaNo}&page=${param.page}">댓글달기</a>
</c:if>

<!-- 작성자만 수정 삭제가능  -->
<c:if test="${sessionScope.loginId == requestScope.findQnA.adminQnaWriter   }">
	<a href="/HwangDangFleamarket/admin/boardQnASet.go?no=${requestScope.findQnA.adminQnaNo}&page=${param.page}">수정하기</a>&nbsp;&nbsp;&nbsp;
	<a href="/HwangDangFleamarket/admin/boardQnARemove.go?no=${requestScope.findQnA.adminQnaNo}&page=${param.page}">삭제하기</a><br/>
</c:if>


