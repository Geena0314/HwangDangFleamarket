<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="lee"  uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
	/* div#main
	{
		width:700px;
		height:500px;
		backfround-color: blue;
		margin-left : 150px;
		margin-top : 100px;
		margin-botton: 50px;
	}
	div#product1
	{
		width: 200px;
		height : 200px;
		float : left;
		margin-bottom : 25px;
	}
	div#product2
	{
		width: 200px;
		height : 200px;
		float : left;
		margin-left : 50px;
		margin-bottom : 25px;
	}
	div#product3
	{
		width: 200px;
		height : 200px;
		float : left;
		margin-left : 50px;
		margin-bottom : 25px;
	}
	div#product4
	{
		width: 200px;
		height : 200px;
		float : left;
	}
	div#product5
	{
		width: 200px;
		height : 200px;
		float : left;
		margin-left : 50px;
	}
	div#product6
	{
		width: 200px;
		height : 200px;
		float : left;
		margin-left : 50px;
	}
	.mainImage 
	{
	    opacity: 0.5;
	    filter: alpha(opacity=50); 
	 } 
	 미리 div만들어서 숨겨놓고 모르겠다. 
	img:hover 
	{
	    opacity: 1.0;
	    filter: alpha(opacity=100); 
	}
	div#page
	{
		margin-top: 30px;
		width: 700px;
		float: left;
		align: center;
		text-align: center;
	}
	.registerProductBtn{
		float: right;
	} */
</style>

<h2 class="page-header store_look_around">상품 리스트 보기</h2>
	<div class="row placeholders product-content">
		<lee:forEach items="${ requestScope.productList }" var="list" varStatus="no">
			<div id="product${ no.count }" class="col-sm-4 products">
				<div>
					<a href="/HwangDangFleamarket/product/detail.go?page=${ param.page }&productId=${ list.productId }&sellerStoreNo=${ param.sellerStoreNo }&sellerStoreImage=${ param.sellerStoreImage }">
						<img class="mainImage" src="../image_storage/${ list.productMainImage }"  style="width:200px;height:170px;">
					</a>
				</div>
				<div>${ list.productName }<br>${ list.productPrice }</div>
			</div>
		</lee:forEach>
	<div id="page" class="pageGroup">
		<!-- 
			이전 페이지 그룹 처리.
			만약, 이전페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리. 
		-->
			<lee:choose>
				<lee:when test="${ requestScope.bean.previousPageGroup }">
					<a href = "/HwangDangFleamarket/product/list.go?page=${ requestScope.bean.beginPage-1 }&sellerStoreNo=${param.sellerStoreNo}&sellerStoreImage=${ param.sellerStoreImage }">◁</a>
				</lee:when>
				<lee:otherwise>
					<font color="#47C83E">◁</font>
				</lee:otherwise>
			</lee:choose>
			
			<!-- 
				현재 페이지가 속한 페이지 그룹내의 페이지들 링크.
				현재 페이지그룹의 시작페이지~ 끝페이지
			 -->
			 <!-- 만약 page가 현재페이지라면 링크 처리를 하지않고, 현재 페이지가 아니라면 링크처리. -->
			<lee:forEach begin="${ requestScope.bean.beginPage }" end="${ requestScope.bean.endPage }" var="page">
				<lee:choose>
					<lee:when test="${ page != requestScope.bean.page }">
						<a href = "/HwangDangFleamarket/product/list.go?page=${ page }&sellerStoreNo=${param.sellerStoreNo}&sellerStoreImage=${ param.sellerStoreImage }">${ page }</a>
					</lee:when>
					<lee:otherwise>
						<font color="#47C83E">${ page }</font>
					</lee:otherwise>
				</lee:choose>
			</lee:forEach>
			
			<!-- 
				다음 페이지 그룹 처리.
				만약, 다음페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리. 
			-->
			<lee:choose>
				<lee:when test="${ requestScope.bean.nextPageGroup }">
					<a href = "/HwangDangFleamarket/product/list.go?page=${ requestScope.bean.endPage+1 }&sellerStoreNo=${param.sellerStoreNo}&sellerStoreImage=${ param.sellerStoreImage }">▷</a>
				</lee:when>
				<lee:otherwise>
					<font color="#47C83E">▷</font>
				</lee:otherwise>
			</lee:choose>
			<lee:if test="${sessionScope.seller.sellerStoreNo == param.sellerStoreNo}">
		</lee:if>
	</div>
	<div class="registerProductBtn">
		<span class="registerProductBtn">
			<input type="button" value="상품 등록" onclick="window.location='/HwangDangFleamarket/product/registerProductForm.go?page=${param.page}&sellerStoreNo=${param.sellerStoreNo}&sellerStoreImage=${ param.sellerStoreImage }'">&nbsp;&nbsp;
		</span>
	</div>
</div>