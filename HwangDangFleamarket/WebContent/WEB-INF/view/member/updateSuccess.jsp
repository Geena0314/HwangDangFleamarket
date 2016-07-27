<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<h2>회원정보수정완료</h2>
<c:choose>
	<c:when test="${not empty sessionScope.login_info}">
		<!-- id -->
		<table width='600' class="table table-striped">
		<tr class="trInput">
			<td width='150' class='tdName'>I&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D</td>
			<td>
				${sessionScope.login_info.memberId }
			</td>
		</tr>
		
		<!-- password  -->
		<tr class="trInput">
			<td width='150' class='tdName'>비밀전호</td>
			<td>
				 ${sessionScope.login_info.memberPassword } 
			</td>
		</tr>
		
		<!-- name  -->
		<tr class="trInput">
			<td width='150' class='tdName'>이름</td>
			<td>
				 ${sessionScope.login_info.memberName } 
			</td>
		</tr>
		
		<!-- 전화번호  -->
		<tr class="trInput">
			<td width='150' class='tdName'>전화번호</td>
			<td>
				${sessionScope.login_info.memberPhone}
			</td>
		</tr>
		
		<!-- 주소  -->
		<tr class="trInput">
			<td width='150' class='tdName'>주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>
			<td>
				 ${sessionScope.login_info.memberZipcode} ${sessionScope.login_info.memberAddress  } ${sessionScope.login_info.memberSubAddress }
			</td>
		</tr>
		
		<!-- 전화번호  -->
		<tr class="trInput">
			<td width='150' class='tdName'>전화&nbsp;번호</td>
			<td>
				${sessionScope.login_info.memberPhone}
			</td>
		</tr>
		
		<!-- 마일리지  -->
		<tr class="trInput">
			<td width='150' class='tdName'>마일리지</td>
			<td>
				 ${sessionScope.login_info.memberMileage}
			</td>
		</tr>
		
			<!--셀러정보-->
		<c:choose>  
			<c:when test="${requestScope.seller.sellerAssign eq '1'}"> 
			<tr class="trInput">
				<td width='150' class='tdName'>상호 명</td>
				<td>
					 ${requestScope.seller.sellerStoreName } 
				</td>
			</tr>
			
			<tr class="trInput">
				<td width='150' class='tdName'>사업자 번호</td>
				<td>
					 ${requestScope.seller.sellerTaxId } 
				</td>
			</tr>
			
			<tr class="trInput">
				<td width='150' class='tdName'>업종대분류</td>
				<td>
					 ${requestScope.seller.sellerIndustry } 
				</td>
			</tr>
			
			<tr class="trInput">
				<td width='150' class='tdName'>업종소분류</td>
				<td>
					 ${requestScope.seller.sellerSubIndustry } 
				</td>
			</tr>
			
			<tr class="trInput">
				<td width='150' class='tdName'>매장 주소</td>
				<td>
					 ${requestScope.seller.sellerZipcode } ${requestScope.seller.sellerAddress } ${requestScope.seller.sellerSubAddress } 
				</td>
			</tr>
			
			<tr class="trInput">
				<td width='150' class='tdName'>스토어사진</td> 
				<td>
					<img src="../image_storage/${requestScope.seller.sellerStoreImage }"  style="width:60px; height="60px;" /> 
				</td>
			</tr>
			
				<tr class="trInput">
				<td width='150' class='tdName'>판매 물품1</td>
				<td>
					 ${requestScope.seller.sellerProduct1 } 
				</td>
			</tr>
				<tr class="trInput">
				<td width='150' class='tdName'>판매 물품2</td>
				<td>
					 ${requestScope.seller.sellerProduct2 } 
				</td>
			</tr>
				<tr class="trInput">
				<td width='150' class='tdName'>판매 물품3</td>
				<td>
					 ${requestScope.seller.sellerProduct3 } 
				</td>
			</tr>
			<tr class="trInput">
				<td width='150' class='tdName'>스토어소개글</td>
				<td>
					 ${requestScope.seller.sellerIntroduction } 
				</td>
			</tr>
		</c:when>
		<c:otherwise>
			일반회원!    
		</c:otherwise>   
		</c:choose>
		
	</c:when>
</c:choose>
</table>




<p>요청하신 회원정보가 수정 되었습니다. <br/>수정된 정보로 재 로그인 해주세요!</p>
<a href="/HwangDangFleamarket/member/login.go">로그인</a>

<%
	session.removeAttribute("login_info");
	session.invalidate();
%> 