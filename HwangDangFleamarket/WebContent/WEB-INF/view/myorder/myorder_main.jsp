<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style> 

td {
	align :center;
}

img {
	width : 100px;
	height : 70px;
}

.container{
	min-height:  300px;
	min-width:  500px;
}   

#orderSeqNo{
	display: none;
}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	
var flag = false;
var orderCancelList = "";
var url = "";
var loginId = $("#loginId").val();

//폼전송 함수 
function sendForm(url){
	if(flag){ 
		flag = false;
		orderCancelList = orderCancelList.substring( 0 , orderCancelList.length-1);
		$("#f2").prop("action" , url);
		$("#f2").submit();
	}
}  
//체크박스검증 및 orderList 검증  함수 
function checkboxValidation(num1 , num2 , num3 , msg){
	if( !$("input:checkbox").is(":checked") ){  //true,false
		alert("체크박스를선택해주세요.");
	}else{
		// 체크박스선택하였고 주문취소가 가능한 상태인지 검증 
		orderCancelList = "";
		$("input:checkbox:checked").each(function(){
			var ordersSeqNo = $(this).val()
			if(ordersSeqNo != 'on'){
				var tr = $(this).parent().parent();
				var orderStatusText =$(tr).children().eq(3).text().trim();
				var orderStatus =  0;
				if(orderStatusText == "입금대기중" ){
					orderStatus = 0;
				}if(orderStatusText == "결제완료" ){
					orderStatus = 1;
				}if(orderStatusText == "배송준비중" ){
					orderStatus = 2;
				}if(orderStatusText == "배송중" ){
					orderStatus = 3;
				}if(orderStatusText == "배송완료" ){
					orderStatus = 4;
				}
				if(orderStatus == num1 || orderStatus ==num2 || orderStatus ==num3 ){
					//취소할 주문번호 배열에 누적 
					orderCancelList = orderCancelList + ordersSeqNo +","
					flag = true;
				}else{
					alert(msg);
				}
			}
		
		}); //orderList 누적 for문
	} //else 
		
}
//제목의 체크박스 선택하면 현재주문 모두 체크하기
function allCheck(evt){
	var targetNameProp = $(evt).prop("name");
	var flag = $("."+targetNameProp).prop("checked");
		if(flag){
		//true 즉 체크되어있으면 현재그룹의 체크받스들도 모두 체크시킴!
		 $("."+targetNameProp).prop("checked" ,"checked");	
	 }else{
		 $("."+targetNameProp).prop("checked" , false);	
	} 
			
}
	  
$(document).ready(function(){
	// 주문취소버튼 클릭시 이벤트핸들러 
	$("#btnRequestCancel").on("click",function(){
		var yesNO = confirm("정말취소하시겠습니까?");
		if(yesNO){
			url = "";
			var page =  $("#currentPage").text().trim();
			checkboxValidation(0 , 1 , 2 ,  "상품 발송후에는 주문취소를 할수없습니다.");
			url	="/HwangDangFleamarket/myorder/orderCancelList.go?orderCancelList="
					+orderCancelList+"&loginId=${sessionScope.login_info.memberId }&status="+7;
			sendForm(url);
		}
	}); //btn 
		
	// 환불신청 
	$("#btnRequestRefund").on("click",function(){
		if($(":checkbox:checked").length == 0){
			alert("환불할 상품을 1개 선택해 주세요.")
			return false;
		}
		if($(":checkbox:checked").length != 1){
			alert("한번에 하나의 상품만 환불 가능합니다.");
			$(":checkbox:checked").removeAttr("checked");
			return false;
		}
		else{
			window.open('/HwangDangFleamarket/myorder/refundForm.go?orderSeqNo='+$(":checkbox:checked").val(), '환불신청', 'resizable=no scrollbars=yes width=463 height=648 left=500 top=200')
		}	
	});
		
	// 교환신청 버튼 이벤트핸들러 
	$("#btnRequestChange").on("click",function(){
		var yesNO = confirm("정말 교환 신청을 하시겠습니까?");
		if(yesNO){
			//1.교환신청시 검증 수행 
				checkboxValidation(4,4,4, "배송완료상품만 교환을 신청할수 있습니다.");
			//2. 검증통과 되었을 경우에만 폼오픈!
			if(flag){
				falg = false;
				orderCancelList = orderCancelList.substring( 0 , orderCancelList.length-1);
				var option ='resizable=no scrollbars=yes width=513 height=660 left=500 top=200';
				window.open("/HwangDangFleamarket/myorder/exchangeRequestFormMove.go?orderSeqNo="
															+orderCancelList, "교환신청", option);
			}
		}
	});//교환신청
		
		//구매확정 
		$("button").on("click",function(){
			var yes_no = confirm("정말 구매확정하시겠습니다. 구매확정하시면 되돌릴수 없습니다.");
			if(yes_no){
				var orderSeqNo = this.value;
				var page =  $("#currentPage").text().trim();
				url	="/HwangDangFleamarket/myorder/orderStatusChange.go?orderSeqNo="+orderSeqNo
						+"&loginId="+loginId+"&status="+10+"&page="+page;  
				$("#f2").prop("action" , url);
				$("#f2").submit();
			}else{
				alert("취소하셨습니다.");
				return false;
			}
		}); //구매확정
		
		$(".detail").on("click",function(){
			alert("디테일버튼" + this);
			console.log(this);
		}); 
	}); //docudent  
</script>

<!-- 배송현황 조회
	배송현황 - 입금대기중 : 0 
	배송현황 - 결제완료 : 1
	배송현황 - 배송준비중 : 2
	배송현황 - 배송중 : 3
	배송현황  - 배송완료 : 4
 -->
 
<div class="container">
	<!-- <h2 class="page-header store_look_around">나의주문 - 배송현황</h2> -->
	<div class="row">
	<!-- 네비게이션 바Area -->
	 <ul class="nav nav-tabs">       
	 	 <li role="presentation" class="active"><a class="btn btn-default" role="button"  href="/HwangDangFleamarket/myorder/main.go?loginId=${sessionScope.login_info.memberId }">배송 현황</a></li>
	  	<li role="presentation"><a class="btn btn-default" role="button" href="/HwangDangFleamarket/myorder/success.go?loginId=${sessionScope.login_info.memberId }">구매 확정</a></li>
	  	<li role="presentation">	<a class="btn btn-default" role="button" href="/HwangDangFleamarket/myorder/cancel.go?loginId=${sessionScope.login_info.memberId }">교환/환불/취소</a></li>
	</ul>
	
	<div class="col-md-12">
	<form action=""  method="post"  id="f2">
	<input type="hidden" id="loginId" value="${sessionScope.login_info.memberId }" />
	<br/>
	
	<% int cnt = 0; %>
	<c:forEach items="${requestScope.orderList }"  var="order" > 
	<div class="parent">
	
	<!-- 전체체크박스 , 주문날짜 , 주문번호  -->              
	<h4>&nbsp;<input type="checkbox" name='items<%=cnt%>' class='items<%=cnt %>' onclick="allCheck(this);" /> 
	<fmt:formatDate value="${order.orders_date }" pattern="yyyy-MM-dd" /> / 주문번호 : ${order.ordersNo }</h4>
		<c:forEach items="${order.orderProductList }" var="orderProduct">		
			<table class="table">
			<tbody>
				<tr>
					<td>
						<!--  체크박스   -->
						<input type="checkbox" name="items<%=cnt %>"  class="items<%=cnt %>" value="${orderProduct.orderSeqNo}" />
						<a href="/HwangDangFleamarket/product/detail.go?page=1&productId=${orderProduct.product.productId}&sellerStoreNo=${orderProduct.seller.sellerStoreNo }&sellerStoreImage=${orderProduct.seller.sellerStoreImage }">
							<img class="main-image" src="/HwangDangFleamarket/image_storage/${orderProduct.product.productMainImage }" />
						</a>
					</td>
						
					<td>  
						<a href="/HwangDangFleamarket/product/detail.go?page=1&productId=${orderProduct.product.productId}&sellerStoreNo=${orderProduct.seller.sellerStoreNo }&sellerStoreImage=${orderProduct.seller.sellerStoreImage }">
							상품명(옵션)/수량 : ${orderProduct.product.productName}(${orderProduct.productOption.optionSubName})/
							${orderProduct.orderAmount}개 <br/>
							결제예정금액/배송비 : <fmt:formatNumber value="${(orderProduct.product.productPrice +orderProduct.productOption.optionAddPrice) * orderProduct.orderAmount  }" pattern="#,###원"/> /
							<fmt:formatNumber pattern="#,###">${orderProduct.fare}</fmt:formatNumber>원
						</a>
					</td>
					
					<td>
						<a href="/HwangDangFleamarket/seller/sellerStore.go?sellerStoreNo=${orderProduct.seller.sellerStoreNo }&sellerImage=${orderProduct.seller.sellerStoreImage }">
							${orderProduct.seller.sellerStoreName }  
						</a>	 
					</td>
					
					<td>
						<!-- 배송상태  -->
						<strong class="ordersStatus">  
						<c:choose>
							<c:when test="${orderProduct.orderProductStatus  == 0 }">입금대기중</c:when>
							<c:when test="${orderProduct.orderProductStatus  == 1 }">결제완료</c:when>
							<c:when test="${orderProduct.orderProductStatus  == 2 }">배송준비중</c:when>
							<c:when test="${orderProduct.orderProductStatus  == 3 }">배송중</c:when>
							<c:when test="${orderProduct.orderProductStatus ==  4 }">배송완료</c:when>
						</c:choose> 
						</strong>  
					</td>
				  
					<td>      
					<!-- 구매확정 버튼 --> 
						<c:choose>
							<c:when test="${orderProduct.orderProductStatus  == 4 }">
								<button class="btn btn-success"  value="${orderProduct.orderSeqNo}"  >구매확정</button>
							</c:when>
							<c:otherwise>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
							</c:otherwise>
						</c:choose>     
					</td>
				</tr>  
				</tbody>
			</table>
	</c:forEach> 
		<% cnt++; %>
		<p class="text-center">
			
			<strong><mark>
				사용한 마일리지 : ${order.usedMileage }<br/>  
				결제금액 : <fmt:formatNumber value="${order.ordersTotalPrice }" pattern="#,###" />
			</mark></strong><br/>  
		</p>
		<!-- <hr> -->
</div>     
</c:forEach>
</form>
<br/>


<!-- ***************페이징처리************************************** -->
	
	<!-- 페이징 ◀버튼 처리 -->  
	<p class="text-center">
	<c:choose>
		<c:when test="${requestScope.pagingBean.previousPageGroup }">
			<a href="/HwangDangFleamarket/myorder/main.go?loginId=${sessionScope.login_info.memberId }
																&page=${requestScope.pagingBean.beginPage-1}">
				◀
			</a>
		</c:when>
		<c:otherwise>◁</c:otherwise>
		
		
	</c:choose>
		<!-- 페이지 번호 처리 -->  
		<c:forEach begin="${requestScope.pagingBean.beginPage }" end="${requestScope.pagingBean.endPage }" var="page">
			<c:choose>
				<c:when test="${requestScope.pagingBean.page == page }">
					<span id="currentPage">${page}</span>
				</c:when>
				<c:otherwise>
					<a href="/HwangDangFleamarket/myorder/main.go?loginId=${sessionScope.login_info.memberId }&page=${page }">${page}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	
	<!-- 페이징 ▶버튼 처리  -->
	<c:choose>
		<c:when test="${requestScope.pagingBean.nextPageGroup}">
			<a href="/HwangDangFleamarket/myorder/main.go?loginId=${sessionScope.login_info.memberId }&page=${requestScope.pagingBean.endPage +1 }">▶ </a>
		</c:when>
		<c:otherwise>▷</c:otherwise>
	</c:choose>
	<br/><br/> 
	
	<!-- 버튼 -->
	<input type="button" value="주문취소" id="btnRequestCancel" class="btn btn-default"/>
	<input type="button" value="환불신청" id="btnRequestRefund" class="btn btn-default"/>
	<input type="button" value="교환신청" id="btnRequestChange" class="btn btn-default"/>
	</p>
  </div>
</div>

 </div> <!-- container -->
