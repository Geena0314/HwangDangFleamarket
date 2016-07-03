<%@ page contentType="text/html;charset=utf-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

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
			
			//1.새로운 배송지 선택시 검증 로직 
			var test = "ABC";
			var ordersNo = "";
			ordersNo = ordersNo + new Date().format("yyyyMMdd");
			ordersNo = ordersNo + test;
			//alert(ordersNo);
			
			
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
				
				var ordersPhone = phone1+"-"+phone2+"-"phone3;
				
			}else{
				//기존주소로 구매하였다면 히든요소 삭제 
				$("#newAddress").empty();
				 ordersReceiver = $("#memberName").val();
				 ordersPhone = $("#memberPhone").val().trim();
				 ordersZipcode = $("#memberZipcode").val().trim();
				 ordersAddress = $("#memberAddress").val().trim();
				 ordersSubAddress = $("#memberSubAddress").val().trim();
			}
			
			
			
			/*
			private String ordersNo;  varchar(10)  //주문번호
			private String ordersReceiver;
			private String ordersPhone;
			private String ordersZipcode;
			private String ordersAddress;
			private String ordersSubAddress;
			---
			private int ordersTotalPrice;  //주문한 총가격 
			private String ordersPayment;   // 결제방식
			private String ordersRequest;  
			private int paymentStatus;    // 결재여부 
			private Date orders_date;   //주문날짜 
			private String memberId;  //구매자 ID
			*/
			
			var ordersTotalPrice = $("#address1").val().trim();
			var ordersPayment = $("#address1").val().trim();
			var ordersRequest = $("#address1").val().trim();
			var paymentStatus = $("#address1").val().trim();
			var orders_date = $("#address1").val().trim();
			var memberId = $("#address1").val().trim();
			
			 String queryString = "?ordersNo="+ordersNo+"&ordersReceiver=";	 
			
			$("form").prop("action", "/HwangDangFleamarket/buy/buyProductOne.go"+queryString);
			$("form").submit(); 
			
			
		}); //결제버튼
		
		
		
		
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

<form action="" method="POST" >
	<div id="left_lalyer">
		<div id="address_div">
			<h4>배송지 선택</h4>
			<hr>
			${sessionScope.login_info.memberName}<input type="radio" name="diliverAddress" id="diliverAddress"  checked="checked">   
			새로운배송지 <input type="radio" name="diliverAddress" id="newAddress">
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
			<hr>
			
			<hr>
			<h4>결제수단 선택</h4>
			무통장현금<input type="radio" name="payment"/>
			카드<input type="radio" name="payment"/>
			자동이체<input type="radio" name="payment"/>
			간편결제<input type="radio" name="payment"/>
			<hr>
		</div>
	
	</div>
	<div id="right_layer">
		<hr>
		<h4>주문상품 정보</h4>
			스토어명 : ${param.sellerStoreNo  } <br/>
			제품이름(제품정보) : ${param.productId  } <br/>
			옵션명 : ${param.option } <br/>
			가격/구매수랑 :  ${param.amount }개<br/>
			
			총주문수 :  <br/>
		<hr>
		
		<hr>
		<h4>최종결제 정보</h4>
			상품가격 :<span id="productPrice">${requestScope.product.productPrice }</span> <br/>
			보유 마일리지 :<span id="memberMileage">${sessionScope.login_info.memberMileage }</span> <br/>
			배송비 : <span id="deriveryCharge">
			<c:choose>
				<c:when test="${requestScope.product.productPrice > 30000 } ">0</c:when>
				<c:otherwise>3000</c:otherwise>
			</c:choose>
			</span><br/>
			--------------------<br/>
			결제예정액 : <span>${requestScope.product.productPrice - sessionScope.login_info.memberMileage }</span> <br/>
			<input type="submit" value="결제하기" id="submitBtn" />
		<hr>
		
	</div>
	
	
	
</form>

