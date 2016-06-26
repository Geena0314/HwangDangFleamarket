<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="lee" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/HwangDangFleamarket/scripts/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function()
	{
		$("#mypage").on("click", function()
		{
			if($("#password").val() == null || $("#password").val().trim().length < 8 || $("#password").val().length > 20)
			{
				//패스워드가 널이거나, 8글자보다 작거나, 20글자보다 큰경우.
				$("#passwordError").empty().append("패스워드 오류");
				return false;
			}
		});
	});
</script>
<h1 align="center">MyPage</h1>
<form action="/HwangDangFleamarket/member/mypage.go" method="post">
	<table>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="memberId" id="id" size="10" readonly="readonly" value=${ sessionScope.login_info.memberId }> 
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
				<input type="submit" value="확인" id="mypage"/>
				<input type="reset" value="취소"/>
			</td>
		</tr>
	</table>	
</form>