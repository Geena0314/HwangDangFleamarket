<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
table, td {
	border: 1px solid gray;
	text-align: center;
}

table {
	border-collapse: collapse;
	width: 650px;
}

td {
	padding: 5px;
}

a {
	text-decoration: none;
}

a:HOVER {
	text-decoration: underline;
}

b {
	font-size: 15pt;
}
</style>
<script type="text/javascript">
	
</script>
<p align="right">
	<b>장바구니</b>
</p>
<div class="cart_list_section">
	<div class="cart_table">
		<table>
			<colgroup>
				<col style="width: 5%">
				<col style="width: 50%">
				<col style="width: 10%">
				<col style="width: 15%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">
						<label for="basket_all">
							<div class="checker" id="mark-basket_all">
								<span class="checked"> 
									<input type="checkbox" id="basket_all" title="장바구니 상품 전체선택">
								</span>
							</div>
						</label>
					</th>
					<th scope="col"><span>상품</span></th>
					<th scope="col"><span>수량</span></th>
					<th scope="col" class="col2"><span>가격</span></th>
					<th scope="col"><span>배송정보</span></th>
				</tr>
			</thead>
				<tbody>
					<tr class="cart_list">
						<td class="first">
							<div class="checker" id="mark-basket_all">
								<span class="checked"> 
									<input type="checkbox" id="basket_all" title="장바구니 상품 전체선택">
								</span>
							</div>
						</td>
						<td>
						<%-- 스토어 이름, 상품명, 선택한 옵션 --%>
							<ul>
								<li id="list_block">
									<div class="thmb">
										<div class="store_img">
											<a href="/HwangDangFleamarket/seller/sellerStore.go?sellerStoreNo=${list.sellerStoreNo}&sellerStoreImage=${list.sellerStoreImage}"><img src="../image_storage/${list.sellerStoreImage}"></a>
										</div>
									</div>
									<ul class="store_info">
										<li>
											<a href="/HwangDangFleamarket/seller/sellerStore.go?sellerStoreNo=${list.sellerStoreNo}&sellerStoreImage=${list.sellerStoreImage}">${list.sellerStoreName}</a>
										</li><br>
										<li>
											상품명
										</li>
										<li>
											선택한 옵션
										</li>
									</ul>
								</li>
							</ul>
						</td>
						<td>
						<%-- 수량 --%>
						</td>
						<td>
						<%-- 가격 --%>
						</td>
						<td>
							무료 배송
						</td>
					</tr>
				</tbody>
		</table>
	</div>
</div>

<%-- 페이징 처리 --%>
<p align="center">
	<%-- ◀이전 페이지 그룹 처리 --%>
	<c:choose>
		<c:when test="${requestScope.pagingBean.previousPageGroup}">
			<a
				href="/HwangDangFleamarket/sellerNotice/sellerNotice.go?page=${requestScope.pagingBean.beginPage-1}">
				◀ </a>
		</c:when>
		<c:otherwise>◀</c:otherwise>
	</c:choose>
	&nbsp;&nbsp;
	<%--페이지 처리 --%>
	<c:forEach begin="${requestScope.pagingBean.beginPage}"
		end="${requestScope.pagingBean.endPage}" var="page">
		<c:choose>
			<c:when test="${page == requestScope.pagingBean.page}">
				<b>${page}</b>
			</c:when>
			<c:otherwise>
				<a
					href="/HwangDangFleamarket/sellerNotice/sellerNotice.go?page=${page}">
					${page} </a>
			</c:otherwise>
		</c:choose>
&nbsp;&nbsp;
</c:forEach>
	<%--다음 페이지 그룹 처리 ▶--%>
	<c:choose>
		<c:when test="${requestScope.pagingBean.nextPageGroup}">
			<a
				href="/HwangDangFleamarket/sellerNotice/sellerNotice.go?page=${requestScope.pagingBean.endPage+1}">
				▶ </a>
		</c:when>
		<c:otherwise>▶</c:otherwise>
	</c:choose>
</p>
