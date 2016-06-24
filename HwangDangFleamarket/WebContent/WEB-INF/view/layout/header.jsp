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
		<c:choose>
			<c:when test="${not empty sessionScope.login_info }">
				<a href="/HwangDangFleamarket/member/logout.go" onclick="return confirm('로그아웃할꺼?')">로그아웃</a>&nbsp;&nbsp;
			</c:when>
			<c:otherwise>
				<a href="/HwangDangFleamarket/member/login.go">로그인</a>&nbsp;&nbsp;
				<a href="/HwangDangFleamarket/member/register.go">회원가입</a>&nbsp;&nbsp;
			</c:otherwise>
		</c:choose>
			<a href="#">my page</a>&nbsp;&nbsp;
			<a href="#">나의주문</a>&nbsp;&nbsp;
			<a href="#">장바구니</a>&nbsp;&nbsp;
		</div>
	</div>