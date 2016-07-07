<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	img {
		width : 160px;
		height : 160 px;
	}
	
	#layer {
		border: 2px solid gray;
		min-height:  300px;
		min-width: 1000px;
	}
	.imgDiv , .priceDiv , .priceNameDiv , .priceInfoDiv  , .SellerNameDiv {
		float: left;
	}
</style>
조회결과  
<hr/>
<div id="layer">
	<c:choose>
	<c:when test="${requestScope.productList != null }">
		<c:forEach items="${requestScope.productList }" var="p">
			<ul>
				<li>
					<div class="imgDiv"><img src="/HwangDangFleamarket/image_storage/${p.productMainImage }"/></div>
					<div class="priceDiv">${p.productPrice }</div>
					<div class="priceNameDiv">${p.productName } </div>
					<div class="priceInfoDiv">${p.productInfo }</div>
					<div class="SellerNameDiv">${p.seller.sellerStoreName }</div>
				</li>
			</ul>
		</c:forEach>
	</c:when>
	<c:otherwise>
		조회한 상품이 없습니다.
	</c:otherwise>
</c:choose>
</div>

