<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
#home
{
	margin-left:10px;
	float:left;
}
#menuLinks
{
	margin-right:10px;
	float:right;
}
#navBar
{
	height:20px;
}
</style>
	<c:choose>
		<c:when test="${requestScope.seller.sellerStoreName==null}">
			<h2>황당 플리마켓</h2>
		</c:when>
		<c:otherwise>
			<h2>${requestScope.seller.sellerStoreName}</h2>
		</c:otherwise>
	</c:choose>
	<div id="navBar">
		<div id="home">
			<a href="/HwangDangFleamarket/main.go">메인</a>

		</div>
		<div id="menuLinks">
			<a href="#">로그인</a>&nbsp;&nbsp;
			<a href="/HwangDangFleamarket/member/register.go?page=1">회원가입</a>&nbsp;&nbsp;
			<a href="#">my page</a>&nbsp;&nbsp;
			<a href="#">나의주문</a>&nbsp;&nbsp;
			<a href="#">장바구니</a>&nbsp;&nbsp;
		</div>
	</div>