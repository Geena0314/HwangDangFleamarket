<%@page contentType="text/html;charset=utf-8"%>
<%@taglib prefix="lee" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="/HwangDangFleamarket/scripts/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function()
	{
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
		});
	});
</script>

<fieldset style="width:350px">
	<legend>로그인 폼</legend>   
	<form action="/HwangDangFleamarket/member/loginResult.go" method="post" name="login_form">
		<table align='center'>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="memberId" id="id" size="10" autofocus="autofocus">@
					  <input type="text" name="email" id="email" size="10"> 
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
</fieldset>