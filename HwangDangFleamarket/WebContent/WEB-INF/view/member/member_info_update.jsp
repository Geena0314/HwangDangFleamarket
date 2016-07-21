<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	img {
		width:70px; 
		hiehgt: 70px;
	}
</style>

<script type="text/javascript" src="/HwangDangFleamarket/scripts/jquery.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>



<script type="text/javascript">

//다음주소 API
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;

            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('sample6_address').value = fullAddr;

            // 커서를 상세주소 필드로 이동한다.
            document.getElementById('sample6_address2').focus();
        }
    }).open();
}

	$(document).ready(function(){
		 
		var passwordFlag = false;
		var nameFlag = false;
		var phoneFlag = false;
		var addressFlag = false;
		var oldPsswordFlag = false;
		//기존비밀번호 맞는지 검증
		$("#oldPassword").on("blur", function(){
			var oldPassword = $("#oldPassword").val().trim();
			//alert(oldPassword);
			$.ajax({   
				"url" : "/HwangDangFleamarket/member/oldPasswordChecked.go" , 
				"type" : "POST" , 
				"data" :  "oldPassword=" +oldPassword , 
				"dataType" : "text"  ,
				"sendBefore" : function(){
					if(oldPassword.length == 0){
						alert("비밀번호를 입력해주세요.");
						return false;
					}else if(oldPassword.length < 8){
						alert("비밀번호는 8자 이상 입니다.")
					}
				} , 
				"success" : function(flag){
					if(flag == 'true'){
						// 기존비밀번호와 입력비밀번호 일치
						$("#currentPasswordMsg").html("비밀번호가 일치합니다.");
						oldPsswordFlag = true;
					}else{
						//불일치
						$("#currentPasswordMsg").html("비밀번호를 잘못입력 하였습니다.(불일치)");
					}
				} , 
				"error" : function(a , status , httpErrorMsg){
					alert("패스워드 Ajax 실패 :" + status +httpErrorMsg);
				}
			});
		}); // 패스워드 ajax func
		
		$("#selectEmail").on("change", function(){
					var index = this.selectedIndex;
					if(index == 0){
						$("#domain").empty().hide();
						return false;
					}
					else if(index == 16){
						$("#domain").val("").removeAttr("readonly").show();
						return false;
					}
					else{
						$("#domain").empty().val($("#selectEmail option:selected").val()).hide();
						return true;
					}
				});
				
				//submit 클릭시.
				$("#submit").on("click", function(){
					var result;
					if(!oldPsswordFlag && passwordFlag) {
						//기존비밀번호불일치
						alert("기존비밀번호가 틀립니다. 확인바랍니다.");
						return false;
					}
					
					if( passwordFlag  && $("#newPassword1").val().trim().length < 8 || $("#newPassword1").val().trim().length > 20){
						alert("패스워드는 8자 이상 20자 이하로 입력해 주세요.");
						$("#newPassword1").val("").focus();
						$("#newPassword2").val("");
						return false;
					}
					if( passwordFlag  && $("#newPassword1").val().trim() != $("#newPassword2").val().trim()){
						alert("패스워드1과 패스워드2가 틀립니다.");
						$("#newPassword1").val("").focus();
						$("#newPassword2").val("");
						return false;
					}
					
					if(nameFlag && $("#memberName").val().trim().length < 2 || $("#memberName").val().trim().length > 6)
					{
						alert("이름은 2자이상 6자 이하로 입력해 주세요.");
						$("#memberName").val("").focus();
						return false;
					}
					    
					if(phoneFlag && ($("#hp2").val().trim().length < 3 || $("#hp2").val().trim().length > 4 || $("#hp3").val().trim().length != 4) ){	
						alert("전화번호를 올바르게 입력해 주세요.")
						$("#hp2").val("").focus();
						$("#hp3").val("");
						return false;
					}
					
					if(addressFlag && addressFlag && !$("#memberZipcode").val())
					{
						alert("주소를 검색해 주세요.");
						return false;
					}
					if(addressFlag && $("#memberSubAddress").val().trim().length < 4 || $("#memberSubAddress").val().trim().length > 30)
					{
						alert("세부 주소는 4자 이상 30자 이하로 입력해 주세요.");
						$("#memberSubAddress").val("").focus();
						return false;
					}
					var id = $("#memberId").val()+"@"+$("#domain").val();
					$.ajax({
						"url" : "/HwangDangFleamarket/member/registerIdCheck.go",
						"type" : "POST",
						"data" : "memberId=" + id,
						"dataType" : "text",
						"async" : false,
						"beforeSend" : function(){
							
						},
						"success" : function(text){
							if(text == "fail"){
								alert("중복된 ID입니다.");
								$("#memberId").val("").focus();
								r = false;
								return false;
							}
							else{
								r = true;
								//alert("비밀번호 중복아님다.!");
								$("form").prop("action" , "/HwangDangFleamarket/member/setMember.go");
								$("form").submit();
								
							}
						},
						"error" : function(a  , status , httpMsg){
							alert("ajax실패:"+httpMsg);
						}
					});
					
					return r;
				});
		
	//패스워드 변경 폼 view
	$("#updatePasswordBtn").on("click",function(){
		$("#hiddenPasswordSpan").show();
		passwordFlag = true;
	});
	$("#nameUpdateBtn").on("click",function(){
			$("#hiddenNameSpan").show();
			 nameFlag = true;
		});
	$("#phoneUpdateBtn").on("click",function(){
		$("#hiddenPhoneSpan").show();
		 phoneFlag = true;
	
	});
	$("#updateAddressBtn").on("click",function(){
		$("#hiddenAddressSpan").show();
		 addressFlag = true;
	});
		
	  
	
	
	 //판매자 정보수정버튼 클릭 리스트들 
	$("#sellerStoreNameUpdateBtn").on("click",function(){
		$("#hiddenSellerStoreName").show();
	});
	 
	$("#sellerTaxIdUpdateBtn").on("click",function(){
		$("#hiddenSellerTaxId").show();
	});
	 
	   
	$("#sellerSubIndustryUpdateBtn").on("click",function(){
		$("#hiddenSellerSubIndustry").show();
	});
	
	 
	$("#sellerAddressUpdateBtn").on("click",function(){
		$("#hiddenSellerAddress").show();
	});
	
}); //ready
	
	//hidden된 스팬을 보여주는 함수 정의
	function  showSpan(spanName){
		var span = document.getElementById(spanName);
		//console.log(span);
		span.style.display = 'block'; 		
	}
	
	
</script>
<h2 class="page-header store_look_around">황당 플리마켓 회원정보 수정</h2>
<form method="post" enctype="multipart/form-data" action="/HwangDangFleamarket/member/setMember.go" name="register" id="registerForm">
<div class="table-responsive" >
	<table width='600' class="table table-striped">
		<tr class="trInput">
		
			<td width='150' class='tdName'>I&nbsp&nbsp&nbsp&nbsp&nbspD</td>
			<td>
				 ${sessionScope.login_info.memberId }
				  <input type="hidden" name="memberId" value="${sessionScope.login_info.memberId }" />
			</td>
		</tr>
		<tr class="trInput">
			<td class='tdName'>password</td>
			<td>
				<input type="button"  id="updatePasswordBtn" value="수정"/><br/>
				<span hidden="true" id="hiddenPasswordSpan">
					현재비밀번호 : <input type="password" name="oldPassword" size="20" id="oldPassword"><font color="blue" id="currentPasswordMsg">현재 비밀번호를 입력해 주세요</font><br/>
					새 비밀번호 : <input type="password" name="newPassword1" size="20" id="newPassword1"> 8~15자의 영문 대/소문자, 숫자 조합<br/>
					새 비밀번호 확인 :<input type="password" name="newPassword2" size="20" id="newPassword2"><br/>
				</span>
			</td>
		</tr>
		<tr class="trInput">
			<td class='tdName'>이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</td>
			<td>
				${sessionScope.login_info.memberName }<input type="button" value="수정" id="nameUpdateBtn"/><br/>
				<span hidden="hidden" id="hiddenNameSpan">
					<input type="text" name="memberName" size="20" id="memberName" onkeydown="nameCheck(this);">
				</span>
				
			</td>
		</tr>
		<tr class="trInput">
			<td class='tdName'>전화번호</td>
			<td>${sessionScope.login_info.memberPhone } <input type="button" value="수정"  id="phoneUpdateBtn" />
			<br/>
			<span id="hiddenPhoneSpan"  hidden="true">
				<select id="hp1" name="hp1">
	    	        <option>010</option>
	    	        <option>011</option>
	    	        <option>016</option>
	    	        <option>017</option>
	            	<option>018</option>
					<option>019</option>
				</select>
				-
				<input type="text" name="hp2" size="10" id="hp2">
				-
				<input type="text" name="hp3" size="10" id="hp3">
			</span>					
			</td>
		</tr>
		<tr class="trInput">
			<td class='tdName'>주&nbsp;&nbsp;&nbsp;&nbsp;소</td>
			<td>
				[ ${sessionScope.login_info.memberZipcode } ] ${sessionScope.login_info.memberAddress } ${sessionScope.login_info.memberSubAddress }<input type="button" value="수정" id="updateAddressBtn"/><br/>
			
			<span id="hiddenAddressSpan" hidden="true">
				<input type="text" name="memberZipcode" size="30" readonly="readonly" id="memberZipcode">
				<input type="button" value="주소검색" id="findAddress" onclick="window.open('/HwangDangFleamarket/member/findAddress.go', '주소검색', 'resizable=no scrollbars=yes width=700 height=500 left=500 top=200');">
				<input type="text" name="memberAddress" size="60" readonly="readonly" id="memberAddress"><br>
				<input type="text" name="memberSubAddress" size="60" id="memberSubAddress">
			</span>
			</td>
		</tr>   
		    
		<!-- 판매자일경우 판매자 정보 변경 양식  -->
		<c:if test="${sessionScope.login_info.memberAssign == 1 }">
			<tr class="trInput">  
					<td class='tdName'>상호 명</td>
					<td>${requestScope.seller.sellerStoreName } <input type="button" value="수정" id="sellerStoreNameUpdateBtn"/><br/>
					<span id="hiddenSellerStoreName" hidden="hidden">	
						<input type="text" name="sellerStoreName" />
					</span>
					</td>
			</tr>
						
			<tr class="trInput">
				<td class='tdName'>사업자 번호</td>
				<td>${requestScope.seller.sellerTaxId }<input type="button" value="수정" id="sellerTaxIdUpdateBtn"/><br/>
					<span id="hiddenSellerTaxId" hidden="true">  
						<input type="text" name="sellerTaxId">
					</span>
					
				</td>
			</tr>
				
			<tr class="trInput">
				<td class='tdName'>업종대분류</td>
				<td>${requestScope.seller.sellerIndustry }<input type="button" value="수정" onclick="showSpan('hiddenSellerIndustry')" /><br/>
					<span hidden="true" id="hiddenSellerIndustry">
						<input type="text" name="sellerIndustry">
					</span>
				</td>
			</tr>	
						
			<tr class="trInput">
				<td class='tdName'>업종소분류</td>
				<td>${requestScope.seller.sellerSubIndustry }<input type="button" value="수정" id="sellerSubIndustryUpdateBtn"/><br/>
					<span hidden="true" id="hiddenSellerSubIndustry">
						<input type="text" name="sellerSubIndustry">
					</span>
				</td>
			</tr>

			<tr class="trInput">
				<td class='tdName'> 매장 주소 </td>
				<td>[${requestScope.seller.sellerZipcode}]${requestScope.seller.sellerAddress}${requestScope.seller.sellerSubAddress}
				<input type="button" value="수정" id="sellerAddressUpdateBtn"/><br/>
					<span hidden="true" id="hiddenSellerAddress">
						<input type="text" id="sample6_postcode" placeholder="우편번호"  name="sellerZipcode" size="30">
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" id="sample6_address" placeholder="주소" name="sellerAddress" size="60">
						<input type="text" id="sample6_address2" placeholder="상세주소" name="sellerSubAddress" size="60">
					</span>
				</td>
			</tr>  
			
			<tr class="trInput">
				<td class='tdName'>스토어사진</td>
				<td><img src="../image_storage/${requestScope.seller.sellerStoreImage }" />
					<input type="file" alt="이미지등록" value="이미지등록"  name="sellerStoreImage" />
				</td>
			</tr>
			
			<tr class="trInput">
				<td class='tdName'>판매 물품1</td>
				<td>${requestScope.seller.sellerProduct1 }
				<input type="button" value="수정"  onclick="showSpan('hiddenSellerProduct1')" /><br/>
					<span hidden="true" id="hiddenSellerProduct1">
						<input type="text" name="sellerProduct1">
					</span>
				</td>
			</tr>
			
			<tr class="trInput">
				<td class='tdName'>판매 물품2</td>
				<td>${requestScope.seller.sellerProduct2 } 
					<input type="button" value="수정" onclick="showSpan('hiddensellerProduct2')"/><br/>
					<span hidden="true" id="hiddensellerProduct2">
						<input type="text" name="sellerProduct2" />
					</span>
				</td>
			</tr>
			  
			<tr class="trInput">
				<td class='tdName'>판매 물품3</td>
				<td>${requestScope.seller.sellerProduct3 }
					<input type="button" value="수정" onclick="showSpan('hiddenSellerProduct3')" /><br/>
					<span hidden="true" id="hiddenSellerProduct3">
						<input type="text" name="sellerProduct3"/>
					</span>
				</td>
			</tr>
			
			<tr class="trInput">
				<td class='tdName'>스토어소개글</td>
				<td>${requestScope.seller.sellerIntroduction }
					<input type="button" value="수정"  onclick="showSpan('hiddenSellerIntroduction')" /><br/>
					<span hidden="true" id="hiddenSellerIntroduction">
					  	<textarea name="sellerIntroduction"></textarea>
					</span>
				</td>
			</tr>
			</div>
		</c:if>		
		<tr class="trInput">
			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		</tr>
		
		<tr class="trInput">
			<td colspan="2" align="left">
				<input class="btn btn-lg btn-success btn-block" type="submit" value="수정" id="submit">
				<input class="btn btn-lg btn-primary btn-block" type="reset" value="다시 작성">
			</td>
		</tr>
	</table> 
</div>
</form>
