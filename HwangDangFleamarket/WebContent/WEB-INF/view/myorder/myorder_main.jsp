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
		var flag = false;
		var orderCancelList = "";
		var url = "";
		var loginId = $("#loginId").val();
		
		//폼전송
		function sendForm(url){
			if(flag){ 
				flag = false;
				orderCancelList = orderCancelList.substring( 0 ,orderCancelList.length-1);
				console.log("2:" +orderCancelList);
				$("form").prop("action" , url);
				$("form").submit();
			}
		}  
		//체크박스검증 및 orderList 검증  
		function checkboxValidation(num1 , num2 , num3 , msg ){
			if( !$("input:checkbox").is(":checked") ){  //true,false
				alert("체크박스를선택해주세요.");
			}else{
				// 체크박스선택하였고 주문취소가 가능한 상태인지 검증 
				orderCancelList = "";
				$("input:checkbox:checked").each(function(){
					//console.log($(this).val());
					//console.log($(this).parent().parent());
					var tr = $(this).parent().parent();
					//console.log($(tr).children().eq(8).text());
					var str = $(this).val();
					str = str.split(",");
					var orderNo = str[0];  
					var orderStatus = str[1]; 
					var orderproductName = str[2];
					
					if(orderStatus == num1 || orderStatus ==num2 || orderStatus ==num3 ){
						//취소할 주문번호 배열에 누적 
						orderCancelList = orderCancelList + orderNo +","
						flag = true;
						
					}else{
						alert( msg );
					}
				}); //orderList 누적 for문
			} //else 
				
			//alert("오더리스트는: "+orderCancelList);
			 
		}
		// 주문취소 
		$("#btnRequestCancel").on("click",function(){
			checkboxValidation(0 , 1 , 2 ,  "상품 발송후에는 주문취소를 할수없습니다. " );
			url	="/HwangDangFleamarket/myorder/orderCancelList.go?orderCancelList="+orderCancelList+"&loginId="+loginId;
			sendForm(url);
		}); //btn 
		
		
		// 환불신청 
		$("#btnRequestRefund").on("click",function(){
			checkboxValidation(4 , 3, -1  , "배송완료상품만 환불을 신청할수 있습니다.");
			url	="/HwangDangFleamarket/myorder/orderStatusChange.go?orderList="+orderCancelList+"&loginId="+loginId +"&status="+6;
			sendForm(url);
		});
		
		// 교환신청 
		$("#btnRequestChange").on("click",function(){
			checkboxValidation(4 , 3, -1  , "배송완료상품만 교환을 신청할수 있습니다.");
			url	="/HwangDangFleamarket/myorder/orderStatusChange.go?orderList="+orderCancelList+"&loginId="+loginId+"&status="+5;
			sendForm(url);
		});
		
		//
		/* $("input:checkbox").on("click",function(){
			console.log(this);
		}); */
		
		//
		/* $("input[type=button]").on("click",function(){
			console.log(this);
		}); */
		
		
		
		
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

<h2>나의주문 - 배송현황</h2>
세션: ${sessionScope.login_info.memberId }

<div id="nav_layer">		
	<a href="/HwangDangFleamarket/myorder/main.go?loginId=${sessionScope.login_info.memberId }">배송 현황</a><br/><br/><br/><br/>
	<a href="/HwangDangFleamarket/myorder/success.go?loginId=${sessionScope.login_info.memberId }">배송 완료</a><br/><br/><br/><br/>
	<a href="/HwangDangFleamarket/myorder/cancel.go?loginId=${sessionScope.login_info.memberId }">교환/환불/취소</a>

</div>
<form action="/"  method="post">
<input type="hidden" id="loginId" value="${sessionScope.login_info.memberId }" />
<table>
	<thead>
		<tr>
			<td>체크박스</td> <!--  -->
			<td>상품이미지</td> <!--  -->
			<td>제품명</td> <!--  -->
			<td>판매스토어</td> <!--  -->
			<td>주문수량</td> <!--  -->
			<td>총주문가격</td> <!--  -->
			<td>판매자</td> <!--  -->
			<td>구매자</td> <!--  -->
			<td>배송상태</td> <!--  -->
			<td>구매확정</td> <!--  -->
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${requestScope.orderList }"  var="order" >
			<tr>
				<td><input type="checkbox" name="items"  value="${order.ordersNo },${order.ordersStatus} , ${order.product.productName }" /></td>
				<td><img src="/HwangDangFleamarket/product_img/${order.product.productMainImage }" /></td>
				<td>${order.product.productName }</td>
				<td>${order.seller.sellerStoreName }</td>
				<td>${order.orderProduct.orderAmount}</td>
				<td>${order.ordersTotalPrice } </td> 
				<td>${order.seller.memberId }</td>
				<td>${order.memberId }</td>
				<td>
					<c:choose>
						<c:when test="${order.ordersStatus == 0 }">입금대기중</c:when>
						<c:when test="${order.ordersStatus == 1 }">결제완료</c:when>
						<c:when test="${order.ordersStatus == 2 }">배송준비중</c:when>
						<c:when test="${order.ordersStatus == 3 }">배송중</c:when>
						<c:when test="${order.ordersStatus == 4 }">배송완료</c:when>
					</c:choose> 
				 </td> 
				<td><c:if test="${order.ordersStatus == 4  or  order.ordersStatus == 3 }"><input type="button" value="구매확정" /></c:if></td>
		</tr>
		</c:forEach>
		
	</tbody>
</table>
</form>


<div id="btn_layter">
	<button id="btnRequestCancel">구매취소</button>
	<button id="btnRequestRefund">환불신청</button>
	<button id="btnRequestChange">교환신청</button>
</div>
