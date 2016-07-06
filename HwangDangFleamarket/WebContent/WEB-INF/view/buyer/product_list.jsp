<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	img {
		width : 150px;
		height : 80 px;
	}
</style>
조회결과
<hr/>
<c:forEach items="${requestScope.productList }" var="p">
	<img src="/HwangDangFleamarket/image_storage/${p.productMainImage }"/> ${p.productName } ${p.productPrice }  ${p.productInfo } ${p.productLike }  <br/>
</c:forEach>