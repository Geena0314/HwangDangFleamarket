<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
div.seller_listing{
	float: left;
	border-top: 1px solid gray;
	border-bottom: 1px solid gray;
	margin: 20px 20px 20px 20px;
	padding: 20px 20px 20px 20px;
	max-width: 800px;
}
ul{
	display: block;
	list-style: none;
}
div.seller_listing li#list_block{
	float: left;
	overflow: hidden;
	position: relative;
	height: 150px;
	min-width: 800px;
	padding: 15px 15px 15px 15px;
}
li{
	display: list-item;
	margin: 0px;
}

div{
	display: block;
}
.thmb{
	float: left;
	width: 150px;
	height: 150px;
}
.store_info{
	float: left;
	width: 400px;
	height: 150px;
	border-right: 1px solid gray;
}
.store_products{
	float: left;
	width: 150px;
	height: 150px;
}
p{
	clear: both;
}
b{
	font-size: 15pt;
}
img{
	width: 150px;
	height: 150px;
}
.store_img{
	border-radius: 30px;
	overflow: hidden;
}
</style>
<h2>판매 현황.</h2>
<div class="seller_listing">
	<ul>
		<c:forEach items="${requestScope.orderList}" var="list" varStatus="no">
			<c:forEach items="${list.orderProductList}" var="productList" varStatus="nos">
				<li id="list_block">
					<div class="thmb">
						<div class="store_img">
							<c:choose>
								<c:when test="${ productList.orderProductStatus == 5}">
									<!-- 교환신청 Controller Url주소 입력. -->
									<a href="#" onClick="window.open('/HwangDangFleamarket/admin/salesInfo.go?sellerStoreNo=${sessionScope.seller.sellerStoreNo}&page=${ requestScope.bean.page }', '판매자 등록 신청 내용', 'scrollbars=yes width=600 height=600 left=450 top=100');">
										<img src="../image_storage/${productList.product.productMainImage}">
									</a>
								</c:when>
								<c:when test="${ productList.orderProductStatus == 6}">
									<a href="#" onClick="window.open('/HwangDangFleamarket/seller/sellerRefundCheck.go?sellerStoreNo=${sessionScope.seller.sellerStoreNo}&page=${ requestScope.bean.page }&ordersNo=${ productList.ordersNo }&orderSeqNo=${ productList.orderSeqNo }', '환불 현황', 'scrollbars=yes width=600 height=600 left=450 top=100');">
										<img src="../image_storage/${productList.product.productMainImage}">
									</a>
								</c:when>
								<c:otherwise>
									<img src="../image_storage/${productList.product.productMainImage}">
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<ul class="store_info">
						<li>
							${productList.product.productName}
						</li>
						<li class="introduction">
							주문 번호 : ${productList.ordersNo}<br>
							주문 수량 : ${productList.orderAmount}<br>
							총 주문 가격 : ${list.ordersTotalPrice}
						</li>
					</ul>
					<div class="store_products">
						<ul class="product_list">
							<li>구매자 : ${list.memberId}</li>
							<c:forEach begin="0" end="9" step="1" varStatus="status">
								<c:if test="${ productList.orderProductStatus ==  status.index}">
									<li>주문 현황 : ${requestScope.status[status.index]}</li>
								</c:if>
							</c:forEach>
							<li>
								<c:if test="${list.ordersRequest!=null}">
									요청 사항 : ${list.ordersRequest}
								</c:if>
							</li>
						</ul>
					</div>
				</li>
			</c:forEach>
		</c:forEach>
	</ul>
</div>

<p align="center">
	<!-- ◀이전 페이지 그룹 처리 -->
<c:choose>
	<c:when test="${requestScope.bean.previousPageGroup}">
		<a href="/HwangDangFleamarket/seller/salesStatus.go?page=${requestScope.bean.beginPage-1}&sellerStoreNo=${sessionScope.seller.sellerStoreNo}">
			◀ 
		</a>
	</c:when>
	<c:otherwise>◀</c:otherwise>
</c:choose>
&nbsp;&nbsp;
<!-- 페이지 처리 -->
<c:forEach begin="${requestScope.bean.beginPage}"
	end="${requestScope.bean.endPage}" var="page">
	<c:choose>
		<c:when test="${page == requestScope.bean.page}">
  				<b>${page}</b>
 			</c:when>
		<c:otherwise>
			<a href="/HwangDangFleamarket/seller/salesStatus.go?page=${page}&sellerStoreNo=${sessionScope.seller.sellerStoreNo}">
				${page} 
			</a>
		</c:otherwise>
	</c:choose>
&nbsp;&nbsp;
</c:forEach>
	<!-- 다음 페이지 그룹 처리 ▶ -->
	<c:choose>
		<c:when test="${requestScope.bean.nextPageGroup}">
			<a href="/HwangDangFleamarket/seller/salesStatus.go?page=${requestScope.bean.endPage+1}&sellerStoreNo=${sessionScope.seller.sellerStoreNo}">
				▶
			</a>
		</c:when>
		<c:otherwise>▶</c:otherwise>
	</c:choose>
</p>