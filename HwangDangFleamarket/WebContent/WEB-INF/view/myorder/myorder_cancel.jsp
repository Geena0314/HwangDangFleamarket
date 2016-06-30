<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
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

#nav_layer {
  width: 150px;
  min-height:  380px;
  float: left;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>

	$(document).ready(function(){
		
		// 주문취소 
		$("#btnRequestCancel").on("click",function(){
			
		});
		
		// 환불신청 
		$("#btnRequestRefund").on("click",function(){
			
		});
		
		// 교환신청 
		$("#btnRequestChange").on("click",function(){
			
		});
		
		//
		$("input:checkbox").on("click",function(){
			console.log(this);
		});
		
		//
		$("input[type=button]").on("click",function(){
			console.log(this);
		});
		
		
		
		
	});
</script>



<!-- 배송현황 조회
	배송현황 - 입금대기중 : 0 
	배송현황 - 결제완료 : 1
	배송현황 - 배송준비중 : 2
	배송현황 - 배송중 : 3
	배송완료 - 배송완료 : 4
	교환/환불/취소 -  교환신청 : 5
	교환/환불/취소 -  환불신청 :  6 
	교환/환불/취소 - 구매취소(배송전) :  7 
 -->

<h2>나의주문 - 교환/환불/취소</h2>
${sessionScope.login_info.memberId }
<div id="nav_layer">		
	<a href="/HwangDangFleamarket/myorder/main.go?loginId=${sessionScope.login_info.memberId }">배송 현황</a><br/><br/><br/><br/>
	<a href="/HwangDangFleamarket/myorder/success.go?loginId=${sessionScope.login_info.memberId }">배송 완료</a><br/><br/><br/><br/>
	<a href="/HwangDangFleamarket/myorder/cancel.go?loginId=${sessionScope.login_info.memberId }">교환/환불/취소</a>
</div>

<table>
	<thead>
		<tr>
			<td>체크박스</td>
			<td>상품이미지</td>
			<td>제품명</td>
			<td>판매스토어</td>
			<td>주문수량</td>
			<td>총주문가격</td>
			<td>판매자</td>
			<td>배송상태</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${requestScope.orderList }"  var="order" >
			<tr>
			<td><input type="checkbox" name="items" /></td>
			<td><img src="/HwangDangFleamarket/product_img/${order.product.productMainImage }" /></td>
			<td>${order.product.productName }</td>
			<td>${order.seller.sellerStoreName }</td>
			<td>${order.orderProduct.orderAmount}</td>
			<td>${order.ordersTotalPrice } </td> 
			<td>${order.seller.memberId }</td>
			<td>
				<c:choose>
					<c:when test="${order.ordersStatus == 5 }">교환신청</c:when>
					<c:when test="${order.ordersStatus == 6 }">환불신청</c:when>
					<c:when test="${order.ordersStatus == 7 }">구매취소</c:when>
				
				</c:choose> 
			
			 </td> 
		</tr>
		</c:forEach>
		
	</tbody>
	
		
</table>
<div id="btn_layter">
	<button id="btnRequestCancel">구매취소</button>
	<button id="btnRequestRefund">환불신청</button>
	<button id="btnRequestChange">교환신청</button>
</div>
