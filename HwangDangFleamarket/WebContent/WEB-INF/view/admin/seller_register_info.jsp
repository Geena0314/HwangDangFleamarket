<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>

	<body>
		<h1 align="center">판매자 등록 신청</h1>
		<div align="center">
			<form method="POST" action="/HwangDangFleamarket/admin/sellerRegisterRecognize.go?sellerStoreNo=${ requestScope.seller.sellerStoreNo }&memberId=${ requestScope.seller.member.memberId }">
				<table id="table">
					<tr>
						<th>아이디</th>
						<td colspan="2">${ requestScope.seller.member.memberId }</td>
					</tr>
					<tr>
						<th>이름</th>
						<td colspan="2">${ requestScope.seller.member.memberName }</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td colspan="2">${ requestScope.seller.member.memberPhone }</td>
					</tr>
					<tr >
						<th rowspan="2">주소</th>
						<td width="100px" colspan="2">${ requestScope.seller.member.memberZipcode } ${ requestScope.seller.member.memberAddress }</td>
					</tr>
					<tr>
						<td colspan="2">${ requestScope.seller.member.memberSubAddress }</td>
					</tr>
					<tr>
						<th>상호명</th>
						<td colspan="2">${ requestScope.seller.sellerStoreName }</td>
					</tr>
					<tr>
						<th>사업자 번호</th>
						<td colspan="2">${ requestScope.seller.sellerTaxId }</td>
					</tr>
					<tr>
						<th>업종</th>
						<td>${ requestScope.seller.sellerIndustry }</td>
						<td>${ requestScope.seller.sellerSubIndustry }</td>
					</tr>
					<tr>
						<th rowspan="2">매장 주소</th>
						<td colspan="2">${ requestScope.seller.sellerZipcode } ${ requestScope.seller.sellerAddress }</td>
					</tr>
					<tr>
						<td colspan="2">${ requestScope.seller.sellerSubAddress }</td>
					</tr>
					<tr>
						<th>판매 물품</th>
						<td colspan="2">${ requestScope.seller.sellerProduct1 }${ requestScope.seller.sellerProduct2 }${ requestScope.seller.sellerProduct3 }</td>
					</tr>
					<tr>
						<th>스토어 소개글</th>
						<td colspan="2">${ requestScope.seller.sellerIntroduction }</td>
					</tr>
					<tr>
						<td colspan="3" align="right">
							<input type="submit" value="승인하기">  
							<input type="button" value="거절하기" onClick="window.open('/HwangDangFleamarket/admin/sellerRegisterReject.go?sellerStoreNo=${requestScope.seller.sellerStoreNo}', '거부', 'width=600 height=600 left=450 top=100');">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>