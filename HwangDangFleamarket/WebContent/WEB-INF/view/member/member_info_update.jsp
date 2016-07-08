<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/HwangDangFleamarket/scripts/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
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
					}else{
						//불일치
						$("#currentPasswordMsg").html("비밀번호를 잘못입력 하였습니다.(불일치)");
					}
				} , 
				"error" : function(a , status , httpErrorMsg){
					alert("패스워드 Ajax 실패 :" + status +httpErrorMsg);
				}
				
			});
			
			
		});
		
		
		
		
		$("#selectEmail").on("change", function()
				{
					var index = this.selectedIndex;
					if(index == 0)
					{
						$("#domain").empty().hide();
						return false;
					}
					else if(index == 16)
					{
						$("#domain").val("").removeAttr("readonly").show();
						return false;
					}
					else
					{
						$("#domain").empty().val($("#selectEmail option:selected").val()).hide();
						return true;
					}
				});
				
				//submit 클릭시.
				$("#submit").on("click", function()
				{
					var result;
					if(!$("#memberId").val() || $("#memberId").val().trim().length < 6 || $("#memberId").val().trim().length > 12)
					{
						alert("id는 6글자 이상, 12글자 이하로 입력해 주세요.");
						$("#memberId").val("").focus();
						return false;
					}

					if($("#selectEmail option:selected").index() == 0 || !$("#domain").val())
					{
						alert("이메일을 선택 또는 입력해 주세요.");
						$("#selectEmail option:selected").removeAttr('selected');
						$("#selectEmail option:eq(0)").attr('selected', 'true');
						$("#domain").val("");
						return false;
					}
						
					if($("#memberPassword").val().trim().length < 8 || $("#memberPassword").val().trim().length > 20)
					{
						alert("패스워드는 8자 이상 20자 이하로 입력해 주세요.");
						$("#memberPassword").val("").focus();
						return false;
					}
					
					if($("#memberName").val().trim().length < 2 || $("#memberName").val().trim().length > 6)
					{
						alert("이름은 2자이상 6자 이하로 입력해 주세요.");
						$("#memberName").val("").focus();
						return false;
					}
					
					if($("#hp2").val().trim().length < 3 || $("#hp2").val().trim().length > 4 || $("#hp3").val().trim().length != 4)
					{
						alert("전화번호를 올바르게 입력해 주세요.")
						$("#hp2").val("").focus();
						$("#hp3").val("");
						return false;
					}
					
					if(!$("#memberZipcode").val())
					{
						alert("주소를 검색해 주세요.");
						return false;
					}
					if($("#memberSubAddress").val().trim().length < 4 || $("#memberSubAddress").val().trim().length > 30)
					{
						alert("세부 주소는 4자 이상 30자 이하로 입력해 주세요.");
						$("#memberSubAddress").val("").focus();
						return false;
					}
					var id = $("#memberId").val()+"@"+$("#domain").val();
					$.ajax(
					{
						"url" : "/HwangDangFleamarket/member/registerIdCheck.go",
						"type" : "POST",
						"data" : "memberId=" + id,
						"dataType" : "text",
						"async" : false,
						"beforeSend" : function()
						{
							
						},
						"success" : function(text)
						{
							if(text == "fail")
							{
								alert("중복된 ID입니다.");
								$("#memberId").val("").focus();
								r = false;
								return false;
							}
							else
							{
								r = true;
							}
						},
						"error" : function()
						{
							
						}
					});
					return r;
				});
		
		
				
		//패스워드 변경 폼 view
		$("#updatePasswordBtn").on("click",function(){
			$("#hiddenPasswordSpan").show();
		});
		
		
		$("#updateIdBtn").on("click",function(){
			$("#hiddenIdSpan").show();
		});
		
	$("#nameUpdateBtn").on("click",function(){
			$("#hiddenNameSpan").show();
		});
	
	$("#phoneUpdateBtn").on("click",function(){
		$("#hiddenPhoneSpan").show();
	});
	
	$("#updateAddressBtn").on("click",function(){
		$("#hiddenAddressSpan").show();
	});
		
	//폼전송버튼
	$("#submit").on("click",function(){
			
	});

	});
</script>

<form method="post" action="/HwangDangFleamarket/member/setMember.go" name="register" id="registerForm">
<h2 class="page-header">황당 플리마켓 회원정보 수정</h2>
<div class="table-responsive" >
	<table width='600' class="table table-striped">
		<tr class="trInput">
		
			<td width='150' class='tdName'>I&nbsp&nbsp&nbsp&nbsp&nbspD</td>
			<td>
				 ${sessionScope.login_info.memberId } <input type="button" value="수정" id="updateIdBtn"/>
				<br/>
				<span hidden="true" id="hiddenIdSpan" >
					<input type="text" name="memberId" size=13 id="memberId" onkeydown="idCheck(this);">
				@
				<input type="text" name="domain" id="domain" size=13 readonly="readonly">
				<select id="selectEmail">
					<option>이메일을 선택하세요.</option>
					<c:forEach items="${requestScope.emailList}" var="email">
						<option>${ email.codeName }</option>
					</c:forEach>
					<option>직접입력</option>
				</select>
				</span>				
			</td>
		</tr>
		<tr class="trInput">
			<td class='tdName'>password</td>
			<td>
				<input type="button"  id="updatePasswordBtn" value="수정"/><br/>
				<span hidden="true" id="hiddenPasswordSpan">
					현재비밀번호 : <input type="password" name="oldPassword" size="20" id="oldPassword"><font color="blue" id="currentPasswordMsg">현재 비밀번호를 입력해 주세요</font><br/>
					새 비밀번호 : <input type="password" name="newPassword1" size="20" id="newPassword1"> 8~15자의 영문 대/소문자, 숫자 조합<br/>
					새 비밀번호 확인 :<input type="password" name="newPassword2" size="20" id="newPassword2"><input type="button" id="updatePassword" value="비밀번호수정" /><br/>
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



${sessionScope.login_info }