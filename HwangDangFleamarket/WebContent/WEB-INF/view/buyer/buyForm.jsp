<%@ page contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
	div {
	 margin : 20px;
	 padding : 20px;
	}
	#left_lalyer{
		border :3px solid blue;
		float : left;
		min-width: 400px;
	}
	
	#right_layer{
		border :3px solid blue;
		float : left; 
		min-width: 180px;   
	}
</style>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>


	function addMileage(mileage){
		
		var originalMileage = $("#memberMileage").text().trim();
		
		var sum = 0;
		console.log(mileage);
		var value = $(mileage).html();
		parseInt(value);
		
		 var beforeTotal = $("#ordersTotalPrice").html().trim();
		parseInt(beforeTotal);
		totalTemp =  beforeTotal;
		
		sum =  beforeTotal - value;
		$("#ordersTotalPrice").html(sum); 
		$("#mileageCheckbox").prop("disabled" ,"disabled");
		
		originalMileage = originalMileage -value;
		$("#memberMileage").text(originalMileage);
		
	}  

	/*
	 멤버 마일리지 조회 
	*/
	function getMemberMileage(){
		
		$.ajax({
			  
			"url" : "/HwangDangFleamarket/buy/getMemberMileageAjax.go" ,
			"type" : "POST"  ,
			"data" : "memberId="+$("#hiddenMemberId").val().trim() ,
			"dataType" : "text" ,
			"beforeSend" : function(){
				//alert("TEST ID: "+$("#hiddenMemberId").val().trim());
			},
			"success" : function(returnMileage){
				//alert(returnMileage);
				$("#memberMileage").html(returnMileage);
			}, 
			
			"error"  : function(a ,status , httpErrorMsg){
				alert("마일리지조회 ajax 예외: " + status +httpErrorMsg);
			}
			
		});
	}
	
	
	$(document).ready(function(){
		
		//마일리지 ajax통신을 이용하여 조회
		getMemberMileage();
		   
		var total = 0;  
		//총 주문가격 조회  - productPrice   
		$(".partProductPrice").each(function(index){
			var oneProductPrice  = $(this).html().trim();
			var price = parseInt(oneProductPrice);
			total = total + price;
		});
		//계산한 결과를 반영
		$("#productPrice").html(total);
		$("#ordersTotalPrice").html(total);
		 
		
		
		// 주문자 정보를 임시로 저장할 변수들  
		var temp_ordersReceiver =$("#memberName").html().trim();
		var temp_ordersPhone =$("#memberPhone").html().trim();
		var temp_ordersZipcode =$("#memberZipcode").html().trim();
		var temp_ordersAddress =$("#memberAddress").html().trim();
		var temp_ordersSubAddress = $("#memberSubAddress").html().trim();
		var temp_currentAddress = "";
		
		var ordersTotalPriceTemp  = 0;
		var memberMileageTemp  = 0;
		var productPriceTemp =0;
		
		//배송옵션 선택시 자동입력
		$("#requestOption").on("change", function(){
			//alert(this.value); 
			$("#requestInfo").val(this.value);
			
		});
		
		//새로운배송지 입력태그들 show 
		$("#newAddress").on("click" , function(){
			$("#originalAddress").hide();
			$("#hiddenAddress").show();
			
		});
		//새로운배송지 입력태그들 hide 
		$("#diliverAddress").on("click" , function(){
			$("#originalAddress").show();
			$("#hiddenAddress").hide();
			
		});
		
		//주소지입력 버튼 클릭 
		$("#findAddress").on("click",function(){
			var specs = "left=100,top=100,width=600,height=500";
			  specs += ",toolbar=no,menubar=no,status=no,scrollbars=no,resizable=no";
			window.open("/HwangDangFleamarket/popup.jsp","addressForm" ,specs);
		});
	
		//결제버튼 클릭
		$("#submitBtn").on("click",function(){
			
			//0. 파라미터 
			var ordersReceiver = "";
			var ordersZipcode = "";
			var ordersAddress = "";
			var ordersSubAddress = "";
			var ordersPhone ="";

			//1.새로운 배송지 선택시 검증 로직 
			if( $("#newAddress").is(":checked") ){
				
				ordersReceiver = $("#name").val();
				var phone1 = $("#phone1").val().trim();
				var phone2 = $("input[name=phone2]").val().trim();
				var phone3 = $("#phone3").val().trim();
				
				 ordersZipcode = $("#zipcode").val().trim();
				 ordersAddress = $("#address1").val().trim();
				 ordersSubAddress = $("input[name=address2]").val().trim();
				//alert(name+phone1+phone2+phone3+zipcode+address1+address2);
				
				if(ordersReceiver.length == 0){
					alert("받는분을 입력해주세요.");
					return false;
				}if(phone2.length == 0 ||  phone2.length > 4 ){
					alert("연락처를 정확히 입력해주세요.");
					return false;
				}if(phone3.length == 0 || phone3.length > 4 ){
					alert("연락처를 정확히 입력해주세요.");
					return false;
				}if(ordersZipcode.length == 0){
					alert("주소찾기 버튼을 눌러 주소를 입력해주세요.");
					return false;
				}if(ordersAddress.length == 0){
					alert("주소찾기 버튼을 눌러 주소를 입력해주세요.");
					return false;
				}if(ordersSubAddress.length == 0){
					alert("주소찾기 버튼을 눌러 주소를 입력해주세요.");
					return false;
				}
				ordersPhone = ordersPhone+phone1+"-"+phone2+"-"+phone3;
				
			}else{
				//기존주소로 구매하였다면 히든요소 삭제 
				$("#newAddress").empty();
				 ordersReceiver = $("#memberName").html().trim();
				 ordersPhone = $("#memberPhone").html().trim();
				 ordersZipcode = $("#memberZipcode").html().trim();
				 ordersAddress = $("#memberAddress").html().trim();
				 ordersSubAddress = $("#memberSubAddress").html().trim();
				 
			}
			
			
			var ordersTotalPrice = $("#ordersTotalPrice").html().trim();
			//결제방식 0:현금결제 ,1 카드결제등등 		
			var ordersPayment = $(":radio[name=payment]:checked").val().trim();
			//주문요청사항
			var ordersRequest = $("#requestInfo").val().trim();
			//결제상태 결제완료 :1 /결제대기중 :0 .. 
			var paymentStatus = 1;
			/* var ordersDate = new Date().format("yyyy-MM-dd"); */
			var memberId = $("#hiddenMemberId").val().trim();
			
			var ordersPayment = $(":radio[name=payment]:checked").val().trim();
			var orderProductStatus = 0;
			if(ordersPayment == 0){
				orderProductStatus = 0; //미결재 
			}else if (ordersPayment == 1 || ordersPayment == 2 || ordersPayment == 3 ) {
				orderProductStatus =1;  //결제완료 
			}
			
			
			 var queryString = "";
			   
			 if($("#oneOrN").html().trim() =='1'){
				 	//한개구매
				 	 queryString = "?&ordersReceiver="+ordersReceiver+"&ordersPhone="+ordersPhone+"&ordersZipcode="
					 +ordersZipcode+"&ordersAddress="+ordersAddress+"&ordersSubAddress="+ordersSubAddress
					 +"&ordersTotalPrice="+ordersTotalPrice+"&ordersPayment="+ordersPayment
					 +"&ordersRequest="+ordersRequest+"&paymentStatus="+paymentStatus+"&memberId="+memberId+
					 "&orderAmount=${param.amount }&productId=${param.productId  }&sellerStoreNo=${param.sellerStoreNo }&orderProductStatus="
					 +orderProductStatus+"&optionId="+$("#optionId").val().trim() +"&usedMileage="+$("#useMileage").html();	
					$("form").prop("action", "/HwangDangFleamarket/buy/buyProductOne.go"+queryString);
		
			 }else{
				 	//N개구매
				 	
				 	//optionId sellerStoreNo  productId amount
				 	var optionIdList = "";
				 	var sellerStoreNoList ="";
				 	var productIdList = "";
				 	var amountList = "";
				 	
				 	$(".optionId").each( function(index){
				 		optionIdList = optionIdList + this.value + ",";
				 	});
				 	
				 	$(".sellerStoreNo").each( function(index){
				 		sellerStoreNoList = sellerStoreNoList + this.value + ",";
				 	});
				 	
					$(".productId").each( function(index){
						productIdList = productIdList + this.value + ",";
				 	});
					
					$(".amount").each( function(index){
						amountList = amountList + $(this).html().trim() + ",";
				 	});
				 	
					//alert("optoinIdList:"+optionIdList+" , sellerStoreNoList :" + sellerStoreNoList +", productIdList: "+ productIdList + ",amountList "+amountList);
				 	 
				 	  queryString = "?ordersNo=${requestScope.ordersNo}&ordersReceiver="+ordersReceiver+"&ordersPhone="+ordersPhone+"&ordersZipcode="
					 +ordersZipcode+"&ordersAddress="+ordersAddress+"&ordersSubAddress="+ordersSubAddress
					 +"&ordersTotalPrice="+ordersTotalPrice+"&ordersPayment="+ordersPayment
					 +"&ordersRequest="+ordersRequest+"&paymentStatus="+paymentStatus+"&memberId="+memberId+
					 "&amountList="+ amountList + "&productIdList=" +productIdList+ "&sellerStoreNoList="+sellerStoreNoList +"&orderProductStatus="+orderProductStatus+
					 "&optionIdList="+optionIdList  +"&usedMileage="+$("#useMileage").html().trim()+"&cartNoList=${requestScope.cartNoList }";	
					$("form").prop("action", "/HwangDangFleamarket/buy/buyProducts.go"+queryString);
			 }
			
			// alert(queryString);
			$("form").submit(); 
			//return false;
			
		}); //결제버튼
		
		
		//ajax : 최근배송지 조회하기
		$("#currentDeliveryAddress").on("click" ,function(){
			//alert($("#hiddenMemberId").val());
			$.ajax({
				"url" : "/HwangDangFleamarket/buy/currentDeliveryAddress.go" ,
				"type" : "POST"  ,
				"data" : "memberId="+$("#hiddenMemberId").val().trim() ,
				"dataType" : "json" ,
				"beforeSend" : function(){
					//alert("TEST ID: "+$("#hiddenMemberId").val().trim());
				},
				"success" : function(orders){
					
					//alert(orders.ordersPhone);
					
					temp_ordersReceiver = $("#memberName").html().trim();
					$("#memberName").html(orders.ordersReceiver);
					
					temp_currentAddress = $("#memberAddress").html().trim();
					$("#memberAddress").html(orders.currentAddress);
					
					temp_ordersPhone = $("#memberPhone").html().trim();
					$("#memberPhone").html(orders.ordersPhone);
					
					temp_ordersSubAddress = $("#memberSubAddress").html().trim();
					$("#memberSubAddress").html(orders.ordersSubAddress);
					
					temp_ordersZipcode = $("#memberZipcode").html().trim();
					$("#memberZipcode").html(orders.ordersZipcode);
					
				   	 
				} ,
				"error" : function( a , status, HttpErrorMsg ){
					alert("ajax:통신실패:" + status + HttpErrorMsg);
					//console.log("ajax:통신실패:" + status + HttpErrorMsg);
				}
				
			});
			
		});
		
		//배송지선택 -원상복귀 - memberTB의 주소정보로 변경 
		$("#diliverAddress").on("click" ,function(){
			
			$("#memberName").html(temp_ordersReceiver);
			$("#memberAddress").html(temp_ordersAddress);
			$("#memberPhone").html(temp_ordersPhone);
			$("#memberSubAddress").html(temp_ordersSubAddress);
			$("#memberZipcode").html(temp_ordersZipcode);
			
		});
		//마일리지 모두 사용!
		$("#mileageCheckbox").on("click",function(){
			if( $("#mileageCheckbox").is(":checked") ){
				
				//	productPrice -  useMileage = ordersTotalPrice
				
				var memberMileage = $("#memberMileage").text().trim();
				var productPrice = $("#productPrice").html().trim();
				 
				productPrice = parseInt(productPrice);
				memberMileage = parseInt(memberMileage);
				
				//화면 사용할 마일리지에 적용  
				$("#useMileage").text(memberMileage);
				
			
				//체크해제를 대비하여 temp변수들에 임시 저장 
				
				  
				productPriceTemp =   productPrice;
				memberMileageTemp  = memberMileage;
				//ordersTotalPriceTemp  = ordersTotalPrice;
				
				var sum  =  productPrice - memberMileage;
				
				$("#ordersTotalPrice").html(sum);
				$("#useMileageBtn").prop("disabled","disabled");
				
				//기존마일리값을 0으로 변경 
				$("#memberMileage").text(0);
			
			}else{ 
				//체크해재되면 마일리지 지움 
				$("#useMileage").text("");
				$("#ordersTotalPrice").html(productPriceTemp);
				$("#useMileageBtn").prop("disabled",false);
				//기존마일리지값을 원복   -temp 이용
				$("#memberMileage").text(memberMileageTemp); 
			}
			
		});
		  
		
		//사용할 마일리지포인트 보이게하기!
		$("#useMileageBtn").click(function(){
			$("#spanMileage").show();
		});	
		
		
		//사용할 마일리지포인트 적용하기 !
		$("#mileageUseBtn").click(function(){
			var choiceMileage = $("#choiceMileage").val();
			if(choiceMileage.length == 0 ){
				alert("사용할 마일리지값을 입력하세요.");
				return false;
			}
			choiceMileage = parseInt(choiceMileage);
			
			//검증
			var cutline = $("#memberMileage").text().trim();
			cutline = parseInt(cutline);
			
			if(cutline <  choiceMileage){
				alert("현재보유마일리지는 "+cutline +"점 입니다. 보유마일리지만큼 사용가능합니다.");
				return false;
			}else if(choiceMileage <= 0) {
				alert("사용할마일리지는 1이상되어야 합니다.");
			}else {
				//마일리지 적용 로직 
				
				//1. 마일리지 폼에 적용 
				$("#useMileage").html(choiceMileage);
				
				//2. temp 에 보관
				memberMileageTemp = cutline;
				
				//3.사용가능포인트 마이너스 
				cutline = cutline - choiceMileage;
				$("#choiceMileage").val(0);
				$("#memberMileage").text(cutline);
				
				/* productPriceTemp =   productPrice;
				memberMileageTemp  = memberMileage; */
			}
			
		});
		
		//마일리지 적용취소 
	$("#mileageCancelBtn").click(function(){
		$("#memberMileage").text(memberMileageTemp)
	});
		
		
		$("#testBtn").click(function(){
			
			
		});		
		
		
	}); //ready
	
</script>

<h2>구매페이지</h2>
<%-- 세션스코프 멤버정보 : ${sessionScope.login_info.memberAddress }
page : ${param.page  }
구매자아이디 : ${param.memberId } 
product_id : ${param.productId  }
seller_store_no : ${param.sellerStoreNo  }
구매수량 : ${param.amount }
옵션명 : ${param.option } 
옵션ID: ${requestScope.productOption.optionId }
총추가가격 : ${requestScope.productOption.optionAddPrice * param.amount  }
orderProductList : ${requestScope.orderProductList }
카트리스트 ArrayList객체 ${requestScope.cartList }

-------------------------------------------------------<br/>
 --%>


<form action="" method="POST" name="buy_form" >

	<input type="hidden" value="${sessionScope.login_info.memberId }" id="hiddenMemberId"	/>
	<div id="left_lalyer">
		<div id="address_div">
			<h4>배송지 선택</h4>
			<hr>
			<input type="radio" name="diliverAddress" id="diliverAddress"  checked="checked">${sessionScope.login_info.memberName}   
			<input type="radio" name="diliverAddress" id="currentDeliveryAddress">최근배송지
			 <input type="radio" name="diliverAddress" id="newAddress">새로운배송지
			-----------------------------<br/><br/>
			<span id="originalAddress">
				<span id="memberName">${sessionScope.login_info.memberName}</span> <span id="memberPhone">${sessionScope.login_info.memberPhone}</span> <br/>
				<span id="memberAddress">${sessionScope.login_info.memberAddress}</span> <span id="memberSubAddress">${sessionScope.login_info.memberSubAddress}</span><br/>
				<font size="1.5em">우편번호 : [<span id="memberZipcode">${sessionScope.login_info.memberZipcode}</span>]</font><br/>
		  		<input type="button" id="setBtn" value="수정" /><br/>
		  	</span>
		  	
		  	<span id="hiddenAddress" hidden="true">
			받는분 <input type="text" name="name" id="name"/><br/>
			휴대전화 
			<select name="phone1" id="phone1">
				<option>010</option>
				<option>011</option>
				<option>017</option>
				<option>018</option>
				<option>019</option>
			</select>
			-<input type="text" name="phone2" id="phone2" /> -
			 <input type="text" name="phone3" id="phone3" /><br/>
			
			주소 
				<input type="button" value="주소찾기"  id="findAddress" />
				<input type="text" name="zipcode" id="zipcode" disabled="disabled" size="10" /><br/>
				<input type="text" name="address1" id="address1" disabled="disabled"  size="45" /><br/>
				<input type="text" name="address2"  size="45" />
			 </span><br/>
		  	
		  	<select name="requestOption" id="requestOption">
				<option>배송시 요청사항을 선택해주세요.</option>
				<option>배송전, 연락바랍니다.</option>
				<option>부재시, 경비실에 맡겨주세요.</option>
				<option>부재시, 전화또는 문자 연락주세요.</option>
			</select><br/>
		  	배송요청정보 : <input type="text" name="requestInfo" id="requestInfo" size="40" >
		  	<hr>
		  	
		  	<hr>
		  	<h4>할인 및 포인트 선택</h4>
		  	사용가능 포인트 :<span id="memberMileage"></span>점<br/>
		  	모두사용하기 <input type="checkbox" id="mileageCheckbox" /><input type="button" value="마일리지 금액 선택" id="useMileageBtn" /><br/>
		  	<span hidden="true" id="spanMileage">사용할 마일리지 입력 : 
		  	<input type="number" name="choiceMileage" id="choiceMileage"   size="10" />
		  		<input type="button" value="사용하기"  id="mileageUseBtn" /><input type="button" value="사용취소" id="mileageCancelBtn"/>
		  	</span><br/>
		  	 
			<hr>
			 
			<hr>
			<h4>결제수단 선택</h4>
			<input type="radio" name="payment" value="0">무통장입금
			<input type="radio" name="payment" value="1" checked="checked">카드결제
			<input type="radio" name="payment" value="2">자동이체
			<input type="radio" name="payment" value="3">간편결제
			<hr>
		</div>
	
	</div>
	<div id="right_layer">
		<hr>
		<h4>주문상품 정보</h4>
		<c:forEach  items="${requestScope.orderProductList }" var="op">
			<input type="hidden" id="optionId"  class="optionId" value="${op.productOption.optionId }"/>
			<input type="hidden"  class="sellerStoreNo" value="${op.sellerStoreNo }"/>
			<input type="hidden"   class="productId" value="${op.product.productId }"/>
			스토어명 : <span id="sellerStoreName" >${op.seller.sellerStoreName }</span><br/>
			제품명 : <span id="productName">${op.product.productName  }</span><br/>
			옵션명 : <span id="option">${op.productOption.optionSubName }</span><br/>
			가격/구매수랑 : 
			<span id="productPricePer"><fmt:formatNumber type="currency">${op.product.productPrice }</fmt:formatNumber></span>원 
			/<span id="amount" class="amount">${op.orderAmount  }</span>개<br/>
			상품당 추가가격 : 
			<span>
				<fmt:formatNumber type="currency">${op.productOption.optionAddPrice } </fmt:formatNumber>
			</span>원<br/>
			배송비 : 
			<span id="deriveryCharge">
			<c:choose>
				<c:when test="${ (op.product.productPrice  + op.productOption.optionAddPrice  )  * op.orderAmount  >= 50000 }">0</c:when>
				<c:otherwise>2500</c:otherwise>
			</c:choose>
			</span>원<br/>   
			
			상품가격 : <font color="blue" class="partProductPrice" > 
			<c:choose>
				<c:when test="${ (op.product.productPrice  + op.productOption.optionAddPrice )  * op.orderAmount  >= 50000 }">${(op.product.productPrice+op.productOption.optionAddPrice)*op.orderAmount }</c:when>
				<c:otherwise>${(op.product.productPrice+op.productOption.optionAddPrice)*op.orderAmount + 2500 }  </c:otherwise>
			</c:choose>
			</font>
			<hr>
		</c:forEach>		
			총상품갯수 : <span id="oneOrN">${fn:length(requestScope.orderProductList) } </span>개<br/>
		
			
			
		<hr>
		<h4>최종결제 정보</h4>
		
			결제예정금액 : <span id="productPrice"></span>원<br/>
			사용할 마일리지 :<span id="useMileage" ></span><br/>
			<hr>
			 실제결제금액:<font size="15" color="red" ><span id="ordersTotalPrice"></span></font>원<br/>
			
			<input type="button" value="결제하기" id="submitBtn" />
			<input type="button" value="test" id="testBtn" />
		<hr>
		
	</div>
	
	
</form>

