<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt"   uri="http://java.sun.com/jsp/jstl/fmt"  %> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<style>
#nav_layer{
	background-color: lightgray;
	/* margin: 1 */
	padding: 30px;
} 
table {
	border: 3px solid gray;
	padding: 20px;
	magin: 40px;  
  	
	
}
tr  {
	border: 1px solid black;
}
#order_info {
		min-width : 300px;
}

#nav_layer {
  width: 150px;
  min-height:  380px;
  float: left;
}
button {
	width : 70px;
	height : 40px;
}

img {
	width : 100px;
	height : 70px;
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
				console.log("split실행후:" +orderCancelList);
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
					//console.log("현재주문번호: " + $(this).val());
					//console.log($(this).parent().parent());
					
					var tr = $(this).parent().parent();
					var orderNo =  $(this).val();
					var orderStatus = $(tr).children().eq(3).text().trim();
					//alert(orderStatus);
					
					if(orderStatus == "입금대기중" ){
						orderStatus = 0;
					}if(orderStatus == "결제완료" ){
						orderStatus = 1;
					}if(orderStatus == "배송준비중" ){
						orderStatus = 2;
					}if(orderStatus == "배송중" ){
						orderStatus = 3;
					}if(orderStatus == "배송완료" ){
						orderStatus = 4;
					}
					//alert(orderStatus);  orderStatus 숫자로변경 
					
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
			var yesNO = confirm("정말취소하시겠습니까?");
			if(yesNO){
				checkboxValidation(0 , 1 , 2 ,  "상품 발송후에는 주문취소를 할수없습니다. " );
				url	="/HwangDangFleamarket/myorder/orderCancelList.go?orderCancelList="+orderCancelList+"&loginId="+loginId+"&status="+7;
				sendForm(url);
			}
			
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
		
		//구매확정 
		$("button").on("click",function(){
			var tr = $(this).parent().parent();
			var ordersNo =  $(tr).children().eq(0).children().val();
			//alert(ordersNo);
			url	="/HwangDangFleamarket/myorder/orderStatusChange.go?orderList="+ordersNo+"&loginId="+loginId+"&status="+10;
			//alert(url);
			$("form").prop("action" , url);
			$("form").submit();
		
			
		}); 
		$(".detail").on("click",function(){
			alert("디테일버튼" + this);
			console.log(this);
			
		}); 
		
		//seller세부정보
		$(".sellerDetail").on("click",function(){
			var sellerName = $(this).text(); 
			$.ajax({
				"url" : "/HwangDangFleamarket/myorder/SellerDetail.go" ,
				"type" : "POST"  ,
				"data"  : "sellerName="+sellerName +"&loginId="+loginId ,
				"datatype"  : "json"  ,
				"success" : function(obj){
					//console.log(obj);
					alert(
						"스토어명 :"+ obj.sellerStoreName  + 
						"스토어주소 :" + obj.sellerAddress + obj.sellerSubAddress +
						"주요상품 :"  + obj.sellerProduct1 + ", " + obj.sellerProduct2 +", " + obj.sellerProduct3 + 
						"스토어소개 :" + obj.sellerIntroduction
					)
					//window.oepn()
					return false;
				} ,
				"beforeSend" : function(){
					
				} , 
				
				"error" : function(xhr , status , httpErrorMsg){
					alert("실패 :" + httpErrorMsg);
				}
			});
			
		});
		
		
		 //주문세부정보
		$(".orderDetail").on("click",function(){
			/* var orderNo = $(this).text(); 
			$.ajax({
				"url" : "/HwangDangFleamarket/myorder/orderDetail.go" ,
				"type" : "POST"  ,
				"data"  : "orderNo="+orderNo +"&loginId="+loginId ,
				"datatype"  : "json"  ,
				"success" : function(obj){
					console.log(obj);
					//window.oepn()
				} ,
				
				"error" : function(xhr , status , httpErrorMsg){
					alert("실패 :" + httpErrorMsg);
				}
			}); */
		});
		
	
		
	}); //docudent
</script>



<!-- 배송현황 조회
배송완료 -  구매확정 : 10 
	배송현황 - 입금대기중 : 0 
	배송현황 - 결제완료 : 1
	배송현황 - 배송준비중 : 2
	배송현황 - 배송중 : 3
	배송현황  - 배송완료 : 4
	교환/환불/취소 -  교환신청 : 5
	교환/환불/취소 -  환불신청 :  6 
	교환/환불/취소 - 구매취소(배송전) :  7 
	교환/환불/취소 -   교환신청 승인 : 8 
	교환/환불/취소 -   환불신청 승인  : 9
 -->
    
orderSeqNo
<h2 class="page-header store_look_around">나의주문 - 배송현황</h2>
세션: ${sessionScope.login_info.memberId }

<div id="nav_layer">		
	<a href="/HwangDangFleamarket/myorder/main.go?loginId=${sessionScope.login_info.memberId }">배송 현황</a><br/><br/><br/><br/>
	<a href="/HwangDangFleamarket/myorder/success.go?loginId=${sessionScope.login_info.memberId }">배송 완료</a><br/><br/><br/><br/>
	<a href="/HwangDangFleamarket/myorder/cancel.go?loginId=${sessionScope.login_info.memberId }">교환/환불/취소</a>
</div>
<table>
	<thead>
		<tr>
			<td>체크박스</td> 
			<td>주문날짜 </td> 
			<td>상품정보</td> 
			<td>상태</td> 
			<td>구매확정</td> 
		<tr>
	</thead>
	


</table>	
<form action=""  method="post">
<input type="hidden" id="loginId" value="${sessionScope.login_info.memberId }" />

<c:forEach items="${requestScope.orderList }"  var="order" > 
	<tbody>
		<tr> 
			<table>
				<c:forEach items="${order.orderProductList }" var="orderProduct">
				
				<tr>
				<%--  체크박스   --%>
				<td><input type="checkbox" name="items" value="${order.ordersNo }"  /></td>
				
				<!-- 주문날짜 -->
				<td><a class="orderDetail"><fmt:formatDate value="${order.orders_date }" pattern="yyyy년 MM월 dd일" /></a></td>
					
				<!-- 주문정보 :  셀러 , 제품명 , 수량 , 주문번호  , 옵션보기버튼 ,메인옵션(추가가격) , 제품가격   -->
				<td id="order_info">
					<img src="/HwangDangFleamarket/product_img/${orderProduct.product.productMainImage }" />
					<a class="sellerDetail">${orderProduct.seller.sellerStoreName }</a>
					${orderProduct.product.productName } ${orderProduct.orderAmount}
					주문번호 :${order.ordersNo } 옵션 :${orderProduct.productOption.optionSubName }
					수량 :${orderProduct.productOption.optionStock }개 <font color="lightgray">(+${orderProduct.productOption.optionAddPrice})</font>
					상품가격 :<fmt:formatNumber value="${orderProduct.product.productPrice }" type="currency" />
				</td>
				
				<!-- 배송상태  -->
				<td>
					<c:choose>
						<c:when test="${orderProduct.orderProductStatus  == 0 }">입금대기중</c:when>
						<c:when test="${orderProduct.orderProductStatus  == 1 }">결제완료</c:when>
						<c:when test="${orderProduct.orderProductStatus  == 2 }">배송준비중</c:when>
						<c:when test="${orderProduct.orderProductStatus  == 3 }">배송중</c:when>
						<c:when test="${orderProduct.orderProductStatus ==  4 }">배송완료</c:when>
					</c:choose> 
				</td>
				 
				<%-- 구매확정 버튼 --%>
				<td value="${order.ordersNo }">
					<c:if test="${orderProduct.orderProductStatus  == 4 or orderProduct.orderProductStatus  == 3  }">
						<button>구매확정</button>
					</c:if>
				</td> 
			</tr>
		</c:forEach>
	</table>
</tr>
				
</c:forEach> 
	</tbody>
</table>

</form>
	<!-- ◀버튼처리 -->  
	<c:choose>
		<c:when test="${requestScope.pagingBean.previousPageGroup }">
			<a href="/HwangDangFleamarket/myorder/main.go?loginId=${sessionScope.login_info.memberId }&page=${requestScope.pagingBean.beginPage-1}">
			◀
			</a>
		</c:when>
		<c:otherwise>
		 	◁	  
		</c:otherwise>
	</c:choose>
		<!-- 페이징처리 -->  
		<c:forEach begin="${requestScope.pagingBean.beginPage }" end="${requestScope.pagingBean.endPage }" var="page">
			<c:choose>
				<c:when test="${requestScope.pagingBean.page == page }">
					[ ${page} ]
				</c:when>
				<c:otherwise>
					<a href="/HwangDangFleamarket/myorder/main.go?loginId=${sessionScope.login_info.memberId }&page=${page }">${page}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	
		<!-- ▶버튼 처리  -->
	<c:choose>
		<c:when test="${requestScope.pagingBean.nextPageGroup}">
				<a href="/HwangDangFleamarket/myorder/main.go?loginId=${sessionScope.login_info.memberId }&page=${requestScope.pagingBean.endPage +1 }">▶ </a>
		</c:when>
		<c:otherwise>
			▷	  
		</c:otherwise>
	</c:choose>

<div id="btn_layter">
	<input type="button" value="구매취소" id="btnRequestCancel"/>
	<input type="button" value="환불신청" id="btnRequestRefund"/>
	<input type="button" value="교환신청" id="btnRequestChange"/>
</div>
