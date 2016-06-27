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
<h2>황당 플리마켓 Stores</h2>
<div class="seller_listing">
	<ul>
		<c:forEach items="${requestScope.list}" var="list">
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
					<li class="introduction">
						${list.sellerIntroduction}
					</li>
				</ul>
				<div class="store_products">
					<ul class="product_list">
						<c:if test="${list.sellerProduct1!=null}">
							<li>${list.sellerProduct1}</li><br>
						</c:if>
						<c:if test="${list.sellerProduct2!=null}">
							<li>${list.sellerProduct2}</li><br>
						</c:if>
						<c:if test="${list.sellerProduct3!=null}">
							<li>${list.sellerProduct3}</li><br>
						</c:if>
					</ul>
				</div>
			</li>
		</c:forEach>
	</ul>
</div>

<p align="center">
	<%-- ◀이전 페이지 그룹 처리 --%>
<c:choose>
	<c:when test="${requestScope.pagingBean.previousPageGroup}">
		<a href="/HwangDangFleamarket/admin/adminNotice.go?page=${requestScope.pagingBean.beginPage-1}">
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
			<a href="/HwangDangFleamarket/admin/adminNotice.go?page=${page}">
				${page} 
			</a>
		</c:otherwise>
	</c:choose>
&nbsp;&nbsp;
</c:forEach>
	<%--다음 페이지 그룹 처리 ▶--%>
	<c:choose>
		<c:when test="${requestScope.pagingBean.nextPageGroup}">
			<a href="/HwangDangFleamarket/admin/adminNotice.go?page=${requestScope.pagingBean.endPage+1}">
				▶
			</a>
		</c:when>
		<c:otherwise>▶</c:otherwise>
	</c:choose>
</p>