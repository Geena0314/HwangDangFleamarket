<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
.sideMenu2{
	
}
input{
	width: 150px;
	height: 70px;
	padding: 5px;
	margin-bottom: 50px;
	margin-left: 25px;
}
img{
	border-radius: 100px;
	overflow: hidden;
	width: 200px;
	height: 200px;
}
.buttons{
	padding-top: 30px;
}
</style>
<div class="sideMenu2">
	<div class="store_img">
		<a href="#"><img src="../image_storage/${requestScope.seller.sellerStoreImage}.jpg"></a>
	</div>
	<div class="buttons">
		<input type="button" value="스토어 소개">
		<input type="button" value="상품 목록">
		<input type="button" value="스토어 소식">
	</div>
</div>

