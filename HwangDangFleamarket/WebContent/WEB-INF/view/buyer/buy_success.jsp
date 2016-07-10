<%@page contentType="text/html;charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"  %>
<style>
	#layer{
		width : 1000px;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$("#gotoMainBtn").click(function(){
			location.href = "/HwangDangFleamarket/main.go";
			
		});
	});

</script>


<%-- 세션멤버 : ${sessionScope.login_info.memberId }
세션orders: ${sessionScope.orders} --%>

<div id="layer">

	<h3>배송정보</h3>
	받는사람 : ${sessionScope.orders.ordersReceiver } <br/>
	배송지 :[${sessionScope.orders.ordersZipcode }] 
	${sessionScope.orders.ordersAddress } 
	${sessionScope.orders.ordersSubAddress } 
	 / ${sessionScope.orders.ordersPhone }<br/>
	 ${sessionScope.orders.ordersRequest }  
	<hr/>
	
	  <!-- 결제방식 0 무통장입금 : , 1카드결제 , 2자동이체 , 3.간편결제       -->
	  <!--  결제여부 0 : 미결제  , 1. 결제완료  -->
	<h3>결제정보</h3>
		결제방식 :
		<c:choose>
			<c:when test="${sessionScope.orders.ordersPayment  == 0 }">무통장입금</c:when>
			<c:when test="${sessionScope.orders.ordersPayment  == 1 }">카드</c:when>
			<c:when test="${sessionScope.orders.ordersPayment  == 2 }">자동이체</c:when>
			<c:otherwise>간편결제</c:otherwise>
		</c:choose>
		/결제여부 : 
		<c:choose>
			<c:when test="${sessionScope.orders.ordersPayment  == 0 }">입금전 </c:when>
			<c:otherwise>결제 완료</c:otherwise>
		</c:choose>
		<br/>		
		<c:choose>
			<c:when test="${sessionScope.bank != null }">
				 은행명 : ${sessionScope.bank }
				 계좌번호 : ${sessionScope.vitualBankNo }
		
			</c:when>
			<c:when test="${sessionScope.card != null }">
				 카드회사 : ${sessionScope.card }
				 할부 : ${sessionScope.quota }
			</c:when>
		</c:choose>
		<br/>
		<font size="8px" color="blue"><fmt:formatNumber type="currency"> ${sessionScope.orders.ordersTotalPrice }
		 </fmt:formatNumber> 원</font><br/>
		
		
		<%
			// 세션정보 삭제!
			if(session.getAttribute("bank") != null){
				session.removeAttribute("bank");
				session.removeAttribute("vitualBankNo");
			}else if(session.getAttribute("card") != null){
				session.removeAttribute("card");
				session.removeAttribute("quota");
			}
		%>
	<hr/>	         


	<h3>주문정보</h3>
	주문번호 : ${sessionScope.orders.ordersNo } <br/> 
	<c:forEach  var="op" items="${sessionScope.orders.orderProductList }">
		상품명/가격  :  ${op.product.productName } / ${op.product.productPrice } <br/>
		수량/옵션정보 :  ${op.orderAmount}개    / ${op.productOption.optionSubName } 
	</c:forEach> 
	
	<h2>${sessionScope.login_info.memberId }님!  
	${sessionScope.orders.ordersAddress } 
	${sessionScope.orders.ordersSubAddress } </h2> 
	<font size="9px" color="lightgray">(으)로 보내실 주문이 완료 되었습니다.
	<br/>저희 마켓을 이용해주셔서 감사합니다.</font>
	<input type="button" value="주문확인" id="gotoMainBtn"/>
	<hr/>	
</div>



