<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>

	$(document).ready(function(){
			
			   $("#searchBtn").on("click" , function(){
				   alert("test@@@@@@@@"); 
		  			/* alert($("input[name='keyword']").val());
		  			var keyword = $("input[name='keyword']").val();
		  			if(keyword.length == 0){
		  				alert("검색어를 입력하세요.");
		  			} */
		  		});
		
	});
</script>
<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/HwangDangFleamarket/main.go">
				<c:choose>
					<c:when test="${requestScope.seller.sellerStoreName==null}">
					황당 플리마켓
					</c:when>
					<c:otherwise>
					${requestScope.seller.sellerStoreName}
					</c:otherwise>
				</c:choose>
			</a>
		</div>
		
			
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-right">
				<li>
					<!-- 검색바 -->
					<form action="/HwangDangFleamarket/buy/findProductByKeyword.go" method="POST" >
						<input type="text"  size="30" name="keyword" placeholder="상품/판매자 검색" class="navbar-form navbar-right" >
						<input class="btn btn-info" type="submit" value="검색"  id="searchBtn">
					</form>   
					
				</li>
				<c:choose>
					<c:when test="${not empty sessionScope.login_info }">
						<li><a href="/HwangDangFleamarket/member/logout.go" onclick="return confirm('로그아웃할꺼?')">로그아웃</a></li>
						<li><a href="/HwangDangFleamarket/member/mypage.go">my page</a></li>
						<li><a href="/HwangDangFleamarket/myorder/main.go?loginId=${sessionScope.login_info.memberId }">나의주문</a></li>
						<li><a href="/HwangDangFleamarket/cart/cartList.go?memberId=${sessionScope.login_info.memberId}">장바구니</a></li>
					</c:when>
					<c:otherwise> 
						<li><a href="#" onClick="window.open('/HwangDangFleamarket/member/login.go', '로그인창', 'resizable=no scrollbars=yes width=700 height=450 left=500 top=200');">로그인</a></li>
						<li><a href="/HwangDangFleamarket/member/register.go">회원가입</a></li>
						<li><a href="#" onClick="if(confirm('로그인이 필요한 서비스입니다. \n로그인 하시겠습니까?')){window.open('/HwangDangFleamarket/member/login.go', '로그인창', 'resizable=no scrollbars=yes width=700 height=450 left=500 top=200');};">my page</a></li>
						<li><a href="#" onClick="if(confirm('로그인이 필요한 서비스입니다. \n로그인 하시겠습니까?')){window.open('/HwangDangFleamarket/member/login.go', '로그인창', 'resizable=no scrollbars=yes width=700 height=450 left=500 top=200');};">나의주문</a></li>
						<li><a href="#" onClick="if(confirm('로그인이 필요한 서비스입니다. \n로그인 하시겠습니까?')){window.open('/HwangDangFleamarket/member/login.go', '로그인창', 'resizable=no scrollbars=yes width=700 height=450 left=500 top=200');};">장바구니</a></li>
					</c:otherwise> 
				</c:choose>
				<c:if test="${ sessionScope.login_info.memberAssign == 1 && sessionScope.seller.sellerAssign == 1}}">
					<li><a href="/HwangDangFleamarket/seller/sellerStore.go?sellerStoreNo=${sessionScope.seller.sellerStoreNo}&sellerStoreImage=${sessionScope.seller.sellerStoreImage}">내 스토어</a></li>
				</c:if>
			</ul>
         
		</div>
	</div>
	
	
</nav>