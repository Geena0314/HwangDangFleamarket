<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt"   uri="http://java.sun.com/jsp/jstl/fmt"  %> 
<style>
#nav_layer{
	background-color: lightgray;
	/* margin: 1 */
	padding: 30px;
} 
table {
	border: 3px solid gray;
	padding: 30px;
	magin: 30px;
}
tr  {
	border: 1px solid black;
}


img {
	width : 100px;
	height : 70px;
}


#nav_layer {
  width: 150px;
  min-height:  380px;
  float: left;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(document).ready(function(){
	
	});
</script>

<!-- 배송현황 조회
	배송완료 -  구매확정 : 10  -->

<h2 class="page-header store_look_around">나의주문 - 배송완료</h2>
세션: ${sessionScope.login_info.memberId }

<div id="nav_layer">		
	<a href="/HwangDangFleamarket/myorder/main.go?loginId=${sessionScope.login_info.memberId }">배송 현황</a><br/><br/><br/><br/>
	<a href="/HwangDangFleamarket/myorder/success.go?loginId=${sessionScope.login_info.memberId }">배송 완료</a><br/><br/><br/><br/>
	<a href="/HwangDangFleamarket/myorder/cancel.go?loginId=${sessionScope.login_info.memberId }">교환/환불/취소</a>
</div>

<input type="hidden" id="loginId" value="${sessionScope.login_info.memberId }" />
<table>
	<thead>
		<tr>
			<td>체크박스</td> 
			<td>주문날짜 </td>  <!-- 주문상세보기버튼  -->
			<td>상품정보</td> <!-- 셀러 , 제품명 , 수량 , 주문번호  , 옵션보기버튼 ,메인옵션(추가가격) 제품가격   -->
			<td>상태</td> <!-- 배송중,결제완료 등등   -->
			<td>구매확정</td> 
		<tr>
	</thead>
	
	<tbody> 
			<c:forEach items="${requestScope.orderList }"  var="order" > 
			<tr> 
			<%--  체크박스  
				value="${order.ordersNo },${order.orderProduct.orderProductStatus} , ${order.product.productName }" 
				 --%>
				<td>
					<input type="checkbox" name="items" value="${order.ordersNo }"  />
				</td>
				
				<!-- 주문날짜 -->
				<td>
					<fmt:formatDate value="${order.orders_date }" pattern="yyyy년 MM월 dd일" /> 
				</td>
				
				<!-- 주문정보 :  셀러 , 제품명 , 수량 , 주문번호  , 옵션보기버튼 ,메인옵션(추가가격) , 제품가격   -->
				<c:forEach items="${order.orderProductList }" var="orderProduct">
					<td id="order_info">
						<img src="/HwangDangFleamarket/product_img/${orderProduct.product.productMainImage }" />
						${orderProduct.seller.sellerStoreName }
						${orderProduct.product.productName }
						${orderProduct.orderAmount}
						주문번호 :${order.ordersNo }
						<input type="button" class="detail" value="옵션보기" /> 
						옵션 :${orderProduct.productOption.optionSubName }
						수량 :${orderProduct.productOption.optionStock }개
						<font color="lightgray">(${orderProduct.productOption.optionAddPrice})</font>
						상품가격 :<fmt:formatNumber value="${orderProduct.product.productPrice }" type="currency" />
					</td>
				<td>
					<c:choose>
						<c:when test="${orderProduct.orderProductStatus  == 10 }">구매확정</c:when>
					</c:choose> 
				</td>
				
			</c:forEach>
				</tr>
		</c:forEach> 
		
	</tbody>
</table>


<!-- ***************페이징처리************************************** -->
	<!-- 페이징 ◀버튼처리 -->  
	<c:choose>
		<c:when test="${requestScope.pagingBean.previousPageGroup }">
			<a href="/HwangDangFleamarket/myorder/success.go?loginId=${sessionScope.login_info.memberId }&page=${requestScope.pagingBean.beginPage-1}">
			◀
			</a>
		</c:when>
		<c:otherwise>
		 	◁	  
		</c:otherwise>
	</c:choose>
		<!-- 페이지 번호 처리 -->  
		<c:forEach begin="${requestScope.pagingBean.beginPage }" end="${requestScope.pagingBean.endPage }" var="page">
			<c:choose>
				<c:when test="${requestScope.pagingBean.page == page }">
					<font id="currentPage" size="6px">  ${page}  </font>
				</c:when>
				<c:otherwise>
					<a href="/HwangDangFleamarket/myorder/success.go?loginId=${sessionScope.login_info.memberId }&page=${page }">${page}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	
		<!-- 페이징 ▶버튼 처리  -->
	<c:choose>
		<c:when test="${requestScope.pagingBean.nextPageGroup}">
				<a href="/HwangDangFleamarket/myorder/success.go?loginId=${sessionScope.login_info.memberId }&page=${requestScope.pagingBean.endPage +1 }">▶ </a>
		</c:when>
		<c:otherwise>
			▷	  
		</c:otherwise>
	</c:choose>


