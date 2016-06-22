<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<form method="post" action="" name="register">
<h1 align="center">회원가입</h1>
	<table width='600'>
		<tr>
			<td>I          D</td>
			<td>
				<input type="text" name="memberId">
				@
				<input type="text" name="memberId">
			</td>
		</tr>
		<tr>
			<td>Password</td>
			<td>
				<input type="password" name="memberPassword" size="20">
			</td>
		</tr>
		<tr>
			<td>이          름</td>
			<td>
				<input type="text" name="memberName" size="20">
			</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td>
				<select>
    	        <option>010</option>
        	    <option>011</option>
            	<option>018</option>
				<option>019</option>
				</select>

				-
				<input type="text" name="memberPhone" size="10">
				-
				<input type="text" name="memberPhone" size="10">
			</td>
		</tr>
		<tr>
			<td> 주          소 </td>
			<td>
				<input type="text" name="memberAddress" size="60">
				<br>
				<input type="text2" name="memberSubAddress" size="60">
			</td>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="가입">
				<input type="reset" value="다시작성">
			</td>
		</tr>
		</table>
</form>
