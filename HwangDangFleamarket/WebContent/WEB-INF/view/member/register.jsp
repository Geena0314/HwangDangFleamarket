<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<form method="post" action="/HwangDangFleamarket/member/registerresult.go" name="register">
<h1 align="center">회원가입</h1>
	<table width='600'>
		<tr>
			<td width='150' align='center'>I&nbsp&nbsp&nbsp&nbsp&nbsp&nbspD</td>
			<td>
				<input type="text" name="memberId">
				@
				<input type="text" name="memberId">
			</td>
		</tr>
		<tr>
			<td align='center'>Password</td>
			<td>
				<input type="password" name="memberPassword" size="20">
			</td>
		</tr>
		<tr>
			<td align='center'>이&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp름</td>
			<td>
				<input type="text" name="memberName" size="20">
			</td>
		</tr>
		<tr>
			<td align='center'>전화번호</td>
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
			<td align='center'>우편번호</td>
			<td>
			<input type="text" name="memberZipcode" size="30">
			</td>
		</tr>
		<tr>
			<td align='center'> 주&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp소 </td>
			<td>
				<input type="text" name="memberAddress" size="60">
				<br>
				<input type="text" name="memberSubAddress" size="60">
			</td>
		</tr>
		<tr>
			<td align='center'> 판매자 여부 </td>
			<td>
			<!-- <input type="text" name="memberAssign" size="20"> -->
				<input type="checkbox" name="memberAssign" value="1">
				판매자 등록에 동의합니다
			</td>
		</tr>
		<tr>
		
			<td colspan="2" align="center">
				<input type="submit" value="가입">
				<input type="reset" value="다시 작성">
			</td>
		</tr>
		</table>
</form>
