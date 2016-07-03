<%@ page contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
	$(document).ready(function(){
		
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
			var specs = "left=10,top=10,width=372,height=466";
			  specs += ",toolbar=no,menubar=no,status=no,scrollbars=no,resizable=no";
			window.open("/HwangDangFleamarket/popup.jsp","addressForm" ,specs);
		});
		
		
		//요일변환을 위한 로직 
		String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
		String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
		Number.prototype.zf = function(len){return this.toString().zf(len);};
		Date.prototype.format = function(f) {
		    if (!this.valueOf()) return " ";
		 
		    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
		    var d = this;
		     
		    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
		        switch ($1) {
		            case "yyyy": return d.getFullYear();
		            case "yy": return (d.getFullYear() % 1000).zf(2);
		            case "MM": return (d.getMonth() + 1).zf(2);
		            case "dd": return d.getDate().zf(2);
		            case "E": return weekName[d.getDay()];
		            case "HH": return d.getHours().zf(2);
		            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
		            case "mm": return d.getMinutes().zf(2);
		            case "ss": return d.getSeconds().zf(2);
		            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
		            default: return $1;
		        }
		    });
		};
		 
		
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
			var ordersNo = "" + new Date().format("MMdd");
			
			var ordersPayment = $(":radio[name=payment]:checked").val().trim();
			var orderProductStatus = 0;
			if(ordersPayment == 0){
				orderProductStatus = 0; //미결재 
			}else if (ordersPayment == 1 || ordersPayment == 2 || ordersPayment == 3 ) {
				orderProductStatus =1;  //결제완료 
			}
			
			
			 var queryString = "?ordersNo="+ordersNo+"&ordersReceiver="+ordersReceiver+"&ordersPhone="+ordersPhone+"&ordersZipcode="
					 +ordersZipcode+"&ordersAddress="+ordersAddress+"&ordersSubAddress="+ordersSubAddress
					 +"&ordersTotalPrice="+ordersTotalPrice+"&ordersPayment="+ordersPayment
					 +"&ordersRequest="+ordersRequest+"&paymentStatus="+paymentStatus+"&memberId="+memberId+
					 "&orderAmount=${param.amount }&productId=${param.productId  }&sellerStoreNo=${param.sellerStoreNo }&orderProductStatus="
					 +orderProductStatus+"&optionId= ${requestScope.productOption.optionId }";	
					 
			 alert(queryString);				
			$("form").prop("action", "/HwangDangFleamarket/buy/buyProductOne.go"+queryString);
			$("form").submit(); 
			//return false;
			
		}); //결제버튼
		
		//마일리지사용버튼을 누르면 최종결제 정보에 show/hide
		$("#mileageCheckbox").on("click",function(){
			if( $("#mileageCheckbox").is(":checked") ){
				var mileage = $("#memberMileage").text().trim();
				$("#useMileage").text(mileage+"점");
			}else{ 
				//체크해재되면 마일리지 지움 
				$("#useMileage").text("");
			}
			
		});
		
		//ajax : 최근배송지 조회하기
		$("#currentDeliveryAddress").on("click" ,function(){
			
			$.ajax({
				"url" : "/HwangDangFleamarket/buy/currentDeliveryAddress.go" ,
				"type" : "POST"  ,
				"data" : "memberId="+$("#hiddenMemberId").val().trim() ,
				"dataType" : "json" ,
				"beforeSend" : function(){
					//alert("TEST ID: "+$("#hiddenMemberId").val().trim());
				},
				"success" : function(obj){
					
					alert(obj);
					append("<span id='currentAddress'>" +obj.ordersReceiver
					
					"</span>");
					
				} ,
				"error" : function( a , status, HttpErrorMsg ){
					alert("ajax:통신실패:" + status + HttpErrorMsg);
				}
				
			});
			
		});
		
		
		
		$("#testBtn").click(function(){
			
			
		});		
		
		
	}); //ready
	
</script>

<h2>구매페이지</h2>
세션스코프 멤버정보 : ${sessionScope.login_info.memberAddress }
page : ${param.page  }
구매자아이디 : ${param.memberId } 
product_id : ${param.productId  }
seller_store_no : ${param.sellerStoreNo  }
구매수량 : ${param.amount }
옵션명 : ${param.option } 
옵션ID: ${requestScope.productOption.optionId }


<form action="" method="POST" >
	<input type="hidden" value="${param.memberId }" id="hiddenMemberId"	/>
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
				<input type="number" name="zipcode" id="zipcode" disabled="disabled" size="10" /><br/>
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
		  	<input type="checkbox" id="mileageCheckbox" />보유 마일리지 사용 :<span id="memberMileage">${sessionScope.login_info.memberMileage }</span> <br/>
		  	
			<hr>
			
			<hr>
			<h4>결제수단 선택</h4>
			<input type="radio" name="payment" value="0">무통장현금
			<input type="radio" name="payment" value="1" checked="checked">카드
			<input type="radio" name="payment" value="2">자동이체
			<input type="radio" name="payment" value="3">간편결제
			<hr>
		</div>
	
	</div>
	<div id="right_layer">
		<hr>
		<h4>주문상품 정보</h4>
			스토어명 : <span id="sellerStoreName">${requestScope.sellerStoreName }</span><br/>
			제품이름(제품정보) : <span id="productName">${requestScope.product.productName  }</span><br/>
			옵션명 : <span id="option">${param.option }</span><br/>
			가격/구매수랑 : 
			<span id="productPrice"><fmt:formatNumber type="currency">${requestScope.product.productPrice }</fmt:formatNumber></span>원 /<span id="amount">${param.amount }</span>개<br/>
			
			총주문건 :<br/>
		<hr>
			
			
		<hr>
		<h4>최종결제 정보</h4>
			
			<%-- test2(true/false) : ${(requestScope.product.productPrice*param.amount) ge 50000 },
			<c:choose>
				<c:when test="${(requestScope.product.productPrice*param.amount) ge 50000 } ">
					true이므로 무조건 실행 
				</c:when>
				<c:otherwise>
					false이므로 무조건 비실행(왜flase가되지?)
				</c:otherwise>
			</c:choose> --%>
			
			주문가격 :<span id="productPrice"><fmt:formatNumber type="currency">${requestScope.product.productPrice  * param.amount  }</fmt:formatNumber></span>원<br/>
			보유 마일리지 :<span id="useMileage"></span><br/>
			배송비 : <span id="deriveryCharge"></span><br/>   
			 
			--------------------<br/>
			결제예정액 : 
			<span id="ordersTotalPrice"></span><br/>
			<input type="button" value="결제하기" id="submitBtn" />
			<input type="button" value="test" id="testBtn" />
		<hr>
		
	</div>
	
	
</form>

