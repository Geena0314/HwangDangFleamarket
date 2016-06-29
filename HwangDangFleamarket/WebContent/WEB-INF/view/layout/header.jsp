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
				<a href="/HwangDangFleamarket/member/mypageCheck.go">my page</a>&nbsp;&nbsp;
				<a href="/HwangDangFleamarket/myorder/main.go">나의주문</a>&nbsp;&nbsp;
				<a href="/HwangDangFleamarket/cart/cartList.go">장바구니</a>&nbsp;&nbsp;
			</c:when>
			<c:otherwise> 
				<a href="#" onClick="window.open('/HwangDangFleamarket/member/login.go', '로그인창', 'resizable=no scrollbars=yes width=500 height=400 left=500 top=200');">로그인</a>&nbsp;&nbsp;
				<a href="/HwangDangFleamarket/member/register.go">회원가입</a>&nbsp;&nbsp;
				<a href="#" onClick="if(confirm('로그인이 필요한 서비스입니다. \n로그인 하시겠습니까?')){window.open('/HwangDangFleamarket/member/login.go', '로그인창', 'resizable=no scrollbars=yes width=500 height=400 left=500 top=200');};">my page</a>&nbsp;&nbsp;
				<a href="#" onClick="if(confirm('로그인이 필요한 서비스입니다. \n로그인 하시겠습니까?')){window.open('/HwangDangFleamarket/member/login.go', '로그인창', 'resizable=no scrollbars=yes width=500 height=400 left=500 top=200');};">나의주문</a>&nbsp;&nbsp;
				<a href="#" onClick="if(confirm('로그인이 필요한 서비스입니다. \n로그인 하시겠습니까?')){window.open('/HwangDangFleamarket/member/login.go', '로그인창', 'resizable=no scrollbars=yes width=500 height=400 left=500 top=200');};">장바구니</a>&nbsp;&nbsp;
			</c:otherwise> 
		</c:choose>
		<c:if test="${ sessionScope.login_info.memberAssign == 1}">
			<a href="/HwangDangFleamarket/seller/sellerStore.go?sellerStoreNo=${sessionScope.seller.sellerStoreNo}&sellerStoreImage=${sessionScope.seller.sellerStoreImage}">내 스토어</a>
		</c:if>
		</div>
	</div>