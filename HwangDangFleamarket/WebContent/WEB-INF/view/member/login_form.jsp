<%@page contentType="text/html;charset=utf-8"%>
<%@taglib prefix="lee" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>황당마켓</title>
<style type="text/css">
	div
	{
		margin-top: 100px;
		margin-left: 27px;
	}
	#domain
	{
		display: none;
	}
</style>

<script type="text/javascript" src="/HwangDangFleamarket/scripts/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function()
	{
		$("#selectEmail").on("change", function()
		{
			var index = this.selectedIndex;
			if(index == 0)
			{
				$("#domain").empty().hide();
				return false;
			}
			else if(index == 15)
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
		
		$("#login").on("click", function()
		{
			if($("#id").val() == null || ($("#id").val() + $("#email").val()).length > 29 || $("#id").val().trim().length == 0)
			{
				//id가 비었거나, 30글자보다 크거나, id값에 공백만 있는경우.
				if($("#password").val() == null || $("#password").val().trim().length < 8 || $("#password").val().length > 20)
				{
					//패스워드가 널이거나, 8글자보다 작거나, 20글자보다 큰경우.
					$("#idError").empty().append("아이디 오류");
					$("#passwordError").empty().append("패스워드 오류");
					return false;
				}
				else
				{
					$("#idError").empty().append("아이디 오류");
					$("#passwordError").empty();
					return false;
				}
			}
			else
			{
				if($("#password").val() == null || $("#password").val().trim().length < 8 || $("#password").val().length > 20)
				{
					$("#idError").empty();
					$("#passwordError").empty().append("패스워드 오류");
					return false;
				}
			}
			
			//구매중 로그인페이지로 온경우 이동 
			var queryString = $("#queryString").val().trim();
			//alert("쿼리스트링: " + queryString);
			//alert(queryString.length);  
			if(queryString.length != 0 ){
				// 로그인후 상품디테일페이지로 이동 
				var url = "/HwangDangFleamarket/member/loginAfterProductDetailPage.go?page=${param.page}&productId=${param.productId}&sellerStoreNo=${param.sellerStoreNo}&amount=${param.amount}&option=${param.option}";
				$("form").prop("action",url);  
				$("form").submit();
		
			}else {
				//일반로그인페이지로이동
				$("form").prop("action", "/HwangDangFleamarket/member/loginResult.go" );
				$("form").submit();
			}
			
			
		}); //btn
		
		
	});//ready
	
	function idCheck(obj)
	{
		 //좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
        if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39
        || event.keyCode == 46 ) return;
        //obj.value = obj.value.replace(/[\a-zㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
        obj.value = obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
        obj.value = obj.value.replace(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(]/gi, '');
	}
</script>
</head>
	<body>
		
		<h2>로그인</h2>
		
		<div>
			<fieldset style="width:350px">
				<legend>로그인 폼</legend>   
				<form action="/HwangDangFleamarket/member/loginResult.go" method="post" name="login_form">
					<input type="hidden" id="queryString" name="queryString" value="${requestScope.queryString}" />
					<table align='center'>
						<tr>
							<td>아이디</td>
							<td>
								<lee:choose>
									<lee:when test="${ not empty requestScope.loginId }">
										<input type="text" name="memberId" id="id" size="10" autofocus="autofocus" onkeydown="idCheck(this)" value="${ requestScope.loginId }">
									</lee:when>
									<lee:otherwise>
										<input type="text" name="memberId" id="id" size="10" autofocus="autofocus" onkeydown="idCheck(this)">
									</lee:otherwise>
								</lee:choose>
								@<input type="text" name="domain" id="domain" size=13 readonly="readonly">
								<select id="selectEmail">
									<option>이메일을 선택하세요.</option>
									<lee:forEach items="${requestScope.emailList}" var="email">
										<lee:choose>
											<lee:when test="${ requestScope.domain == email.codeName }">
												<option selected="selected">${ email.codeName }</option>
											</lee:when>
											<lee:otherwise>
												<option>${ email.codeName }</option>
											</lee:otherwise>
										</lee:choose>
									</lee:forEach>
									<option>직접입력</option>
								</select>
							</td>
						</tr>
						<tr>
							<td colspan="2" id="idError">
								<lee:if test="${not empty requestScope.idError }">
									${ requestScope.idError }
								</lee:if>
							</td>
						</tr>
						<tr>
							<td>패스워드</td>
							<td><input type="password" name="memberPassword" id="password" size="20"></td>
						</tr>
						<tr>
							<td colspan="2" id="passwordError">
								<lee:if test="${not empty requestScope.passwordError }">
									${ requestScope.passwordError }
								</lee:if>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<input type="submit" value="로그인" id="login"/>
								<input type="reset" value="초기화"/>
							</td>
						</tr>
					</table>	
				</form>
				<font size="2" color="red" id="errorMsg">${requestScope.errorMsg }</font>
			</fieldset>
		</div>
	</body>
</html>