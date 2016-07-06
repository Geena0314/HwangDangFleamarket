<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
/* .sideMenu2{
	position: fixed;
	width: 200px;
}
.store_img{
	float: left;
	position: absolute;
}
.buttons{
	float: left;
	padding-top: 230px;
}
.buttons input{
	width: 130px;
	height: 70px;
	margin: 20px;
	padding: 5px;
	text-align: center;
}
/* button{
	width: 150px;
	height: 50px;
	padding: 5px;
	margin-bottom: 50px;
	margin-left: 25px;
} */
button.basic{
	width: 150px;
	height: 50px;
	padding: 5px;
	margin-bottom: 50px;
	margin-left: 25px;
}
img{
	border-radius: 100px;
	overflow: hidden;
	width: 200px;
	height: 200px;
	background-repeat: repeat;
}
a{
	text-decoration: none;
	color: black;
}
a:HOVER {
	text-decoration: underline;
	color: silver;
}
table ,tr{
	border: 3px solid lightgray;
} */
</style>
<div class="col-sm-3 col-md-2 sidebar" id="sideMenu2">
	<ul class="nav nav-sidebar">
		<li class="active">
			<div class="store_img">
			<a href="#"><img id="storeMainImage" src="../image_storage/${param.sellerStoreImage}"></a>
			</div>
		</li>
        <li><input class="btn btn-lg btn-default btn-block" type="button" value="스토어 소개"></li>
        <li><input class="btn btn-lg btn-default btn-block" type="button" value="상품 목록" onclick="window.location='/HwangDangFleamarket/product/list.go?page=1&sellerStoreNo=${param.sellerStoreNo}&sellerStoreImage=${param.sellerStoreImage}'"></li>
        <li><input class="btn btn-lg btn-default btn-block" type="button" value="스토어 소식" onclick="window.location='/HwangDangFleamarket/sellerNotice/sellerNotice.go?page=1&sellerStoreNo=${param.sellerStoreNo}&sellerStoreImage=${param.sellerStoreImage}'"></li>
        </ul>
</div>
