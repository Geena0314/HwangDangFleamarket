<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<form method="post" action="/HwangDangFleamarket/member/registered.go" name="register">
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
			<input type="text" id="memberPhone" name="memberPhone">
			</td>
			<!-- <td>전화번호</td>
			<td>
				<select id="hp1" name="hp1">
    	        <option value="010" selected>010</option>
    	        <option value="011">011</option>
    	        <option value="016">016</option>
    	        <option value="017">017</option>
            	<option value="018">018</option>
				<option value="019">019</option>
				</select>

				-
				<input type="text" name="hp2" size="10">
				-
				<input type="text" name="hp3" size="10">
				<input type="hidden" id="memberPhone" name="memberPhone">
			</td> -->
		</tr>
		<tr>
			<td> 주          소 </td>
			<td>
				집코드<input type="text" name="memberZipcode" size="30">
				<input type="text" name="memberAddress" size="60">
				<br>
				<input type="text" name="memberSubAddress" size="60">
				판매자냐 아니냐<input type="text" name="memberAssign" size="20">
			</td>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="가입">
				<input type="reset" value="다시 작성">
			</td>
		</tr>
		</table>
</form>
