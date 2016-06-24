<%@page contentType="text/html;charset=utf-8"%>
<fieldset style="width:350px">
	<legend>로그인 폼</legend>   
	<form action="/HwangDangFleamarket/member/loginresult.go" method="post" name="login_form">
		<table align='center'>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="memberId" size="20" autofocus="autofocus"></td>
			</tr>
			<tr>
				<td>패스워드</td>
				<td><input type="password" name="memberPassword" size="20"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="로그인"/>
					<input type="reset" value="초기화"/>
				</td>
			</tr>
		</table>	
	</form>
</fieldset>