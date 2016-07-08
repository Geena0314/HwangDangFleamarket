<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
/* div.seller_listing{
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
} */
.seller-list:hover{
	border: 2px solid green; 
}
</style>
<h2 class="page-header store_look_around">황당 플리마켓 Stores</h2>
<!-- <div class="seller_listing"> -->
<div class="row placeholders store_look_around">
<div class="seller_listing">
	<ul>
		<c:forEach items="${requestScope.list}" var="list">
			<div class="col-sm-4 seller-list" id="list_block">
				<div class="list-margins">
					<div class="thmb">
						<div class="store_img">
							<a href="/HwangDangFleamarket/seller/sellerStore.go?sellerStoreNo=${list.sellerStoreNo}&sellerStoreImage=${list.sellerStoreImage}"><img class="sellerListImage" src="../image_storage/${list.sellerStoreImage}"></a>
						</div>
					</div>
					<div class="store_info">
							<a href="/HwangDangFleamarket/seller/sellerStore.go?sellerStoreNo=${list.sellerStoreNo}&sellerStoreImage=${list.sellerStoreImage}">${list.sellerStoreName}</a>
						<div class="introduction">
							${list.sellerIntroduction}
						</div>
					</div>
					<div class="store_products">
						<div class="product_list">
							<c:if test="${list.sellerProduct1!=null}">
								#${list.sellerProduct1}<br>
							</c:if>
							<c:if test="${list.sellerProduct2!=null}">
								#${list.sellerProduct2}<br>
							</c:if>
							<c:if test="${list.sellerProduct3!=null}">
								#${list.sellerProduct3}<br>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</ul>
</div>

<div align="center" class="pageGroup">
	<%-- ◀이전 페이지 그룹 처리 --%>
<c:choose>
	<c:when test="${requestScope.pagingBean.previousPageGroup}">
		<a href="/HwangDangFleamarket/seller/sellerList.go?page=${requestScope.pagingBean.beginPage-1}">
			◀ 
		</a>
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
			<a href="/HwangDangFleamarket/seller/sellerList.go?page=${page}">
				${page} 
			</a>
		</c:otherwise>
	</c:choose>
&nbsp;&nbsp;
</c:forEach>
	<%--다음 페이지 그룹 처리 ▶--%>
	<c:choose>
		<c:when test="${requestScope.pagingBean.nextPageGroup}">
			<a href="/HwangDangFleamarket/seller/sellerList.go?page=${requestScope.pagingBean.endPage+1}">
				▶
			</a>
		</c:when>
		<c:otherwise>▶</c:otherwise>
	</c:choose>
</div>
</div>